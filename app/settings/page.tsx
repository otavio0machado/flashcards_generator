'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { trackEvent } from '@/lib/analytics';
import { User, CreditCard, BarChart3, LogOut, Loader2, Zap, ArrowRight } from 'lucide-react';
import Link from 'next/link';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

export default function SettingsPage() {
    const router = useRouter();
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [user, setUser] = useState<any>(null);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [profile, setProfile] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const [loadingPortal, setLoadingPortal] = useState(false);

    useEffect(() => {
        trackEvent('settings_view', { source: 'settings_page' });
    }, []);

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
        trackEvent('user_signed_out', { source: 'settings_page' });
        await supabase.auth.signOut();
        router.push('/');
        router.refresh();
    };

    const handleManageSubscription = async () => {
        try {
            setLoadingPortal(true);
            trackEvent('manage_subscription_clicked', { source: 'settings_page' });
            const response = await fetch('/api/stripe/portal', {
                method: 'POST',
            });

            const data = await response.json();

            if (response.ok && data.url) {
                window.location.href = data.url;
            } else {
                console.error('Failed to get portal URL:', data);
                const errorMsg = data.error === 'No Stripe customer found'
                    ? 'Você não possui uma assinatura vinculada ao Stripe. Se seu plano foi ativado manualmente, entre em contato com o suporte.'
                    : 'Erro ao carregar o portal de assinatura. Verifique se você possui uma assinatura ativa.';
                alert(errorMsg);
            }
        } catch (error) {
            console.error('Portal Error:', error);
            alert('Ocorreu um erro ao tentar acessar o portal.');
        } finally {
            setLoadingPortal(false);
        }
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

    const cardVariants = {
        hidden: { opacity: 0, y: 20 },
        visible: (i: number) => ({
            opacity: 1,
            y: 0,
            transition: { delay: i * 0.1, duration: 0.4 }
        })
    };

    return (
        <LazyMotion features={domAnimation}>
            <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                >
                    <SectionLabel text="CONFIGURAÇÕES" />
                    <h1 className="text-3xl font-bold tracking-tight mb-8">Configurações da Conta</h1>
                </m.div>

                <div className="space-y-6">
                    {/* Profile Card */}
                    <m.div
                        custom={0}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white border border-border rounded-sm p-6 shadow-sm"
                    >
                        <div className="flex items-center gap-4 mb-6">
                            <m.div
                                whileHover={{ scale: 1.05 }}
                                className="bg-brand/10 p-3 rounded-full"
                            >
                                <User className="h-6 w-6 text-brand" />
                            </m.div>
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
                    </m.div>

                    {/* Usage Stats */}
                    <m.div
                        custom={1}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white border border-border rounded-sm p-6 shadow-sm"
                    >
                        <div className="flex items-center gap-4 mb-6">
                            <m.div
                                whileHover={{ scale: 1.05 }}
                                className="bg-blue-50 p-3 rounded-full"
                            >
                                <BarChart3 className="h-6 w-6 text-blue-500" />
                            </m.div>
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
                                <m.div
                                    initial={{ width: 0 }}
                                    animate={{ width: `${usagePercent}%` }}
                                    transition={{ duration: 0.8, ease: 'easeOut' }}
                                    className={`h-full ${usagePercent > 90 ? 'bg-red-500' : 'bg-brand'}`}
                                />
                            </div>
                        </div>
                    </m.div>

                    {/* Subscription Plan */}
                    <m.div
                        custom={2}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white border border-border rounded-sm p-6 shadow-sm relative overflow-hidden"
                    >
                        {currentPlan === 'pro' && (
                            <m.div
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.5 }}
                                className="absolute top-0 right-0 p-4"
                            >
                                <span className="bg-brand text-white text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded-sm">PRO ATIVO</span>
                            </m.div>
                        )}

                        <div className="flex items-center gap-4 mb-6">
                            <m.div
                                whileHover={{ scale: 1.05 }}
                                className="bg-emerald-50 p-3 rounded-full"
                            >
                                <CreditCard className="h-6 w-6 text-emerald-600" />
                            </m.div>
                            <div>
                                <h2 className="text-lg font-bold text-foreground">Plano Atual</h2>
                                <p className="text-sm text-foreground/60 font-medium capitalize">
                                    {currentPlan === 'free' ? 'Plano Gratuito' : 'Plano Profissional'}
                                </p>
                            </div>
                        </div>

                        <div className="bg-gray-50 p-4 rounded-sm border border-border mb-6 space-y-2 text-sm text-foreground/70">
                            <m.div
                                initial={{ opacity: 0, x: -10 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.3 }}
                                className="flex items-center gap-2"
                            >
                                <Zap className="h-4 w-4 text-brand" />
                                <span>Limite de {limits.dailyGens} gerações/dia</span>
                            </m.div>
                            <m.div
                                initial={{ opacity: 0, x: -10 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.4 }}
                                className="flex items-center gap-2"
                            >
                                <Zap className="h-4 w-4 text-brand" />
                                <span>Cards de até {limits.maxChars} caracteres</span>
                            </m.div>
                            <m.div
                                initial={{ opacity: 0, x: -10 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.5 }}
                                className="flex items-center gap-2"
                            >
                                <Zap className={`h-4 w-4 ${limits.allowFile ? 'text-brand' : 'text-gray-300'}`} />
                                <span className={limits.allowFile ? '' : 'text-gray-400 line-through'}>
                                    Upload de Arquivos (PDF)
                                </span>
                            </m.div>
                        </div>

                        {currentPlan === 'free' ? (
                            <Link
                                href="/#pricing"
                                className="group block text-center w-full bg-brand text-white py-3 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all"
                            >
                                <span className="inline-flex items-center gap-2">
                                    Fazer Upgrade para PRO
                                    <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                </span>
                            </Link>
                        ) : (
                            <button
                                onClick={handleManageSubscription}
                                disabled={loadingPortal}
                                className="w-full bg-brand text-white py-3 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                            >
                                {loadingPortal && <Loader2 className="h-4 w-4 animate-spin" />}
                                Gerenciar Assinatura
                            </button>
                        )}
                    </m.div>
                </div>
            </div>
        </LazyMotion>
    );
}
