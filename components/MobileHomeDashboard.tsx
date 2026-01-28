'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { motion } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import {
    Flame,
    BookOpen,
    Target,
    Plus,
    ArrowRight,
    TrendingUp,
    Layers,
    Sparkles
} from 'lucide-react';

interface DashboardData {
    userName: string;
    streak: number;
    hasStudiedToday: boolean;
    todayCardsReviewed: number;
    totalDecks: number;
    totalCards: number;
    lastDeck: { id: string; title: string } | null;
    dueCardsCount: number;
}

function getGreeting(): string {
    const hour = new Date().getHours();
    if (hour < 12) return 'Bom dia';
    if (hour < 18) return 'Boa tarde';
    return 'Boa noite';
}

function StatCard({ icon, label, value }: { icon: React.ReactNode; label: string; value: string | number }) {
    return (
        <div className="bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 p-4 rounded-2xl">
            <div className="flex items-center gap-2 mb-2">
                {icon}
                <span className="text-[10px] font-bold uppercase tracking-wider text-zinc-500 dark:text-zinc-400">
                    {label}
                </span>
            </div>
            <span className="text-xl font-black text-zinc-900 dark:text-white">{value}</span>
        </div>
    );
}

function StreakBadge({ streak, hasStudiedToday }: { streak: number; hasStudiedToday: boolean }) {
    return (
        <div className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full ${hasStudiedToday
            ? 'bg-orange-100 dark:bg-orange-900/30'
            : 'bg-zinc-100 dark:bg-zinc-800'
            }`}>
            <Flame className={`h-4 w-4 ${hasStudiedToday ? 'text-orange-500' : 'text-zinc-400'}`} />
            <span className={`text-sm font-bold ${hasStudiedToday ? 'text-orange-600 dark:text-orange-400' : 'text-zinc-500'}`}>
                {streak}
            </span>
        </div>
    );
}

export default function MobileHomeDashboard() {
    const [data, setData] = useState<DashboardData | null>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchDashboardData();

        // Listen for study activity updates
        const handleUpdate = () => fetchDashboardData();
        window.addEventListener('study-activity-updated', handleUpdate);
        return () => window.removeEventListener('study-activity-updated', handleUpdate);
    }, []);

    async function fetchDashboardData() {
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) {
                setLoading(false);
                return;
            }

            // Fetch user profile
            const { data: profile } = await supabase
                .from('profiles')
                .select('full_name, streak, last_study_date')
                .eq('id', user.id)
                .single();

            // Fetch decks with card counts
            const { data: decks } = await supabase
                .from('decks')
                .select('id, title, cards(id)')
                .eq('user_id', user.id)
                .order('updated_at', { ascending: false });

            // Calculate stats
            const totalDecks = decks?.length || 0;
            const totalCards = decks?.reduce((sum, deck) => sum + (deck.cards?.length || 0), 0) || 0;
            const lastDeck = decks && decks.length > 0 ? { id: decks[0].id, title: decks[0].title } : null;

            // Check if studied today
            const today = new Date().toISOString().split('T')[0];
            const hasStudiedToday = profile?.last_study_date === today;

            // Fetch today's review count
            const { count: todayReviews } = await supabase
                .from('card_progress')
                .select('*', { count: 'exact', head: true })
                .eq('user_id', user.id)
                .gte('last_review', `${today}T00:00:00`);

            // Fetch due cards count
            const { count: dueCards } = await supabase
                .from('card_progress')
                .select('*', { count: 'exact', head: true })
                .eq('user_id', user.id)
                .lte('next_review', new Date().toISOString());

            setData({
                userName: profile?.full_name?.split(' ')[0] || 'Estudante',
                streak: profile?.streak || 0,
                hasStudiedToday,
                todayCardsReviewed: todayReviews || 0,
                totalDecks,
                totalCards,
                lastDeck,
                dueCardsCount: dueCards || 0,
            });
        } catch (error) {
            console.error('Error fetching dashboard data:', error);
        } finally {
            setLoading(false);
        }
    }

    if (loading) {
        return <MobileHomeDashboardSkeleton />;
    }

    if (!data) {
        return null;
    }

    const dailyGoal = 20;
    const progressPercent = Math.min(100, (data.todayCardsReviewed / dailyGoal) * 100);

    return (
        <div className="px-4 py-6 space-y-6 pb-28">
            {/* Welcome Section */}
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="flex items-center justify-between"
            >
                <div>
                    <p className="text-sm text-zinc-500 dark:text-zinc-400 font-medium">
                        {getGreeting()},
                    </p>
                    <h1 className="text-2xl font-black text-zinc-900 dark:text-white tracking-tight">
                        {data.userName}
                    </h1>
                </div>
                <StreakBadge streak={data.streak} hasStudiedToday={data.hasStudiedToday} />
            </motion.div>

            {/* Daily Goal Card */}
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.1 }}
                className="bg-gradient-to-br from-brand to-orange-600 rounded-2xl p-6 text-white shadow-lg shadow-brand/20"
            >
                <div className="flex items-center gap-2 mb-4">
                    <Target className="h-5 w-5" />
                    <span className="text-sm font-bold uppercase tracking-wider opacity-80">
                        Meta de Hoje
                    </span>
                </div>
                <div className="flex items-end justify-between mb-4">
                    <div>
                        <span className="text-4xl font-black">
                            {data.todayCardsReviewed}
                        </span>
                        <span className="text-lg opacity-70"> / {dailyGoal} cards</span>
                    </div>
                    <div className="text-right">
                        <div className="text-sm opacity-70">
                            {data.dueCardsCount} pendentes
                        </div>
                    </div>
                </div>
                <div className="h-2 bg-white/20 rounded-full overflow-hidden">
                    <motion.div
                        initial={{ width: 0 }}
                        animate={{ width: `${progressPercent}%` }}
                        className="h-full bg-white rounded-full"
                        transition={{ duration: 0.8, ease: 'easeOut', delay: 0.3 }}
                    />
                </div>
            </motion.div>

            {/* Continue Studying - Last Deck */}
            {data.lastDeck && (
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.15 }}
                >
                    <h2 className="text-xs font-black uppercase tracking-widest text-zinc-400 dark:text-zinc-500 mb-3">
                        Continuar Estudando
                    </h2>
                    <Link
                        href={`/decks/${data.lastDeck.id}`}
                        className="flex items-center justify-between bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 p-4 rounded-2xl group active:scale-[0.98] transition-transform"
                    >
                        <div className="flex items-center gap-4">
                            <div className="w-12 h-12 bg-brand/10 rounded-xl flex items-center justify-center">
                                <BookOpen className="h-6 w-6 text-brand" />
                            </div>
                            <div>
                                <h3 className="font-bold text-zinc-900 dark:text-white">{data.lastDeck.title}</h3>
                                <p className="text-sm text-zinc-500 dark:text-zinc-400">
                                    {data.dueCardsCount > 0 ? `${data.dueCardsCount} cards para revisar` : 'Tudo em dia!'}
                                </p>
                            </div>
                        </div>
                        <ArrowRight className="h-5 w-5 text-zinc-300 dark:text-zinc-600 group-hover:text-brand transition-colors" />
                    </Link>
                </motion.div>
            )}

            {/* Quick Stats Grid */}
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
            >
                <h2 className="text-xs font-black uppercase tracking-widest text-zinc-400 dark:text-zinc-500 mb-3">
                    Seus Números
                </h2>
                <div className="grid grid-cols-2 gap-3">
                    <StatCard
                        icon={<BookOpen className="h-4 w-4 text-blue-500" />}
                        label="Baralhos"
                        value={data.totalDecks}
                    />
                    <StatCard
                        icon={<Layers className="h-4 w-4 text-emerald-500" />}
                        label="Cards Totais"
                        value={data.totalCards}
                    />
                    <StatCard
                        icon={<TrendingUp className="h-4 w-4 text-purple-500" />}
                        label="Hoje"
                        value={`${data.todayCardsReviewed} revisões`}
                    />
                    <StatCard
                        icon={<Flame className="h-4 w-4 text-orange-500" />}
                        label="Streak"
                        value={`${data.streak} dias`}
                    />
                </div>
            </motion.div>

            {/* Quick Actions */}
            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.25 }}
            >
                <h2 className="text-xs font-black uppercase tracking-widest text-zinc-400 dark:text-zinc-500 mb-3">
                    Ações Rápidas
                </h2>
                <div className="flex gap-3">
                    <Link
                        href="/app"
                        className="flex-1 flex items-center justify-center gap-2 bg-brand text-white py-4 rounded-2xl font-bold active:scale-[0.98] transition-transform shadow-lg shadow-brand/20"
                    >
                        <Plus className="h-5 w-5" />
                        Novo Baralho
                    </Link>
                    <Link
                        href="/marketplace"
                        className="flex-1 flex items-center justify-center gap-2 bg-white dark:bg-zinc-900 border border-zinc-200 dark:border-zinc-800 py-4 rounded-2xl font-bold text-zinc-900 dark:text-white active:scale-[0.98] transition-transform"
                    >
                        <Sparkles className="h-5 w-5" />
                        Explorar
                    </Link>
                </div>
            </motion.div>
        </div>
    );
}

function MobileHomeDashboardSkeleton() {
    return (
        <div className="px-4 py-6 space-y-6 animate-pulse">
            {/* Welcome skeleton */}
            <div className="flex justify-between items-center">
                <div className="space-y-2">
                    <div className="h-4 w-20 bg-zinc-200 dark:bg-zinc-800 rounded" />
                    <div className="h-7 w-32 bg-zinc-200 dark:bg-zinc-800 rounded" />
                </div>
                <div className="h-8 w-16 bg-zinc-200 dark:bg-zinc-800 rounded-full" />
            </div>

            {/* Goal card skeleton */}
            <div className="h-40 bg-zinc-200 dark:bg-zinc-800 rounded-2xl" />

            {/* Continue studying skeleton */}
            <div className="space-y-3">
                <div className="h-3 w-32 bg-zinc-200 dark:bg-zinc-800 rounded" />
                <div className="h-20 bg-zinc-200 dark:bg-zinc-800 rounded-2xl" />
            </div>

            {/* Stats grid skeleton */}
            <div className="space-y-3">
                <div className="h-3 w-24 bg-zinc-200 dark:bg-zinc-800 rounded" />
                <div className="grid grid-cols-2 gap-3">
                    {[1, 2, 3, 4].map(i => (
                        <div key={i} className="h-20 bg-zinc-200 dark:bg-zinc-800 rounded-2xl" />
                    ))}
                </div>
            </div>

            {/* Actions skeleton */}
            <div className="space-y-3">
                <div className="h-3 w-28 bg-zinc-200 dark:bg-zinc-800 rounded" />
                <div className="flex gap-3">
                    <div className="flex-1 h-14 bg-zinc-200 dark:bg-zinc-800 rounded-2xl" />
                    <div className="flex-1 h-14 bg-zinc-200 dark:bg-zinc-800 rounded-2xl" />
                </div>
            </div>
        </div>
    );
}
