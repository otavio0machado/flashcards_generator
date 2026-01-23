'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { Mail, ArrowLeft, Loader2, CheckCircle } from 'lucide-react';

export default function ResetPasswordPage() {
    const [email, setEmail] = useState('');
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleReset = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        try {
            const { error } = await supabase.auth.resetPasswordForEmail(email, {
                redirectTo: `${window.location.origin}/auth/update-password`,
            });

            if (error) throw error;
            setSuccess(true);
        } catch (err: any) {
            setError(err.message || 'Erro ao enviar email de recuperação.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
            <div className="w-full max-w-[400px]">
                <div className="text-center mb-10">
                    <Link href="/auth/login" className="inline-flex items-center gap-2 text-sm font-bold text-foreground/40 hover:text-brand mb-8 transition-colors">
                        <ArrowLeft className="h-4 w-4" />
                        Voltar para Login
                    </Link>
                    <h1 className="text-3xl font-bold tracking-tight mb-2">Recuperar Senha</h1>
                    <p className="text-foreground/60 font-medium text-sm">
                        Digite seu e-mail para receber as instruções.
                    </p>
                </div>

                <div className="bg-white border border-border p-8 rounded-sm shadow-sm">
                    {success ? (
                        <div className="text-center space-y-4 animate-in fade-in zoom-in">
                            <div className="h-16 w-16 bg-green-50 rounded-full flex items-center justify-center mx-auto">
                                <CheckCircle className="h-8 w-8 text-green-500" />
                            </div>
                            <h3 className="font-bold text-lg text-foreground">Email Enviado!</h3>
                            <p className="text-sm text-foreground/60 font-medium">
                                Verifique sua caixa de entrada (e spam) para redefinir sua senha.
                            </p>
                            <Link href="/auth/login" className="block w-full bg-gray-100 hover:bg-gray-200 text-foreground py-3 rounded-sm font-bold text-sm transition-all mt-6">
                                Voltar para Login
                            </Link>
                        </div>
                    ) : (
                        <form onSubmit={handleReset} className="space-y-4">
                            {error && (
                                <div className="p-3 bg-red-50 border border-red-100 rounded-sm text-red-500 text-xs font-bold">
                                    {error}
                                </div>
                            )}

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="email">
                                    E-mail da Conta
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

                            <button
                                disabled={loading}
                                className="w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2"
                            >
                                {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Enviar Link de Recuperação'}
                            </button>
                        </form>
                    )}
                </div>
            </div>
        </div>
    );
}
