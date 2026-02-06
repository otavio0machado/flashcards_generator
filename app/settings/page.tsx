'use client';

import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { getApiUrl } from '@/lib/api-config';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';
import { trackEvent } from '@/lib/analytics';
import { User, CreditCard, BarChart3, LogOut, Loader2, Zap, ArrowRight, Bell, Pencil, Lock, Check, X, Eye, EyeOff } from 'lucide-react';
import Link from 'next/link';
import NotificationSettings from '@/components/NotificationSettings';
import { toast } from 'sonner';
import SectionLabel from '@/components/SectionLabel';
import { Skeleton } from '@/components/Skeleton';

interface UserProfile {
    id: string;
    plan_tier?: string;
    daily_generations?: number;
    stripe_customer_id?: string;
}

interface AuthUser {
    id: string;
    email?: string;
    user_metadata?: {
        full_name?: string;
        [key: string]: unknown;
    };
}

export default function SettingsPage() {
    const router = useRouter();
    const [user, setUser] = useState<AuthUser | null>(null);
    const [profile, setProfile] = useState<UserProfile | null>(null);
    const [loading, setLoading] = useState(true);
    const [loadingPortal, setLoadingPortal] = useState(false);

    // Name editing state
    const [isEditingName, setIsEditingName] = useState(false);
    const [displayName, setDisplayName] = useState('');
    const [savingName, setSavingName] = useState(false);

    // Password change state
    const [newPassword, setNewPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [savingPassword, setSavingPassword] = useState(false);
    const [showNewPassword, setShowNewPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);

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
            setDisplayName(session.user.user_metadata?.full_name || '');
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
                toast.error(errorMsg);
            }
        } catch (error) {
            console.error('Portal Error:', error);
            toast.error('Ocorreu um erro ao tentar acessar o portal.');
        } finally {
            setLoadingPortal(false);
        }
    };

    const handleSaveName = async () => {
        const trimmed = displayName.trim();
        if (!trimmed) {
            toast.error('O nome não pode estar vazio.');
            return;
        }
        setSavingName(true);
        try {
            const { error } = await supabase.auth.updateUser({
                data: { full_name: trimmed },
            });
            if (error) throw error;
            setIsEditingName(false);
            toast.success('Nome atualizado com sucesso!');
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Erro ao atualizar nome.';
            toast.error(message);
        } finally {
            setSavingName(false);
        }
    };

    const handleCancelEditName = () => {
        setDisplayName(user?.user_metadata?.full_name || '');
        setIsEditingName(false);
    };

    const handleChangePassword = async () => {
        if (!newPassword || !confirmPassword) {
            toast.error('Preencha todos os campos de senha.');
            return;
        }
        if (newPassword !== confirmPassword) {
            toast.error('As senhas não coincidem.');
            return;
        }
        const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9]).{8,}$/;
        if (!passwordRegex.test(newPassword)) {
            toast.error('A senha deve ter no mínimo 8 caracteres, incluindo maiúscula, minúscula, número e caractere especial.');
            return;
        }
        setSavingPassword(true);
        try {
            const { error } = await supabase.auth.updateUser({
                password: newPassword,
            });
            if (error) throw error;
            setNewPassword('');
            setConfirmPassword('');
            toast.success('Senha alterada com sucesso!');
        } catch (err: unknown) {
            const message = err instanceof Error ? err.message : 'Erro ao alterar senha.';
            toast.error(message);
        } finally {
            setSavingPassword(false);
        }
    };

    if (loading) {
        return (
            <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
                <div className="space-y-6">
                    {Array.from({ length: 4 }).map((_, i) => (
                        <div key={i} className="bg-white border border-border rounded-sm p-6 shadow-sm animate-pulse">
                            <div className="flex items-center gap-4 mb-6">
                                <div className="bg-gray-200 p-3 rounded-full w-12 h-12" />
                                <div className="space-y-2">
                                    <Skeleton className="h-4 w-32" />
                                    <Skeleton className="h-3 w-48" />
                                </div>
                            </div>
                            <Skeleton className="h-10 w-full" />
                        </div>
                    ))}
                </div>
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

                        {/* Display Name */}
                        <div className="mb-6">
                            <label className="text-xs font-bold uppercase tracking-widest text-foreground/40 mb-2 block">
                                Nome de Exibição
                            </label>
                            {isEditingName ? (
                                <div className="flex items-center gap-2">
                                    <input
                                        type="text"
                                        value={displayName}
                                        onChange={(e) => setDisplayName(e.target.value)}
                                        className="flex-1 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground focus:outline-none focus:ring-2 focus:ring-brand/30 focus:border-brand"
                                        placeholder="Seu nome"
                                        autoFocus
                                        onKeyDown={(e) => {
                                            if (e.key === 'Enter') handleSaveName();
                                            if (e.key === 'Escape') handleCancelEditName();
                                        }}
                                        disabled={savingName}
                                    />
                                    <button
                                        onClick={handleSaveName}
                                        disabled={savingName}
                                        className="p-2 rounded-sm text-emerald-600 hover:bg-emerald-50 transition-colors disabled:opacity-50"
                                        title="Salvar"
                                    >
                                        {savingName ? <Loader2 className="h-4 w-4 animate-spin" /> : <Check className="h-4 w-4" />}
                                    </button>
                                    <button
                                        onClick={handleCancelEditName}
                                        disabled={savingName}
                                        className="p-2 rounded-sm text-red-500 hover:bg-red-50 transition-colors disabled:opacity-50"
                                        title="Cancelar"
                                    >
                                        <X className="h-4 w-4" />
                                    </button>
                                </div>
                            ) : (
                                <div className="flex items-center gap-2">
                                    <span className="text-sm font-medium text-foreground">
                                        {user?.user_metadata?.full_name || displayName || 'Não definido'}
                                    </span>
                                    <button
                                        onClick={() => setIsEditingName(true)}
                                        className="p-1.5 rounded-sm text-foreground/40 hover:text-brand hover:bg-brand/5 transition-colors"
                                        title="Editar nome"
                                    >
                                        <Pencil className="h-3.5 w-3.5" />
                                    </button>
                                </div>
                            )}
                        </div>

                        <button
                            onClick={handleSignOut}
                            className="text-red-500 text-sm font-bold flex items-center gap-2 hover:bg-red-50 px-4 py-2 rounded-sm transition-all border border-transparent hover:border-red-100"
                        >
                            <LogOut className="h-4 w-4" />
                            Sair da Conta
                        </button>
                    </m.div>

                    {/* Password Change Card */}
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
                                className="bg-amber-50 p-3 rounded-full"
                            >
                                <Lock className="h-6 w-6 text-amber-600" />
                            </m.div>
                            <div>
                                <h2 className="text-lg font-bold text-foreground">Alterar Senha</h2>
                                <p className="text-sm text-foreground/60 font-medium">Atualize sua senha de acesso.</p>
                            </div>
                        </div>

                        <div className="space-y-4">
                            <div>
                                <label className="text-xs font-bold uppercase tracking-widest text-foreground/40 mb-2 block">
                                    Nova Senha
                                </label>
                                <div className="relative">
                                    <input
                                        type={showNewPassword ? 'text' : 'password'}
                                        value={newPassword}
                                        onChange={(e) => setNewPassword(e.target.value)}
                                        className="w-full border border-border rounded-sm px-3 py-2 pr-10 text-sm font-medium text-foreground focus:outline-none focus:ring-2 focus:ring-brand/30 focus:border-brand"
                                        placeholder="Mínimo 8 caracteres"
                                        disabled={savingPassword}
                                    />
                                    <button
                                        type="button"
                                        onClick={() => setShowNewPassword(!showNewPassword)}
                                        className="absolute right-2 top-1/2 -translate-y-1/2 p-1 text-foreground/40 hover:text-foreground/70 transition-colors"
                                        tabIndex={-1}
                                    >
                                        {showNewPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                                    </button>
                                </div>
                            </div>
                            <div>
                                <label className="text-xs font-bold uppercase tracking-widest text-foreground/40 mb-2 block">
                                    Confirmar Nova Senha
                                </label>
                                <div className="relative">
                                    <input
                                        type={showConfirmPassword ? 'text' : 'password'}
                                        value={confirmPassword}
                                        onChange={(e) => setConfirmPassword(e.target.value)}
                                        className="w-full border border-border rounded-sm px-3 py-2 pr-10 text-sm font-medium text-foreground focus:outline-none focus:ring-2 focus:ring-brand/30 focus:border-brand"
                                        placeholder="Repita a nova senha"
                                        disabled={savingPassword}
                                        onKeyDown={(e) => {
                                            if (e.key === 'Enter') handleChangePassword();
                                        }}
                                    />
                                    <button
                                        type="button"
                                        onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                                        className="absolute right-2 top-1/2 -translate-y-1/2 p-1 text-foreground/40 hover:text-foreground/70 transition-colors"
                                        tabIndex={-1}
                                    >
                                        {showConfirmPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                                    </button>
                                </div>
                            </div>
                            <p className="text-xs text-foreground/40">
                                A senha deve conter no mínimo 8 caracteres, incluindo letra maiúscula, minúscula, número e caractere especial.
                            </p>
                            <button
                                onClick={handleChangePassword}
                                disabled={savingPassword || !newPassword || !confirmPassword}
                                className="w-full bg-brand text-white py-2.5 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                            >
                                {savingPassword && <Loader2 className="h-4 w-4 animate-spin" />}
                                Alterar Senha
                            </button>
                        </div>
                    </m.div>

                    {/* Usage Stats */}
                    <m.div
                        custom={2}
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
                        custom={3}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white border border-border rounded-sm p-6 shadow-sm relative overflow-hidden"
                    >
                        {currentPlan !== 'free' && (
                            <m.div
                                initial={{ opacity: 0, x: 20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.5 }}
                                className="absolute top-0 right-0 p-4"
                            >
                                <span className="bg-brand text-white text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded-sm">{limits.name.toUpperCase()} ATIVO</span>
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
                                    {currentPlan === 'free' ? 'Plano Gratuito' : `Plano ${limits.name}`}
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

                    {/* Notifications */}
                    <m.div
                        custom={4}
                        initial="hidden"
                        animate="visible"
                        variants={cardVariants}
                        className="bg-white border border-border rounded-sm p-6 shadow-sm"
                    >
                        <div className="flex items-center gap-4 mb-6">
                            <m.div
                                whileHover={{ scale: 1.05 }}
                                className="bg-purple-50 p-3 rounded-full"
                            >
                                <Bell className="h-6 w-6 text-purple-600" />
                            </m.div>
                            <div>
                                <h2 className="text-lg font-bold text-foreground">Notificações</h2>
                                <p className="text-sm text-foreground/60 font-medium">Configure lembretes de estudo.</p>
                            </div>
                        </div>

                        <NotificationSettings />
                    </m.div>
                </div>
            </div>
        </LazyMotion>
    );
}
