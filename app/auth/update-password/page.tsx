'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { Lock, Loader2, AlertCircle, Check, X, ArrowRight, Shield } from 'lucide-react';

export default function UpdatePasswordPage() {
    const router = useRouter();
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    // Password validation rules (same as signup)
    const passwordChecks = {
        minLength: password.length >= 8,
        hasUpper: /[A-Z]/.test(password),
        hasLower: /[a-z]/.test(password),
        hasNumber: /[0-9]/.test(password),
        hasSpecial: /[!@#$%^&*(),.?":{}|<>]/.test(password),
    };

    const isPasswordValid = Object.values(passwordChecks).every(Boolean);

    const handleUpdate = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        if (!isPasswordValid) {
            setError('A senha não atende aos requisitos de segurança.');
            setLoading(false);
            return;
        }

        const { error } = await supabase.auth.updateUser({
            password: password
        });

        if (error) {
            setError(error.message);
            setLoading(false);
        } else {
            router.push('/app');
        }
    };

    return (
        <LazyMotion features={domAnimation}>
            <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="w-full max-w-[400px]"
                >
                    <div className="text-center mb-10">
                        <m.div
                            initial={{ scale: 0.9 }}
                            animate={{ scale: 1 }}
                            className="w-16 h-16 bg-brand/10 rounded-full flex items-center justify-center mx-auto mb-6"
                        >
                            <Shield className="h-8 w-8 text-brand" />
                        </m.div>
                        <m.h1
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ delay: 0.1 }}
                            className="text-3xl font-bold tracking-tight mb-2"
                        >
                            Nova Senha
                        </m.h1>
                        <p className="text-foreground/60 font-medium text-sm">
                            Digite sua nova senha abaixo.
                        </p>
                    </div>

                    <m.div
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.15 }}
                        className="bg-white border border-border p-8 rounded-sm shadow-sm"
                    >
                        <form onSubmit={handleUpdate} className="space-y-4">
                            {error && (
                                <m.div
                                    initial={{ opacity: 0, y: -10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold"
                                >
                                    <AlertCircle className="h-4 w-4 shrink-0" />
                                    {error}
                                </m.div>
                            )}

                            <div className="space-y-1.5">
                                <label className="text-[10px] font-bold uppercase tracking-widest text-foreground/40" htmlFor="password">
                                    Nova Senha
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
                                        minLength={8}
                                    />
                                </div>
                            </div>

                            {/* Password Requirements */}
                            {password && (
                                <m.div
                                    initial={{ opacity: 0, height: 0 }}
                                    animate={{ opacity: 1, height: 'auto' }}
                                    className="space-y-1 p-3 bg-gray-50 rounded-sm border border-border"
                                >
                                    <p className="text-[10px] font-bold uppercase tracking-widest text-foreground/40 mb-2">Requisitos da Senha</p>
                                    {[
                                        { check: passwordChecks.minLength, label: 'Mínimo 8 caracteres' },
                                        { check: passwordChecks.hasUpper, label: 'Uma letra maiúscula' },
                                        { check: passwordChecks.hasLower, label: 'Uma letra minúscula' },
                                        { check: passwordChecks.hasNumber, label: 'Um número' },
                                        { check: passwordChecks.hasSpecial, label: 'Um caractere especial (!@#$%^&*)' },
                                    ].map((req, i) => (
                                        <m.div
                                            key={i}
                                            initial={{ opacity: 0, x: -10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: i * 0.05 }}
                                            className={`flex items-center gap-2 text-xs font-medium ${req.check ? 'text-green-600' : 'text-foreground/40'}`}
                                        >
                                            {req.check ? <Check className="h-3 w-3" /> : <X className="h-3 w-3" />}
                                            {req.label}
                                        </m.div>
                                    ))}
                                </m.div>
                            )}

                            <button
                                disabled={loading || !isPasswordValid}
                                className="group w-full bg-brand text-white py-3 font-bold rounded-sm mt-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/10 flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
                            >
                                {loading ? (
                                    <Loader2 className="h-4 w-4 animate-spin" />
                                ) : (
                                    <>
                                        Atualizar Senha
                                        <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                    </>
                                )}
                            </button>
                        </form>
                    </m.div>
                </m.div>
            </div>
        </LazyMotion>
    );
}
