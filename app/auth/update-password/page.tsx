'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { Lock, Loader2, AlertCircle, Check, X } from 'lucide-react';

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
        <div className="min-h-[calc(100vh-64px)] flex items-center justify-center px-4 py-12">
            <div className="w-full max-w-[400px]">
                <div className="text-center mb-10">
                    <h1 className="text-3xl font-bold tracking-tight mb-2">Nova Senha</h1>
                    <p className="text-foreground/60 font-medium text-sm">
                        Digite sua nova senha abaixo.
                    </p>
                </div>

                <div className="bg-white border border-border p-8 rounded-sm shadow-sm">
                    <form onSubmit={handleUpdate} className="space-y-4">
                        {error && (
                            <div className="p-3 bg-red-50 border border-red-100 rounded-sm flex items-center gap-2 text-red-500 text-xs font-bold">
                                <AlertCircle className="h-4 w-4 shrink-0" />
                                {error}
                            </div>
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
                            <div className="space-y-1 p-3 bg-gray-50 rounded-sm border border-border">
                                <p className="text-[10px] font-bold uppercase tracking-widest text-foreground/40 mb-2">Requisitos da Senha</p>
                                {[
                                    { check: passwordChecks.minLength, label: 'Mínimo 8 caracteres' },
                                    { check: passwordChecks.hasUpper, label: 'Uma letra maiúscula' },
                                    { check: passwordChecks.hasLower, label: 'Uma letra minúscula' },
                                    { check: passwordChecks.hasNumber, label: 'Um número' },
                                    { check: passwordChecks.hasSpecial, label: 'Um caractere especial (!@#$%^&*)' },
                                ].map((req, i) => (
                                    <div key={i} className={`flex items-center gap-2 text-xs font-medium ${req.check ? 'text-green-600' : 'text-foreground/40'}`}>
                                        {req.check ? <Check className="h-3 w-3" /> : <X className="h-3 w-3" />}
                                        {req.label}
                                    </div>
                                ))}
                            </div>
                        )}

                        <button
                            disabled={loading || !isPasswordValid}
                            className={`w-full py-3 font-bold rounded-sm mt-2 transition-all shadow-lg flex items-center justify-center gap-2 ${
                                loading || !isPasswordValid
                                    ? 'bg-gray-200 text-gray-400 cursor-not-allowed shadow-none'
                                    : 'bg-brand text-white hover:bg-brand/90 shadow-brand/10'
                            }`}
                        >
                            {loading ? <Loader2 className="h-4 w-4 animate-spin" /> : 'Atualizar Senha'}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
}
