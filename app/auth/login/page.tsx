'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { identifyUser, trackEvent } from '@/lib/analytics';
import { Mail, Lock, AlertCircle, Loader2, Eye, EyeOff, ArrowRight, Shield, Zap, CheckCircle2 } from 'lucide-react';
import Logo from '@/components/Logo';

export default function LoginPage() {
    const router = useRouter();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [loading, setLoading] = useState(false);
    const [googleLoading, setGoogleLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleGoogleLogin = async () => {
        setGoogleLoading(true);
        setError(null);
        trackEvent('login_google_started');

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

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password,
        });

        if (error) {
            if (error.message.toLowerCase().includes('email not confirmed')) {
                setError('Seu e-mail ainda não foi verificado. Verifique sua caixa de entrada e clique no link de confirmação.');
            } else if (error.message === 'Invalid login credentials') {
                setError('E-mail ou senha incorretos.');
            } else {
                setError(error.message);
            }
            setLoading(false);
        } else {
            if (data?.user?.id) {
                identifyUser(data.user.id, { email });
            }
            trackEvent('login_success');
            router.push('/app');
            router.refresh();
        }
    };

    const benefits = [
        { icon: Zap, text: 'Geração ilimitada de flashcards' },
        { icon: Shield, text: 'Seus dados sempre protegidos' },
        { icon: CheckCircle2, text: 'Exportação para Anki e Quizlet' },
    ];

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
                            Bem-vindo de volta
                        </m.h1>
                        <p className="text-foreground/60 font-medium text-sm">Entre com suas credenciais para continuar.</p>
                    </div>

                    {/* Auth Card */}
                    <m.div
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.15 }}
                        className="bg-white border border-border p-8 rounded-sm shadow-sm"
                    >
                        {/* Google OAuth Button */}
                        <button
                            type="button"
                            onClick={handleGoogleLogin}
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

                        <form onSubmit={handleLogin} className="space-y-4">
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
                                <div className="flex justify-between items-center">
                                    <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="password">
                                        Senha
                                    </label>
                                    <Link href="/auth/reset" className="text-[10px] font-bold uppercase tracking-widest text-brand hover:underline">
                                        Esqueceu a senha?
                                    </Link>
                                </div>
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

                            <button
                                disabled={loading}
                                className="group w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                            >
                                {loading ? (
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                ) : (
                                    <>
                                        Entrar na Conta
                                        <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                    </>
                                )}
                            </button>
                        </form>
                    </m.div>

                    {/* Benefits */}
                    <m.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.3 }}
                        className="mt-8 grid grid-cols-3 gap-2"
                    >
                        {benefits.map((benefit, index) => (
                            <div key={index} className="text-center p-2">
                                <benefit.icon className="h-4 w-4 text-brand mx-auto mb-1" />
                                <span className="text-[10px] font-medium text-foreground/50 leading-tight block">{benefit.text}</span>
                            </div>
                        ))}
                    </m.div>

                    <p className="mt-8 text-center text-sm font-medium text-foreground/40">
                        Ainda não tem conta?{' '}
                        <Link href="/auth/signup" className="text-brand hover:underline font-bold">
                            Criar conta grátis
                        </Link>
                    </p>
                </m.div>
            </div>
        </LazyMotion>
    );
}
