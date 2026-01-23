'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { Sparkles, ArrowRight, User, Mail, Lock, AlertCircle, Loader2, CheckCircle2 } from 'lucide-react';
import SocialLogins from '@/components/SocialLogins';

export default function SignupPage() {
    const router = useRouter();
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [success, setSuccess] = useState(false);

    const handleSignup = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        const { error } = await supabase.auth.signUp({
            email,
            password,
            options: {
                data: {
                    full_name: name,
                },
            },
        });

        if (error) {
            setError(error.message);
            setLoading(false);
        } else {
            setSuccess(true);
            setLoading(false);
        }
    };

    if (success) {
        return (
            <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
                <div className="w-full max-w-[400px] text-center bg-white border border-border p-10 rounded-sm shadow-sm">
                    <div className="bg-green-50 w-20 h-20 rounded-full flex items-center justify-center mb-6 mx-auto">
                        <CheckCircle2 className="h-10 w-10 text-green-500" />
                    </div>
                    <h2 className="text-2xl font-bold mb-4">Verifique seu e-mail</h2>
                    <p className="text-foreground/60 font-medium mb-8 leading-relaxed">
                        Enviamos um link de confirmação para <span className="text-foreground font-bold">{email}</span> para ativar sua conta.
                    </p>
                    <Link href="/auth/login" className="inline-flex items-center gap-2 text-brand font-bold hover:gap-3 transition-all">
                        Ir para o Login <ArrowRight className="h-4 w-4" />
                    </Link>
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
                        <div className="relative h-12 w-auto transform group-hover:scale-105 transition-transform">
                            <img
                                src="/logo.png"
                                alt="Flashcards Generator"
                                className="h-full w-auto object-contain"
                            />
                        </div>
                    </Link>
                    <h1 className="text-3xl font-bold tracking-tight mb-2">Comece a estudar melhor</h1>
                    <p className="text-foreground/60 font-medium text-sm">Crie sua conta gratuita em poucos segundos.</p>
                </div>

                {/* Auth Card */}
                <div className="bg-white border border-border p-8 rounded-sm shadow-sm">
                    <form onSubmit={handleSignup} className="space-y-4">
                        {error && (
                            <div className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold animate-in fade-in slide-in-from-top-1">
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
                            <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="password">
                                Senha (mínimo 6 caracteres)
                            </label>
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
                                    minLength={6}
                                />
                            </div>
                        </div>

                        <button
                            disabled={loading}
                            className="w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                        >
                            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Criar Minha Conta'}
                        </button>
                    </form>

                    <div className="mt-8 relative pt-4 text-center">
                        <div className="absolute inset-0 flex items-center" aria-hidden="true">
                            <div className="w-full border-t border-border"></div>
                        </div>
                        <span className="relative bg-white px-4 text-[10px] font-bold uppercase tracking-widest text-foreground/30">
                            Ou cadastre-se com
                        </span>
                    </div>

                    <SocialLogins onError={(msg) => setError(msg)} />

                    <p className="mt-6 text-[11px] text-center text-foreground/40 font-medium leading-relaxed">
                        Ao se cadastrar, você concorda com nossos <Link href="#" className="underline">Termos de Uso</Link> e <Link href="#" className="underline">Política de Privacidade</Link>.
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
