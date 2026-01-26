'use client';

import React, { useState, useEffect } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { identifyUser, trackEvent } from '@/lib/analytics';
import { ArrowRight, User, Mail, Lock, AlertCircle, Loader2, CheckCircle2, Eye, EyeOff } from 'lucide-react';
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
    const [error, setError] = useState<string | null>(null);
    const [success, setSuccess] = useState(false);

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

        const { data: loginData, error: loginError } = await supabase.auth.signInWithPassword({
            email,
            password,
        });

        if (loginError) {
            setError(loginError.message);
            setLoading(false);
            return;
        }

        if (loginData?.user?.id) {
            identifyUser(loginData.user.id, { email, name });
        }
        trackEvent('signup_completed', { method: 'password' });
        setSuccess(true);
        setLoading(false);
    };

    if (success) {
        return (
            <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
                <div className="w-full max-w-[400px] text-center bg-white border border-border p-10 rounded-sm shadow-sm">
                    <div className="bg-green-50 w-20 h-20 rounded-full flex items-center justify-center mb-6 mx-auto">
                        <CheckCircle2 className="h-10 w-10 text-green-500" />
                    </div>
                    <h2 className="text-2xl font-bold mb-3">Conta criada com sucesso</h2>
                    <p className="text-foreground/60 font-medium mb-6 leading-relaxed">
                        Seu primeiro deck foi salvo ✅
                    </p>
                    <div className="space-y-3">
                        <Link href="/app" className="inline-flex items-center gap-2 text-brand font-bold hover:gap-3 transition-all">
                            Ir para o App <ArrowRight className="h-4 w-4" />
                        </Link>
                        <Link href="/app" className="inline-flex items-center gap-2 text-foreground font-bold">
                            Exportar agora <ArrowRight className="h-4 w-4" />
                        </Link>
                        <div className="text-[11px] text-foreground/50 font-medium">
                            Sugestões: confira templates prontos no Marketplace.
                        </div>
                        <Link href="/marketplace" className="text-xs font-bold text-foreground/70 underline">
                            Ver templates
                        </Link>
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
            <div className="w-full max-w-[400px]">
                {/* Header */}
                <div className="text-center mb-10">
                    <Link href="/" className="inline-flex items-center mb-6 group">
                        <Logo
                            className="h-14 w-[200px] transform group-hover:scale-105 transition-transform"
                            priority
                        />
                    </Link>
                    <h1 className="text-3xl font-bold tracking-tight mb-2">Comece a estudar melhor</h1>
                    <p className="text-foreground/60 font-medium text-sm">Crie sua conta gratuita em poucos segundos.</p>
                </div>

                {/* Auth Card */}
                <div className="bg-white border border-border p-8 rounded-sm shadow-sm">
                    <form onSubmit={handleSignup} className="space-y-4">
                        {error && (
                            <div
                                role="alert"
                                aria-live="assertive"
                                className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold animate-in fade-in slide-in-from-top-1"
                            >
                                <AlertCircle className="h-4 w-4 shrink-0" />
                                {error}
                            </div>
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
                            className="w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                        >
                            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Criar Minha Conta'}
                        </button>
                    </form>

                    <p className="mt-6 text-[11px] text-center text-foreground/40 font-medium leading-relaxed">
                        Ao se cadastrar, você concorda com nossos <Link href="/terms" className="underline">Termos de Uso</Link> e <Link href="/privacy" className="underline">Política de Privacidade</Link>.
                    </p>
                </div>

                <p className="mt-8 text-center text-sm font-medium text-foreground/40">
                    Já tem uma conta?{' '}
                    <Link href="/auth/login" className="text-brand hover:underline font-bold">
                        Entrar agora
                    </Link>
                </p>
            </div>
        </div>
    );
}
