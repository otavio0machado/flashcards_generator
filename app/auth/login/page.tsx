'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { identifyUser, trackEvent } from '@/lib/analytics';
import { Mail, Lock, AlertCircle, Loader2 } from 'lucide-react';
import Logo from '@/components/Logo';

export default function LoginPage() {
    const router = useRouter();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
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
                    <h1 className="text-3xl font-bold tracking-tight mb-2">Bem-vindo de volta</h1>
                    <p className="text-foreground/60 font-medium text-sm">Entre com suas credenciais para continuar.</p>
                </div>

                {/* Auth Card */}
                <div className="bg-white border border-border p-8 rounded-sm shadow-sm">
                    <form onSubmit={handleLogin} className="space-y-4">
                        {error && (
                            <div className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold animate-in fade-in slide-in-from-top-1">
                                <AlertCircle className="h-4 w-4 shrink-0" />
                                {error}
                            </div>
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
                                    type="password"
                                    placeholder="••••••••"
                                    value={password}
                                    onChange={(e) => setPassword(e.target.value)}
                                    className="w-full bg-gray-50 border border-border px-10 py-3 rounded-sm text-sm focus:ring-1 focus:ring-brand focus:border-brand outline-none transition-all font-medium"
                                    required
                                />
                            </div>
                        </div>

                        <button
                            disabled={loading}
                            className="w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                        >
                            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Entrar na Conta'}
                        </button>
                    </form>
                </div>

                <p className="mt-8 text-center text-sm font-medium text-foreground/40">
                    Ainda não tem conta?{' '}
                    <Link href="/auth/signup" className="text-brand hover:underline font-bold">
                        Criar conta grátis
                    </Link>
                </p>
            </div>
        </div>
    );
}
