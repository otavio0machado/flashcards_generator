'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { trackEvent } from '@/lib/analytics';
import { ArrowRight, User, Mail, Lock, AlertCircle, Loader2, Eye, EyeOff, Zap, Shield, Download, RefreshCw } from 'lucide-react';
import Logo from '@/components/Logo';

export default function SignupPage() {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [confirmEmail, setConfirmEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [loading, setLoading] = useState(false);
    const [googleLoading, setGoogleLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [success, setSuccess] = useState(false);
    const [resending, setResending] = useState(false);
    const [resendCooldown, setResendCooldown] = useState(0);

    useEffect(() => {
        trackEvent('signup_view', { source: 'signup_page' });
    }, []);

    useEffect(() => {
        const handleUnload = () => {
            if (!success) {
                trackEvent('signup_abandoned', { source: 'signup_page' });
            }
        };

        window.addEventListener('beforeunload', handleUnload);
        return () => window.removeEventListener('beforeunload', handleUnload);
    }, [success]);

    const validatePassword = (pass: string) => {
        const minLength = pass.length >= 8;
        const hasUpper = /[A-Z]/.test(pass);
        const hasLower = /[a-z]/.test(pass);
        const hasNumber = /[0-9]/.test(pass);
        const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(pass);
        return minLength && hasUpper && hasLower && hasNumber && hasSpecial;
    };

    const handleGoogleSignup = async () => {
        setGoogleLoading(true);
        setError(null);
        trackEvent('signup_google_started');

        const { error } = await supabase.auth.signInWithOAuth({
            provider: 'google',
            options: {
                redirectTo: window.location.origin + '/auth/callback',
            },
        });

        if (error) {
            setError(error.message);
            setGoogleLoading(false);
        }
    };

    const handleSignup = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);
        trackEvent('signup_started', { method: 'password' });

        // Validation
        if (email !== confirmEmail) {
            setError('Os e-mails não coincidem.');
            setLoading(false);
            return;
        }

        if (!validatePassword(password)) {
            setError('A senha deve ter pelo menos 8 caracteres, incluindo uma letra maiúscula, uma minúscula, um número e um caractere especial.');
            setLoading(false);
            return;
        }

        if (password !== confirmPassword) {
            setError('As senhas não coincidem.');
            setLoading(false);
            return;
        }

        const response = await fetch('/api/auth/signup', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name, email, password })
        });

        const data = await response.json().catch(() => ({}));

        if (!response.ok) {
            setError(data?.error || 'Erro ao criar conta.');
            setLoading(false);
            return;
        }

        trackEvent('signup_completed', { method: 'password' });
        setSuccess(true);
        setLoading(false);
    };

    const handleResendVerification = async () => {
        if (resendCooldown > 0) return;
        setResending(true);
        try {
            const { error: resendError } = await supabase.auth.resend({
                type: 'signup',
                email,
            });
            if (resendError) {
                trackEvent('resend_verification_error', { error: resendError.message });
            } else {
                trackEvent('resend_verification_sent', { email });
                setResendCooldown(60);
                const interval = setInterval(() => {
                    setResendCooldown((prev) => {
                        if (prev <= 1) {
                            clearInterval(interval);
                            return 0;
                        }
                        return prev - 1;
                    });
                }, 1000);
            }
        } finally {
            setResending(false);
        }
    };

    const benefits = [
        { icon: Zap, text: 'Geração por IA' },
        { icon: Shield, text: 'Dados protegidos' },
        { icon: Download, text: 'Exportação Anki' },
    ];

    if (success) {
        return (
            <LazyMotion features={domAnimation}>
                <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
                    <m.div
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        className="w-full max-w-[400px] text-center bg-white border border-border p-10 rounded-sm shadow-sm"
                    >
                        <m.div
                            initial={{ scale: 0 }}
                            animate={{ scale: 1 }}
                            transition={{ type: 'spring', stiffness: 200 }}
                            className="bg-blue-50 w-20 h-20 rounded-full flex items-center justify-center mb-6 mx-auto"
                        >
                            <Mail className="h-10 w-10 text-blue-500" />
                        </m.div>
                        <h2 className="text-2xl font-bold mb-3">Verifique seu e-mail</h2>
                        <p className="text-foreground/60 font-medium mb-2 leading-relaxed">
                            Enviamos um link de confirmação para:
                        </p>
                        <p className="text-sm font-bold text-foreground mb-6">{email}</p>
                        <p className="text-foreground/50 text-xs font-medium mb-6 leading-relaxed">
                            Clique no link do e-mail para ativar sua conta. Verifique também a pasta de spam.
                        </p>
                        <div className="space-y-3">
                            <button
                                onClick={handleResendVerification}
                                disabled={resending || resendCooldown > 0}
                                className="w-full inline-flex items-center justify-center gap-2 bg-brand text-white px-6 py-3 rounded-sm font-bold hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                {resending ? (
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                ) : (
                                    <RefreshCw className="h-4 w-4" />
                                )}
                                {resendCooldown > 0
                                    ? `Reenviar em ${resendCooldown}s`
                                    : 'Reenviar e-mail'}
                            </button>
                            <Link
                                href="/auth/login"
                                className="block w-full bg-white border border-border py-3 px-6 rounded-sm font-bold text-sm hover:bg-gray-50 transition-all text-center"
                            >
                                Ir para o Login
                            </Link>
                        </div>
                    </m.div>
                </div>
            </LazyMotion>
        );
    }

    return (
        <LazyMotion features={domAnimation}>
            <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="w-full max-w-[400px]"
                >
                    {/* Header */}
                    <div className="text-center mb-10">
                        <Link href="/" className="inline-flex items-center mb-6 group">
                            <Logo
                                className="h-14 w-[200px] transform group-hover:scale-105 transition-transform"
                                priority
                            />
                        </Link>
                        <m.h1
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: 0.1 }}
                            className="text-3xl font-bold tracking-tight mb-2"
                        >
                            Comece a estudar melhor
                        </m.h1>
                        <p className="text-foreground/60 font-medium text-sm">Crie sua conta gratuita em poucos segundos.</p>
                    </div>

                    {/* Benefits */}
                    <m.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.15 }}
                        className="mb-6 grid grid-cols-3 gap-2"
                    >
                        {benefits.map((benefit, index) => (
                            <div key={index} className="text-center p-2 bg-white border border-border rounded-sm">
                                <benefit.icon className="h-4 w-4 text-brand mx-auto mb-1" />
                                <span className="text-[10px] font-medium text-foreground/50 leading-tight block">{benefit.text}</span>
                            </div>
                        ))}
                    </m.div>

                    {/* Auth Card */}
                    <m.div
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.2 }}
                        className="bg-white border border-border p-8 rounded-sm shadow-sm"
                    >
                        {/* Google OAuth Button */}
                        <button
                            type="button"
                            onClick={handleGoogleSignup}
                            disabled={googleLoading || loading}
                            className="w-full bg-white border border-border rounded-sm font-bold text-sm py-3 hover:bg-gray-50 transition-all flex items-center justify-center gap-3 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                            {googleLoading ? (
                                <Loader2 className="h-4 w-4 animate-spin" />
                            ) : (
                                <>
                                    <svg width="18" height="18" viewBox="0 0 48 48" aria-hidden="true">
                                        <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/>
                                        <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/>
                                        <path fill="#FBBC05" d="M10.53 28.59a14.5 14.5 0 0 1 0-9.18l-7.98-6.19a24.0 24.0 0 0 0 0 21.56l7.98-6.19z"/>
                                        <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/>
                                        <path fill="none" d="M0 0h48v48H0z"/>
                                    </svg>
                                    Continuar com Google
                                </>
                            )}
                        </button>

                        {/* Divider */}
                        <div className="relative my-6">
                            <div className="absolute inset-0 flex items-center">
                                <div className="w-full border-t border-border" />
                            </div>
                            <div className="relative flex justify-center">
                                <span className="bg-white px-4 text-xs font-bold text-foreground/30 uppercase tracking-widest">ou</span>
                            </div>
                        </div>

                        <form onSubmit={handleSignup} className="space-y-4">
                            {error && (
                                <m.div
                                    initial={{ opacity: 0, y: -10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    role="alert"
                                    aria-live="assertive"
                                    className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold"
                                >
                                    <AlertCircle className="h-4 w-4 shrink-0" />
                                    {error}
                                </m.div>
                            )}

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="name">
                                    Nome Completo
                                </label>
                                <div className="relative">
                                    <User className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/20" />
                                    <input
                                        id="name"
                                        type="text"
                                        placeholder="Seu nome"
                                        value={name}
                                        onChange={(e) => setName(e.target.value)}
                                        className="w-full bg-gray-50 border border-border px-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                        required
                                    />
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="email">
                                    E-mail
                                </label>
                                <div className="relative">
                                    <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/20" />
                                    <input
                                        id="email"
                                        type="email"
                                        placeholder="seu@email.com"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                        className="w-full bg-gray-50 border border-border px-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                        required
                                    />
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="confirmEmail">
                                    Confirmar E-mail
                                </label>
                                <div className="relative">
                                    <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/20" />
                                    <input
                                        id="confirmEmail"
                                        type="email"
                                        placeholder="Confirme seu e-mail"
                                        value={confirmEmail}
                                        onChange={(e) => setConfirmEmail(e.target.value)}
                                        className="w-full bg-gray-50 border border-border px-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                        required
                                    />
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="password">
                                    Senha (8+ caracteres, A-z, 0-9, !@#)
                                </label>
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/20" />
                                    <input
                                        id="password"
                                        type={showPassword ? 'text' : 'password'}
                                        placeholder="••••••••"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                        className="w-full bg-gray-50 border border-border pl-10 pr-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                        required
                                    />
                                    <button
                                        type="button"
                                        onClick={() => setShowPassword((prev) => !prev)}
                                        className="absolute right-3 top-1/2 -translate-y-1/2 text-foreground/40 hover:text-foreground transition-colors"
                                        aria-label={showPassword ? 'Ocultar senha' : 'Mostrar senha'}
                                    >
                                        {showPassword ? (
                                            <EyeOff className="h-4 w-4" />
                                        ) : (
                                            <Eye className="h-4 w-4" />
                                        )}
                                    </button>
                                </div>
                            </div>

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="confirmPassword">
                                    Confirmar Senha
                                </label>
                                <div className="relative">
                                    <Lock className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/20" />
                                    <input
                                        id="confirmPassword"
                                        type={showConfirmPassword ? 'text' : 'password'}
                                        placeholder="Confirme sua senha"
                                        value={confirmPassword}
                                        onChange={(e) => setConfirmPassword(e.target.value)}
                                        className="w-full bg-gray-50 border border-border pl-10 pr-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                        required
                                    />
                                    <button
                                        type="button"
                                        onClick={() => setShowConfirmPassword((prev) => !prev)}
                                        className="absolute right-3 top-1/2 -translate-y-1/2 text-foreground/40 hover:text-foreground transition-colors"
                                        aria-label={showConfirmPassword ? 'Ocultar senha' : 'Mostrar senha'}
                                    >
                                        {showConfirmPassword ? (
                                            <EyeOff className="h-4 w-4" />
                                        ) : (
                                            <Eye className="h-4 w-4" />
                                        )}
                                    </button>
                                </div>
                            </div>

                            <button
                                disabled={loading}
                                className="group w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                            >
                                {loading ? (
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                ) : (
                                    <>
                                        Criar Minha Conta
                                        <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                    </>
                                )}
                            </button>
                        </form>

                        <p className="mt-6 text-[11px] text-center text-foreground/40 font-medium leading-relaxed">
                            Ao se cadastrar, você concorda com nossos <Link href="/terms" className="underline">Termos de Uso</Link> e <Link href="/privacy" className="underline">Política de Privacidade</Link>.
                        </p>
                    </m.div>

                    <p className="mt-8 text-center text-sm font-medium text-foreground/40">
                        Já tem uma conta?{' '}
                        <Link href="/auth/login" className="text-brand hover:underline font-bold">
                            Entrar agora
                        </Link>
                    </p>
                </m.div>
            </div>
        </LazyMotion>
    );
}
