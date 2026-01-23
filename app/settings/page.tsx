'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { User, CreditCard, BarChart3, LogOut, Loader2, Zap } from 'lucide-react';
import Link from 'next/link';

export default function SettingsPage() {
    const router = useRouter();
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [user, setUser] = useState<any>(null);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [profile, setProfile] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const getProfile = async () => {
            const { data: { session } } = await supabase.auth.getSession();
            if (!session) {
                router.push('/auth/login');
                return;
            }

            setUser(session.user);

            const { data } = await supabase
                .from('profiles')
                .select('*')
                .eq('id', session.user.id)
                .single();

            setProfile(data);
            setLoading(false);
        };

        getProfile();
    }, [router]);

    const handleSignOut = async () => {
        await supabase.auth.signOut();
        router.push('/');
        router.refresh();
    };

    if (loading) {
        return (
            <div className="min-h-screen flex items-center justify-center pt-20">
                <Loader2 className="h-8 w-8 animate-spin text-brand" />
            </div>
        );
    }

    const currentPlan = (profile?.plan_tier || 'free') as PlanKey;
    const limits = PLAN_LIMITS[currentPlan];
    const usage = profile?.daily_generations || 0;
    const usagePercent = Math.min((usage / limits.dailyGens) * 100, 100);

    return (
        <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
            <h1 className="text-3xl font-bold tracking-tight mb-8">Configurações da Conta</h1>

            <div className="space-y-6">
                {/* Profile Card */}
                <div className="bg-white border border-border rounded-sm p-6 shadow-sm">
                    <div className="flex items-center gap-4 mb-6">
                        <div className="bg-brand/10 p-3 rounded-full">
                            <User className="h-6 w-6 text-brand" />
                        </div>
                        <div>
                            <h2 className="text-lg font-bold text-foreground">Perfil</h2>
                            <p className="text-sm text-foreground/60 font-medium">{user.email}</p>
                        </div>
                    </div>

                    <button
                        onClick={handleSignOut}
                        className="text-red-500 text-sm font-bold flex items-center gap-2 hover:bg-red-50 px-4 py-2 rounded-sm transition-all border border-transparent hover:border-red-100"
                    >
                        <LogOut className="h-4 w-4" />
                        Sair da Conta
                    </button>
                </div>

                {/* Usage Stats */}
                <div className="bg-white border border-border rounded-sm p-6 shadow-sm">
                    <div className="flex items-center gap-4 mb-6">
                        <div className="bg-blue-50 p-3 rounded-full">
                            <BarChart3 className="h-6 w-6 text-blue-500" />
                        </div>
                        <div>
                            <h2 className="text-lg font-bold text-foreground">Uso Diário</h2>
                            <p className="text-sm text-foreground/60 font-medium">Suas gerações via IA renovam a cada 24h.</p>
                        </div>
                    </div>

                    <div className="space-y-2">
                        <div className="flex justify-between text-xs font-bold uppercase tracking-widest text-foreground/40">
                            <span>{usage} de {limits.dailyGens} gerações</span>
                            <span>{Math.round(usagePercent)}%</span>
                        </div>
                        <div className="h-3 bg-gray-100 rounded-full overflow-hidden">
                            <div
                                className={`h-full transition-all duration-500 ${usagePercent > 90 ? 'bg-red-500' : 'bg-brand'}`}
                                style={{ width: `${usagePercent}%` }}
                            />
                        </div>
                    </div>
                </div>

                {/* Subscription Plan */}
                <div className="bg-white border border-border rounded-sm p-6 shadow-sm relative overflow-hidden">
                    {currentPlan === 'pro' && (
                        <div className="absolute top-0 right-0 p-4">
                            <span className="bg-brand text-white text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded-sm">PRO ATIVO</span>
                        </div>
                    )}

                    <div className="flex items-center gap-4 mb-6">
                        <div className="bg-purple-50 p-3 rounded-full">
                            <CreditCard className="h-6 w-6 text-purple-600" />
                        </div>
                        <div>
                            <h2 className="text-lg font-bold text-foreground">Plano Atual</h2>
                            <p className="text-sm text-foreground/60 font-medium capitalize">
                                {currentPlan === 'free' ? 'Plano Gratuito' : 'Plano Profissional'}
                            </p>
                        </div>
                    </div>

                    <div className="bg-gray-50 p-4 rounded-sm border border-border mb-6 space-y-2 text-sm text-foreground/70">
                        <div className="flex items-center gap-2">
                            <Zap className="h-4 w-4 text-brand" />
                            <span>Limite de {limits.dailyGens} gerações/dia</span>
                        </div>
                        <div className="flex items-center gap-2">
                            <Zap className="h-4 w-4 text-brand" />
                            <span>Cards de até {limits.maxChars} caracteres</span>
                        </div>
                        <div className="flex items-center gap-2">
                            <Zap className={`h-4 w-4 ${limits.allowFile ? 'text-brand' : 'text-gray-300'}`} />
                            <span className={limits.allowFile ? '' : 'text-gray-400 decoration-line-through'}>
                                Upload de Arquivos (PDF)
                            </span>
                        </div>
                    </div>

                    {currentPlan === 'free' ? (
                        <Link href="/#pricing" className="block text-center w-full bg-brand text-white py-3 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all">
                            Fazer Upgrade para PRO
                        </Link>
                    ) : (
                        <button disabled className="w-full bg-gray-100 text-foreground/40 py-3 rounded-sm font-bold text-sm cursor-not-allowed">
                            Plano Gerenciado Externamente
                        </button>
                    )}
                </div>
            </div>
        </div>
    );
}
