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
    const [error, setError] = useState<string | null>(null);

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        const { data, error } = await supabase.auth.signInWithPassword({
            email,
            password,
        });

        if (error) {
            setError(error.message);
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
