'use client';

import { useState, useEffect, useRef, useCallback } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import {
    Sparkles,
    Mail,
    Lock,
    Eye,
    EyeOff,
    ArrowRight,
    User,
    Loader2,
    ExternalLink
} from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { isTauriApp } from '@/lib/tauri';
import { completeOnboarding, setOnboardingStep } from '@/lib/desktop-onboarding';
import OnboardingProgressDots from '@/components/OnboardingProgressDots';

type Mode = 'login' | 'signup';

// Translate common Supabase errors to Portuguese
function translateError(message: string): string {
    const translations: Record<string, string> = {
        'Invalid login credentials': 'Email ou senha incorretos',
        'Email not confirmed': 'Email não confirmado. Verifique sua caixa de entrada.',
        'User already registered': 'Este email já está cadastrado',
        'Password should be at least 6 characters': 'A senha deve ter pelo menos 8 caracteres',
        'Password should be at least 8 characters': 'A senha deve ter pelo menos 8 caracteres',
        'Signup requires a valid password': 'Insira uma senha válida',
        'To signup, please provide your email': 'Insira um email válido',
        'Unable to validate email address: invalid format': 'Formato de email inválido',
        'Email rate limit exceeded': 'Muitas tentativas. Aguarde alguns minutos.',
        'For security purposes, you can only request this after': 'Por segurança, aguarde antes de tentar novamente.',
    };
    for (const [key, value] of Object.entries(translations)) {
        if (message.includes(key)) return value;
    }
    return message;
}

// Password strength meter
function getPasswordStrength(pwd: string): { level: number; label: string; color: string } {
    if (!pwd) return { level: 0, label: '', color: '' };
    let score = 0;
    if (pwd.length >= 8) score++;
    if (pwd.length >= 12) score++;
    if (/[A-Z]/.test(pwd)) score++;
    if (/[0-9]/.test(pwd)) score++;
    if (/[^A-Za-z0-9]/.test(pwd)) score++;

    const levels = [
        { label: 'Muito fraca', color: 'bg-red-500' },
        { label: 'Fraca', color: 'bg-orange-500' },
        { label: 'Razoável', color: 'bg-yellow-500' },
        { label: 'Forte', color: 'bg-green-500' },
        { label: 'Muito forte', color: 'bg-green-600' },
    ];
    const idx = Math.min(score, 4);
    return { level: score, ...levels[idx] };
}

