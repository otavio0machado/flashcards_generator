'use client';

import React, { useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { trackEvent } from '@/lib/analytics';
import { saveDecksToCache, getDecksFromCache } from '@/lib/offline-cache';
import { Library, Folder, Calendar, ArrowRight, Plus, Download, Trash2, Search, SortDesc } from 'lucide-react';
import { DeckCardSkeleton } from '@/components/Skeleton';
import ConfirmationModal from '@/components/ConfirmationModal';
import ExportModal from '@/components/ExportModal';
import Toast, { ToastType } from '@/components/Toast';
import StudyHeatmap from '@/components/StudyHeatmap';
import { addUtcDays, getDateKey, startOfUtcDay, StudyActivityRecord } from '@/lib/study-activity';
import SectionLabel from '@/components/SectionLabel';

interface UserDeck {
    id: string;
    title: string;
    description?: string | null;
    tags?: string[];
    created_at: string;
    cards: { count: number }[];
}

export default function DecksPage() {
    const [decks, setDecks] = useState<UserDeck[]>([]);
    const [loading, setLoading] = useState(true);
    const [activityData, setActivityData] = useState<StudyActivityRecord[]>([]);
    const [deckToDelete, setDeckToDelete] = useState<string | null>(null);
    const [deckToExport, setDeckToExport] = useState<UserDeck | null>(null);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);
    const [search, setSearch] = useState('');
    const [sortBy, setSortBy] = useState<'newest' | 'oldest' | 'cards'>('newest');
    const [isOffline, setIsOffline] = useState(false);

    useEffect(() => {
        trackEvent('decks_view', { source: 'decks_page' });
    }, []);

    useEffect(() => {
        const fetchDecks = async () => {
            try {
                const { data: { session } } = await supabase.auth.getSession();
                if (!session) return;

                const startDate = addUtcDays(startOfUtcDay(new Date()), -120);
                const startKey = getDateKey(startDate);

                const [decksResult, activityResult] = await Promise.all([
                    supabase
                        .from('decks')
                        .select('*, cards(count)')
                        .eq('user_id', session.user.id)
                        .order('created_at', { ascending: false }),
                    supabase
                        .from('study_activity')
                        .select('day, count')
                        .eq('user_id', session.user.id)
                        .gte('day', startKey)
                ]);

                if (decksResult.error) {
                    throw decksResult.error;
                }

                setDecks(decksResult.data || []);
                // Cache decks for offline use (only on successful fetch)
                saveDecksToCache(decksResult.data || []);

                if (activityResult.error) {
                    console.error(activityResult.error);
                } else {
                    setActivityData(activityResult.data || []);
                }
            } catch (err) {
                console.error('[decks] Fetch failed, trying offline cache:', err);
                try {
                    const cached = await getDecksFromCache();
                    if (cached.length > 0) {
                        setDecks(cached as UserDeck[]);
                        setIsOffline(true);
                        setToast({ message: 'Modo offline \u2014 mostrando dados salvos', type: 'info' });
                    }
                } catch (cacheErr) {
                    console.error('[decks] Cache read also failed:', cacheErr);
                }
            }

            setLoading(false);
        };

        fetchDecks();
    }, []);

    const handleDeleteClick = (id: string) => {
        setDeckToDelete(id);
    };

    const confirmDelete = async () => {
        if (!deckToDelete) return;

        const { error } = await supabase.from('decks').delete().eq('id', deckToDelete);
        if (error) {
            setToast({ message: 'Erro ao excluir o baralho', type: 'error' });
        } else {
            setDecks(decks.filter(d => d.id !== deckToDelete));
            setToast({ message: 'Baralho removido com sucesso!', type: 'success' });
            trackEvent('deck_deleted', { source: 'decks_page' });
        }
        setDeckToDelete(null);
    };

    const filteredDecks = useMemo(() => {
        const query = search.trim().toLowerCase();
        let result = decks.filter((deck) => {
            if (!query) return true;
            return deck.title?.toLowerCase().includes(query)
                || (deck.description || '').toLowerCase().includes(query)
                || (deck.tags || []).some((t: string) => t.toLowerCase().includes(query));
        });
        if (sortBy === 'oldest') {
            result = [...result].sort((a, b) => new Date(a.created_at).getTime() - new Date(b.created_at).getTime());
        } else if (sortBy === 'cards') {
            result = [...result].sort((a, b) => (b.cards?.[0]?.count || 0) - (a.cards?.[0]?.count || 0));
        }
        // 'newest' is the default order from the DB query
        return result;
    }, [decks, search, sortBy]);

    const ctaHref = decks.length > 0 ? '#decks-list' : '/app';

    const cardVariants = {
        hidden: { opacity: 0, y: 20 },
        visible: (i: number) => ({
            opacity: 1,
            y: 0,
            transition: { delay: i * 0.05, duration: 0.3 }
        })
    };

    return (
        <LazyMotion features={domAnimation}>
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12"
                >
                    <div>
                        <SectionLabel text="MINHA BIBLIOTECA" />
                        <h1 className="text-4xl font-bold tracking-tight mb-2">Minha Biblioteca</h1>
                        <p className="text-foreground/60 font-medium">Todos os seus baralhos gerados e salvos.</p>
                    </div>
                    <m.div
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                    >
                        <Link
                            href="/app"
                            className="group bg-brand text-white px-6 py-3 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 self-stretch sm:self-start w-full sm:w-auto"
                        >
                            <Plus className="h-5 w-5" />
                            Novo Baralho
                        </Link>
                    </m.div>
                </m.div>

                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.1 }}
                    className="mb-10 bg-white border border-border rounded-sm p-6 shadow-sm"
                >
                    <StudyHeatmap activityData={activityData} ctaHref={ctaHref} />
                </m.div>

                {decks.length > 0 && (
                    <m.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.15 }}
                        className="bg-white border border-border rounded-sm p-4 mb-10 shadow-sm"
                    >
                        <div className="flex flex-col gap-3 sm:flex-row sm:items-center">
                            <div className="flex items-center gap-3 flex-1">
                                <Search className="h-4 w-4 text-foreground/40" />
                                <input
                                    value={search}
                                    onChange={(e) => setSearch(e.target.value)}
                                    placeholder="Buscar por título, descrição ou tag..."
                                    aria-label="Buscar baralhos"
                                    className="w-full bg-transparent text-sm font-medium text-foreground placeholder:text-foreground/40 focus:outline-none focus-visible:ring-2 focus-visible:ring-brand/30 rounded-sm"
                                />
                            </div>
                            <div className="flex items-center gap-2">
                                <SortDesc className="h-4 w-4 text-foreground/30" />
                                <select
                                    value={sortBy}
                                    onChange={(e) => setSortBy(e.target.value as 'newest' | 'oldest' | 'cards')}
                                    className="appearance-none bg-gray-50 border border-border px-3 py-1.5 rounded-sm text-xs font-bold uppercase tracking-widest text-foreground/60 focus:ring-1 focus:ring-brand outline-none"
                                >
                                    <option value="newest">Mais recentes</option>
                                    <option value="oldest">Mais antigos</option>
                                    <option value="cards">Mais cards</option>
                                </select>
                            </div>
                        </div>
                    </m.div>
                )}

                {loading ? (
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {Array.from({ length: 6 }).map((_, i) => (
                            <DeckCardSkeleton key={i} />
                        ))}
                    </div>
                ) : filteredDecks.length === 0 && decks.length === 0 ? (
                    <m.div
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        className="border-2 border-dashed border-border rounded-sm py-20 sm:py-32 flex flex-col items-center justify-center text-center px-4 bg-white/50"
                    >
                        <div className="bg-gray-100 p-6 rounded-full mb-6">
                            <Library className="h-10 w-10 text-foreground/20" />
                        </div>
                        <h3 className="text-xl font-bold mb-2">Sua biblioteca está vazia</h3>
                        <p className="text-foreground/40 font-medium max-w-xs mb-8">
                            Gere seu primeiro baralho usando nossa IA para começar a estudar.
                        </p>
                        <Link href="/app" className="group text-brand font-bold hover:underline underline-offset-4 inline-flex items-center gap-2">
                            Ir para o Gerador
                            <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                        </Link>
                    </m.div>
                ) : filteredDecks.length === 0 ? (
                    <m.div
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        className="border-2 border-dashed border-border rounded-sm py-16 flex flex-col items-center justify-center text-center px-4 bg-white/50"
                    >
                        <div className="bg-gray-100 p-4 rounded-full mb-4">
                            <Search className="h-8 w-8 text-foreground/20" />
                        </div>
                        <h3 className="text-lg font-bold mb-2">Nenhum baralho encontrado</h3>
                        <p className="text-foreground/40 font-medium text-sm max-w-xs">
                            Tente outro termo de busca ou limpe o filtro.
                        </p>
                        <button
                            onClick={() => { setSearch(''); setSortBy('newest'); }}
                            className="mt-4 text-brand font-bold text-sm hover:underline"
                        >
                            Limpar filtros
                        </button>
                    </m.div>
                ) : (
                    <div id="decks-list" className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {filteredDecks.map((deck, index) => (
                            <m.div
                                key={deck.id}
                                custom={index}
                                initial="hidden"
                                animate="visible"
                                variants={cardVariants}
                                whileHover={{ y: -4 }}
                                className="group bg-white border border-border p-6 rounded-sm shadow-sm hover:border-brand/40 transition-all relative overflow-hidden"
                            >
                                <div className="flex items-start justify-between mb-8">
                                    <div className="bg-brand/10 p-2 rounded-sm">
                                        <Folder className="h-5 w-5 text-brand" />
                                    </div>
                                    <button
                                        onClick={() => handleDeleteClick(deck.id)}
                                        className="text-foreground/20 hover:text-red-500 transition-colors p-1"
                                    >
                                        <Trash2 className="h-4 w-4" />
                                    </button>
                                </div>

                                <h3 className="text-xl font-bold mb-2 group-hover:text-brand transition-colors line-clamp-1">
                                    {deck.title}
                                </h3>

                                <div className="flex items-center gap-4 text-xs font-bold text-foreground/40 mb-8">
                                    <div className="flex items-center gap-1.5">
                                        <Calendar className="h-3.5 w-3.5" />
                                        {new Date(deck.created_at).toLocaleDateString()}
                                    </div>
                                    <div className="bg-gray-100 px-2 py-0.5 rounded-sm">
                                        {deck.cards[0]?.count || 0} CARDS
                                    </div>
                                </div>

                                <div className="flex flex-col sm:flex-row gap-2">
                                    <button
                                        onClick={() => setDeckToExport(deck)}
                                        className="w-full sm:flex-1 bg-white border border-border py-2 rounded-sm text-xs font-bold hover:bg-gray-50 transition-all flex items-center justify-center gap-2"
                                    >
                                        <Download className="h-3.5 w-3.5" />
                                        Exportar
                                    </button>
                                    <Link
                                        href={`/decks/${deck.id}`}
                                        className="group/link w-full sm:flex-1 bg-gray-50 border border-border py-2 rounded-sm text-xs font-bold text-center hover:bg-white transition-all flex items-center justify-center gap-2"
                                    >
                                        Ver Cards
                                        <ArrowRight className="h-3.5 w-3.5 cta-arrow-shift" />
                                    </Link>
                                </div>
                            </m.div>
                        ))}
                    </div>
                )}

                <ConfirmationModal
                    isOpen={!!deckToDelete}
                    onClose={() => setDeckToDelete(null)}
                    onConfirm={confirmDelete}
                    title="Excluir Baralho"
                    description="Tem certeza que deseja excluir este baralho? Todos os cartões associados serão removidos permanentemente."
                    confirmText="Excluir Agora"
                    cancelText="Manter Baralho"
                    variant="danger"
                />

                <ExportModal
                    isOpen={!!deckToExport}
                    onClose={() => setDeckToExport(null)}
                    deck={deckToExport}
                />

                {toast && (
                    <Toast
                        message={toast.message}
                        type={toast.type}
                        onClose={() => setToast(null)}
                    />
                )}
            </div>
        </LazyMotion>
    );
}
