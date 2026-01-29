'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { getApiUrl } from '@/lib/api-config';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { trackEvent } from '@/lib/analytics';
import { User, CreditCard, BarChart3, LogOut, Loader2, Zap, ArrowRight, Bell, BookOpen, FileText, Smartphone, Hand, Vibrate, Globe, Moon, Sun, Trash2, MessageSquare, Star, HelpCircle, Shield } from 'lucide-react';
import Link from 'next/link';
import NotificationSettings from '@/components/NotificationSettings';
import { useTauri } from '@/lib/tauri';
import { useMobilePreferences } from '@/lib/mobile-preferences';
import AppShell from '@/components/AppShell';

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
    const { isMobileTauri } = useTauri();
    const [mobilePrefs, setMobilePrefs] = useMobilePreferences();

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
            const response = await fetch(getApiUrl('api/stripe/portal'), {
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

    const handleThemeChange = (theme: 'light' | 'dark') => {
        const root = document.documentElement;
        root.classList.toggle('dark', theme === 'dark');
        root.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
        trackEvent('theme_changed', { theme });
    };

    const handleDeleteAccount = () => {
        if (confirm('Tem certeza? Essa ação é irreversível e apagará todos os seus decks e dados.')) {
            // TODO: Implement delete account logic
            alert('Funcionalidade em desenvolvimento. Entre em contato com o suporte para excluir sua conta imediatamente.');
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
            <AppShell eyebrow="CONFIGURAÇÕES" title="Configurações da Conta" maxWidthClass="max-w-3xl">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                >
                </m.div>

                <div className="space-y-px bg-zinc-100 dark:bg-zinc-800 border border-zinc-100 dark:border-zinc-800 rounded-sm overflow-hidden">
                    {/* General Preferences */}
                    <m.div
                        custom={0}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <h2 className="text-xl font-black text-swiss-header mb-8">Preferências</h2>

                        <div className="flex items-center justify-between mb-6">
                            <div className="flex items-center gap-3">
                                <Globe className="h-5 w-5 text-zinc-400" />
                                <span className="text-sm font-bold">Idioma</span>
                            </div>
                            <select className="bg-zinc-50 dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 rounded-sm px-3 py-1.5 text-xs font-bold uppercase tracking-wider outline-none">
                                <option value="pt">Português</option>
                                <option value="en">English (Breve)</option>
                                <option value="es">Español (Breve)</option>
                            </select>
                        </div>

                        <div className="flex items-center justify-between">
                            <div className="flex items-center gap-3">
                                <Moon className="h-5 w-5 text-zinc-400" />
                                <span className="text-sm font-bold">Tema</span>
                            </div>
                            <div className="flex bg-zinc-50 dark:bg-zinc-900 p-1 rounded-sm border border-zinc-200 dark:border-zinc-800">
                                <button
                                    onClick={() => handleThemeChange('light')}
                                    className="px-3 py-1.5 rounded-sm text-xs font-bold uppercase tracking-wider hover:bg-white dark:hover:bg-zinc-800 hover:shadow-sm transition-all"
                                >
                                    Claro
                                </button>
                                <button
                                    onClick={() => handleThemeChange('dark')}
                                    className="px-3 py-1.5 rounded-sm text-xs font-bold uppercase tracking-wider hover:bg-white dark:hover:bg-zinc-800 hover:shadow-sm transition-all"
                                >
                                    Escuro
                                </button>
                            </div>
                        </div>
                    </m.div>

                    {/* Profile Card */}
                    <m.div
                        custom={0}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8 flex items-center justify-between group"
                    >
                        <div className="flex items-center gap-6">
                            <div className="bg-zinc-50 dark:bg-zinc-900 p-4 rounded-sm border border-zinc-100 dark:border-zinc-800">
                                <User className="h-6 w-6 text-brand" />
                            </div>
                            <div>
                                <h2 className="text-xl font-black text-swiss-header">Perfil</h2>
                                <p className="text-xs text-zinc-400 font-bold uppercase tracking-widest mt-1">{user.email}</p>
                            </div>
                        </div>
                        <button
                            onClick={handleSignOut}
                            className="p-3 text-zinc-300 hover:text-red-500 transition-colors ripple"
                            title="Sair"
                        >
                            <LogOut className="h-5 w-5" />
                        </button>
                    </m.div>

                    {/* Usage Stats */}
                    <m.div
                        custom={1}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <div className="flex items-center justify-between mb-8">
                            <h2 className="text-xl font-black text-swiss-header">Uso Diário</h2>
                            <div className="text-[10px] font-black uppercase tracking-widest text-zinc-400">
                                {usage} / {limits.dailyGens}
                            </div>
                        </div>
                        <div className="h-1 bg-zinc-100 dark:bg-zinc-900 rounded-full overflow-hidden">
                            <m.div
                                initial={{ width: 0 }}
                                animate={{ width: `${usagePercent}%` }}
                                transition={{ duration: 0.8, ease: 'easeOut' }}
                                className={`h-full ${usagePercent > 90 ? 'bg-red-500' : 'bg-brand'}`}
                            />
                        </div>
                    </m.div>

                    {/* Subscription Plan */}
                    <m.div
                        custom={2}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8 relative overflow-hidden"
                    >
                        <div className="flex items-start justify-between mb-10">
                            <div>
                                <h2 className="text-xl font-black text-swiss-header uppercase tracking-tighter">Plano {currentPlan === 'free' ? 'Básico' : currentPlan}</h2>
                                <p className="text-xs text-zinc-400 font-bold mt-1">Status: {currentPlan === 'free' ? 'Ativo (Grátis)' : 'Premium'}</p>
                            </div>
                            <CreditCard className="h-6 w-6 text-zinc-200 dark:text-zinc-800" />
                        </div>

                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-10">
                            <div className="p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm">
                                <span className="text-[10px] font-black uppercase tracking-widest text-brand block mb-1">Gerações</span>
                                <span className="text-sm font-bold">{limits.dailyGens} por dia</span>
                            </div>
                            <div className="p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm">
                                <span className="text-[10px] font-black uppercase tracking-widest text-brand block mb-1">Upload</span>
                                <span className="text-sm font-bold">{limits.allowFile ? 'Habilitado' : 'Bloqueado'}</span>
                            </div>
                        </div>

                        {currentPlan === 'free' ? (
                            <Link
                                href="/#pricing"
                                className="block w-full bg-brand text-white py-4 rounded-sm font-black text-xs uppercase tracking-[0.2em] text-center hover:bg-brand/90 transition-all shadow-xl shadow-brand/20 ripple"
                            >
                                Fazer Upgrade
                            </Link>
                        ) : (
                            <button
                                onClick={handleManageSubscription}
                                disabled={loadingPortal}
                                className="w-full bg-zinc-900 dark:bg-zinc-100 text-white dark:text-black py-4 rounded-sm font-black text-xs uppercase tracking-[0.2em] hover:opacity-90 transition-all disabled:opacity-50 ripple flex items-center justify-center gap-2"
                            >
                                {loadingPortal && <Loader2 className="h-4 w-4 animate-spin" />}
                                Painel Strype
                            </button>
                        )}
                    </m.div>

                    {/* Notifications */}
                    <m.div
                        custom={3}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <div className="flex items-center justify-between mb-8">
                            <h2 className="text-xl font-black text-swiss-header">Notificações</h2>
                            <Bell className="h-5 w-5 text-zinc-300 dark:text-zinc-700" />
                        </div>
                        <NotificationSettings />
                    </m.div>

                    {/* Privacy */}
                    <m.div
                        custom={4}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <div className="flex items-center justify-between mb-8">
                            <h2 className="text-xl font-black text-swiss-header">Privacidade</h2>
                            <Shield className="h-5 w-5 text-zinc-300 dark:text-zinc-700" />
                        </div>
                        <div className="space-y-4">
                            <button className="w-full flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm hover:border-zinc-300 transition-colors group text-left">
                                <span className="text-sm font-bold text-foreground/70">Exportar meus dados</span>
                                <ArrowRight className="h-4 w-4 text-zinc-300 group-hover:text-brand transition-all" />
                            </button>
                            <button
                                onClick={handleDeleteAccount}
                                className="w-full flex items-center justify-between p-4 bg-red-50 dark:bg-red-900/10 border border-red-100 dark:border-red-900/20 rounded-sm hover:border-red-300 transition-colors group text-left"
                            >
                                <span className="text-sm font-bold text-red-600">Excluir conta</span>
                                <Trash2 className="h-4 w-4 text-red-400 group-hover:text-red-600 transition-all" />
                            </button>
                        </div>
                    </m.div>

                    {/* Mobile Settings - Only visible on mobile Tauri */}
                    {isMobileTauri && (
                        <m.div
                            custom={4}
                            initial="hidden"
                            animate="visible"
                            variants={cardVariants}
                            className="bg-white dark:bg-zinc-950 p-8"
                        >
                            <div className="flex items-center justify-between mb-8">
                                <h2 className="text-xl font-black text-swiss-header">Gestos e Feedback</h2>
                                <Smartphone className="h-5 w-5 text-zinc-300 dark:text-zinc-700" />
                            </div>
                            <div className="space-y-6">
                                {/* Swipe Gestures Toggle */}
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-3">
                                        <Hand className="h-5 w-5 text-brand" />
                                        <div>
                                            <p className="font-bold text-sm">Gestos de Swipe</p>
                                            <p className="text-xs text-zinc-500">Deslize para virar e avaliar cards</p>
                                        </div>
                                    </div>
                                    <button
                                        onClick={() => setMobilePrefs({ swipeGesturesEnabled: !mobilePrefs.swipeGesturesEnabled })}
                                        className={`relative w-12 h-7 rounded-full transition-colors ${mobilePrefs.swipeGesturesEnabled ? 'bg-brand' : 'bg-zinc-200 dark:bg-zinc-700'}`}
                                    >
                                        <span className={`absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform ${mobilePrefs.swipeGesturesEnabled ? 'translate-x-6' : 'translate-x-1'}`} />
                                    </button>
                                </div>

                                {/* Haptic Feedback Toggle */}
                                <div className="flex items-center justify-between">
                                    <div className="flex items-center gap-3">
                                        <Vibrate className="h-5 w-5 text-brand" />
                                        <div>
                                            <p className="font-bold text-sm">Vibração</p>
                                            <p className="text-xs text-zinc-500">Feedback tátil nas interações</p>
                                        </div>
                                    </div>
                                    <button
                                        onClick={() => setMobilePrefs({ hapticFeedbackEnabled: !mobilePrefs.hapticFeedbackEnabled })}
                                        className={`relative w-12 h-7 rounded-full transition-colors ${mobilePrefs.hapticFeedbackEnabled ? 'bg-brand' : 'bg-zinc-200 dark:bg-zinc-700'}`}
                                    >
                                        <span className={`absolute top-1 w-5 h-5 bg-white rounded-full shadow transition-transform ${mobilePrefs.hapticFeedbackEnabled ? 'translate-x-6' : 'translate-x-1'}`} />
                                    </button>
                                </div>

                                {/* Haptic Intensity */}
                                {mobilePrefs.hapticFeedbackEnabled && (
                                    <div className="pl-8">
                                        <p className="text-xs font-bold text-zinc-500 uppercase tracking-wider mb-3">Intensidade</p>
                                        <div className="flex gap-2">
                                            {(['light', 'medium', 'strong'] as const).map((intensity) => (
                                                <button
                                                    key={intensity}
                                                    onClick={() => setMobilePrefs({ hapticIntensity: intensity })}
                                                    className={`flex-1 py-2 px-3 rounded-lg text-xs font-bold uppercase tracking-wider transition-colors ${mobilePrefs.hapticIntensity === intensity
                                                        ? 'bg-brand text-white'
                                                        : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400'
                                                        }`}
                                                >
                                                    {intensity === 'light' ? 'Leve' : intensity === 'medium' ? 'Médio' : 'Forte'}
                                                </button>
                                            ))}
                                        </div>
                                    </div>
                                )}
                            </div>
                        </m.div>
                    )}

                    {/* Feedback */}
                    <m.div
                        custom={isMobileTauri ? 6 : 5}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <h2 className="text-xl font-black text-swiss-header mb-8">Feedback</h2>
                        <div className="grid grid-cols-1 gap-2">
                            <a
                                href="mailto:feedback@flashcardsgenerator.com"
                                className="flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm hover:border-brand transition-colors group ripple"
                            >
                                <div className="flex items-center gap-4">
                                    <MessageSquare className="h-5 w-5 text-brand" />
                                    <span className="text-sm font-bold uppercase tracking-tight">Enviar Sugestão</span>
                                </div>
                                <ArrowRight className="h-4 w-4 text-zinc-300 group-hover:text-brand transition-all group-hover:translate-x-1" />
                            </a>
                            <button
                                className="flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm hover:border-brand transition-colors group ripple w-full text-left"
                            >
                                <div className="flex items-center gap-4">
                                    <Star className="h-5 w-5 text-yellow-500" />
                                    <span className="text-sm font-bold uppercase tracking-tight">Avaliar App</span>
                                </div>
                                <ArrowRight className="h-4 w-4 text-zinc-300 group-hover:text-brand transition-all group-hover:translate-x-1" />
                            </button>
                        </div>
                    </m.div>

                    {/* Help & Support */}
                    <m.div
                        custom={isMobileTauri ? 7 : 6}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white dark:bg-zinc-950 p-8"
                    >
                        <h2 className="text-xl font-black text-swiss-header mb-8">Ajuda e Suporte</h2>
                        <div className="grid grid-cols-1 gap-2">
                            <Link
                                href="/guia"
                                className="flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm hover:border-brand transition-colors group ripple"
                            >
                                <div className="flex items-center gap-4">
                                    <BookOpen className="h-5 w-5 text-brand" />
                                    <span className="text-sm font-bold uppercase tracking-tight">Tutorial Android</span>
                                </div>
                                <ArrowRight className="h-4 w-4 text-zinc-300 group-hover:text-brand transition-all group-hover:translate-x-1" />
                            </Link>
                            <Link
                                href="/documentacao"
                                className="flex items-center justify-between p-4 bg-zinc-50 dark:bg-zinc-900 border border-zinc-100 dark:border-zinc-800 rounded-sm hover:border-brand transition-colors group ripple"
                            >
                                <div className="flex items-center gap-4">
                                    <FileText className="h-5 w-5 text-zinc-400" />
                                    <span className="text-sm font-bold uppercase tracking-tight">Documentação</span>
                                </div>
                                <ArrowRight className="h-4 w-4 text-zinc-300 group-hover:text-brand transition-all group-hover:translate-x-1" />
                            </Link>
                        </div>
                    </m.div>
                </div>
            </AppShell>
        </LazyMotion>
    );
}