export default function DesktopLoginPage() {
    const router = useRouter();
    const [mode, setMode] = useState<Mode>('signup');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [name, setName] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');
    const [oAuthPending, setOAuthPending] = useState(false);
    const pollIntervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

    useEffect(() => {
        setOnboardingStep('login');
        if (!isTauriApp()) {
            router.replace('/');
            return;
        }

        // Do NOT auto-redirect even if already logged in.
        // The user must explicitly log in each time.

        return () => {
            if (pollIntervalRef.current) clearInterval(pollIntervalRef.current);
        };
    }, [router]);

    const passwordStrength = mode === 'signup' ? getPasswordStrength(password) : null;

    const pollForSession = useCallback(() => {
        let attempts = 0;
        const maxAttempts = 60; // 2 minutes at 2s intervals

        pollIntervalRef.current = setInterval(async () => {
            attempts++;
            try {
                const { data: { session } } = await supabase.auth.getSession();
                if (session) {
                    if (pollIntervalRef.current) clearInterval(pollIntervalRef.current);
                    setOAuthPending(false);
                    setLoading(false);
                    completeOnboarding();
                    router.replace('/app');
                }
            } catch {
                // Keep polling
            }

            if (attempts >= maxAttempts) {
                if (pollIntervalRef.current) clearInterval(pollIntervalRef.current);
                setOAuthPending(false);
                setLoading(false);
                setError('Tempo esgotado. Tente novamente.');
            }
        }, 2000);
    }, [router]);

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        try {
            if (mode === 'signup') {
                const { error } = await supabase.auth.signUp({
                    email,
                    password,
                    options: {
                        data: { full_name: name },
                    },
                });
                if (error) throw error;

                completeOnboarding();
                router.replace('/app');
            } else {
                const { error } = await supabase.auth.signInWithPassword({
                    email,
                    password,
                });
                if (error) throw error;

                completeOnboarding();
                router.replace('/app');
            }
        } catch (err: unknown) {
            const rawMessage = err instanceof Error ? err.message : 'Ocorreu um erro inesperado';
            setError(translateError(rawMessage));
        } finally {
            setLoading(false);
        }
    };

    const handleGoogleLogin = async () => {
        setLoading(true);
        setError('');

        try {
            if (isTauriApp()) {
                // Desktop: open OAuth in system browser, then poll for session
                const { data, error } = await supabase.auth.signInWithOAuth({
                    provider: 'google',
                    options: {
                        redirectTo: `${process.env.NEXT_PUBLIC_SITE_URL || 'https://www.flashcards-generator.com'}/auth/callback`,
                        skipBrowserRedirect: true,
                    },
                });
                if (error) throw error;

                if (data?.url) {
                    // Open in system browser
                    try {
                        const { open } = await import('@tauri-apps/plugin-shell');
                        await open(data.url);
                    } catch {
                        // Fallback: open via window.open
                        window.open(data.url, '_blank');
                    }
                    setOAuthPending(true);
                    pollForSession();
                }
            } else {
                // Web: normal redirect
                const { error } = await supabase.auth.signInWithOAuth({
                    provider: 'google',
                    options: {
                        redirectTo: `${window.location.origin}/auth/callback`,
                    },
                });
                if (error) throw error;
                completeOnboarding();
            }
        } catch (err: unknown) {
            const rawMessage = err instanceof Error ? err.message : 'Ocorreu um erro';
            setError(translateError(rawMessage));
            setLoading(false);
        }
    };

    const cancelOAuth = () => {
        if (pollIntervalRef.current) clearInterval(pollIntervalRef.current);
        setOAuthPending(false);
        setLoading(false);
    };

    return (
        <div className="fixed inset-0 flex items-center justify-center p-6 bg-[var(--background)]">
            <div className="w-full max-w-sm">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 16 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="text-center mb-6"
                >
                    <div className="mx-auto mb-5 w-14 h-14 bg-brand rounded-xl flex items-center justify-center">
                        <Sparkles className="w-7 h-7 text-white" />
                    </div>
                    <h1 className="text-2xl font-bold text-[var(--foreground)] tracking-tight">
                        {mode === 'login' ? 'Entrar' : 'Criar conta'}
                    </h1>
                    <p className="text-sm text-[var(--color-text-secondary)] mt-1">
                        {mode === 'login'
                            ? 'Continue de onde parou'
                            : 'Comece a estudar em segundos'}
                    </p>
                </motion.div>

                {/* Progress Indicator */}
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.1 }}
                    className="mb-6"
                >
                    <OnboardingProgressDots currentStep={3} />
                </motion.div>

                {/* Form Card */}
                <motion.div
                    initial={{ opacity: 0, y: 12 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.15 }}
                    className="bg-[var(--surface,var(--background))] rounded-xl border border-[var(--color-border)] p-6"
                >
                    {/* OAuth Pending State */}
                    {oAuthPending ? (
                        <div className="text-center py-6">
                            <ExternalLink className="w-10 h-10 text-brand mx-auto mb-4" />
                            <p className="text-sm font-medium text-[var(--foreground)] mb-2">
                                Complete o login no navegador
                            </p>
                            <p className="text-xs text-[var(--color-text-secondary)] mb-5">
                                Após fazer login no Google, volte aqui automaticamente.
                            </p>
                            <div className="flex items-center justify-center gap-2 mb-4">
                                <Loader2 className="w-4 h-4 text-brand animate-spin" />
                                <span className="text-xs text-[var(--color-text-secondary)]">Aguardando login...</span>
                            </div>
                            <button
                                onClick={cancelOAuth}
                                type="button"
                                className="text-sm text-[var(--color-text-secondary)] hover:text-[var(--foreground)] focus:outline-none focus:underline transition-colors"
                            >
                                Cancelar
                            </button>
                        </div>
                    ) : (
                        <>
                            {/* Google Login */}
                            <button
                                onClick={handleGoogleLogin}
                                disabled={loading}
                                type="button"
                                className="w-full flex items-center justify-center gap-2.5 px-4 py-3 bg-[var(--background)] border border-[var(--color-border)] rounded-lg font-medium text-[var(--foreground)] hover:bg-[var(--surface-muted,var(--surface))] focus:outline-none focus:ring-2 focus:ring-brand focus:ring-offset-2 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                <svg className="w-5 h-5" viewBox="0 0 24 24">
                                    <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" />
                                    <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" />
                                    <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" />
                                    <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" />
                                </svg>
                                <span>Continuar com Google</span>
                            </button>

                            {/* Divider */}
                            <div className="relative my-5">
                                <div className="absolute inset-0 flex items-center">
                                    <div className="w-full border-t border-[var(--color-border)]" />
                                </div>
                                <div className="relative flex justify-center text-xs">
                                    <span className="px-3 bg-[var(--surface,var(--background))] text-[var(--color-text-secondary)]">ou</span>
                                </div>
                            </div>

                            {/* Form */}
                            <form onSubmit={handleSubmit} className="space-y-4">
                                {mode === 'signup' && (
                                    <div>
                                        <label className="block text-sm font-medium text-[var(--foreground)] mb-1.5">
                                            Nome
                                        </label>
                                        <div className="relative">
                                            <User className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[var(--color-text-secondary)]" />
                                            <input
                                                type="text"
                                                value={name}
                                                onChange={(e) => setName(e.target.value)}
                                                placeholder="Seu nome"
                                                className="w-full pl-10 pr-4 py-2.5 bg-[var(--background)] border border-[var(--color-border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent text-[var(--foreground)] placeholder:text-[var(--color-text-secondary)] text-sm"
                                                required
                                            />
                                        </div>
                                    </div>
                                )}

                                <div>
                                    <label className="block text-sm font-medium text-[var(--foreground)] mb-1.5">
                                        Email
                                    </label>
                                    <div className="relative">
                                        <Mail className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[var(--color-text-secondary)]" />
                                        <input
                                            type="email"
                                            value={email}
                                            onChange={(e) => setEmail(e.target.value)}
                                            placeholder="seu@email.com"
                                            className="w-full pl-10 pr-4 py-2.5 bg-[var(--background)] border border-[var(--color-border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent text-[var(--foreground)] placeholder:text-[var(--color-text-secondary)] text-sm"
                                            required
                                        />
                                    </div>
                                </div>

                                <div>
                                    <div className="flex items-center justify-between mb-1.5">
                                        <label className="block text-sm font-medium text-[var(--foreground)]">
                                            Senha
                                        </label>
                                        {mode === 'login' && (
                                            <button
                                                type="button"
                                                onClick={() => router.push('/auth/reset')}
                                                className="text-xs text-brand hover:underline"
                                            >
                                                Esqueceu a senha?
                                            </button>
                                        )}
                                    </div>
                                    <div className="relative">
                                        <Lock className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-[var(--color-text-secondary)]" />
                                        <input
                                            type={showPassword ? 'text' : 'password'}
                                            value={password}
                                            onChange={(e) => setPassword(e.target.value)}
                                            placeholder="••••••••"
                                            className="w-full pl-10 pr-10 py-2.5 bg-[var(--background)] border border-[var(--color-border)] rounded-lg focus:outline-none focus:ring-2 focus:ring-brand focus:border-transparent text-[var(--foreground)] placeholder:text-[var(--color-text-secondary)] text-sm"
                                            required
                                            minLength={8}
                                        />
                                        <button
                                            type="button"
                                            onClick={() => setShowPassword(!showPassword)}
                                            className="absolute right-3 top-1/2 -translate-y-1/2 text-[var(--color-text-secondary)] hover:text-[var(--foreground)]"
                                        >
                                            {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                                        </button>
                                    </div>

                                    {/* Password Strength Indicator */}
                                    {mode === 'signup' && password && passwordStrength && (
                                        <div className="mt-2">
                                            <div className="flex gap-1 mb-1">
                                                {[0, 1, 2, 3, 4].map((i) => (
                                                    <div
                                                        key={i}
                                                        className={`h-1 flex-1 rounded-full transition-colors ${i < passwordStrength.level
                                                                ? passwordStrength.color
                                                                : 'bg-[var(--color-border)]'
                                                            }`}
                                                    />
                                                ))}
                                            </div>
                                            <p className="text-[11px] text-[var(--color-text-secondary)]">
                                                {passwordStrength.label}
                                            </p>
                                        </div>
                                    )}
                                </div>

                                {error && (
                                    <p className="text-red-600 dark:text-red-400 text-sm text-center bg-red-50 dark:bg-red-950/30 p-2.5 rounded-lg border border-red-100 dark:border-red-900/50">
                                        {error}
                                    </p>
                                )}

                                <button
                                    type="submit"
                                    disabled={loading}
                                    className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 focus:outline-none focus:ring-2 focus:ring-brand focus:ring-offset-2 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                                >
                                    {loading ? (
                                        <Loader2 className="w-4 h-4 animate-spin" />
                                    ) : (
                                        <>
                                            <span>{mode === 'login' ? 'Entrar' : 'Criar Conta'}</span>
                                            <ArrowRight className="w-4 h-4" />
                                        </>
                                    )}
                                </button>
                            </form>

                            {/* Toggle Mode */}
                            <p className="text-center text-sm text-[var(--color-text-secondary)] mt-5">
                                {mode === 'login' ? (
                                    <>
                                        Não tem conta?{' '}
                                        <button
                                            onClick={() => { setMode('signup'); setError(''); }}
                                            className="text-brand font-semibold hover:underline"
                                        >
                                            Criar conta
                                        </button>
                                    </>
                                ) : (
                                    <>
                                        Já tem conta?{' '}
                                        <button
                                            onClick={() => { setMode('login'); setError(''); }}
                                            className="text-brand font-semibold hover:underline"
                                        >
                                            Entrar
                                        </button>
                                    </>
                                )}
                            </p>
                        </>
                    )}
                </motion.div>
            </div>
        </div>
    );
}
