'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { trackEvent } from '@/lib/analytics';
import { Library, Folder, Calendar, ArrowRight, Loader2, Plus, Download, Trash2 } from 'lucide-react';
import ConfirmationModal from '@/components/ConfirmationModal';
import ExportModal from '@/components/ExportModal';
import Toast, { ToastType } from '@/components/Toast';
import StudyHeatmap from '@/components/StudyHeatmap';
import { addUtcDays, getDateKey, startOfUtcDay, StudyActivityRecord } from '@/lib/study-activity';
import AppShell from '@/components/AppShell';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

export default function DecksPage() {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [decks, setDecks] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [activityData, setActivityData] = useState<StudyActivityRecord[]>([]);
    const [deckToDelete, setDeckToDelete] = useState<string | null>(null);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const [deckToExport, setDeckToExport] = useState<any | null>(null);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);

    useEffect(() => {
        trackEvent('decks_view', { source: 'decks_page' });
    }, []);

    useEffect(() => {
        const fetchDecks = async () => {
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
                console.error(decksResult.error);
            } else {
                setDecks(decksResult.data || []);
            }

            if (activityResult.error) {
                console.error(activityResult.error);
            } else {
                setActivityData(activityResult.data || []);
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
            <AppShell
                eyebrow="MINHA BIBLIOTECA"
                title="Minha Biblioteca"
                subtitle="Todos os seus baralhos gerados e salvos."
                headerActions={(
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
                )}
                maxWidthClass="max-w-7xl"
            >

                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.1 }}
                    className="mb-10 bg-white border border-border rounded-sm p-6 shadow-sm"
                >
                    <StudyHeatmap activityData={activityData} ctaHref={ctaHref} />
                </m.div>

                {loading ? (
                    <div className="h-64 flex items-center justify-center">
                        <Loader2 className="h-8 w-8 animate-spin text-brand" />
                    </div>
                ) : decks.length === 0 ? (
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
                ) : (
                    <div id="decks-list" className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-x-px gap-y-px bg-zinc-200 dark:bg-zinc-800 border border-zinc-200 dark:border-zinc-800 overflow-hidden rounded-sm">
                        {decks.map((deck, index) => (
                            <m.div
                                key={deck.id}
                                custom={index}
                                initial="hidden"
                                animate="visible"
                                variants={cardVariants}
                                className="group bg-white dark:bg-zinc-950 p-8 hover:bg-zinc-50 dark:hover:bg-zinc-900 transition-colors relative h-full flex flex-col"
                            >
                                <div className="flex items-start justify-between mb-12">
                                    <span className="text-[10px] font-black uppercase tracking-[0.2em] text-zinc-400">
                                        {new Date(deck.created_at).toLocaleDateString()}
                                    </span>
                                    <button
                                        onClick={() => handleDeleteClick(deck.id)}
                                        className="opacity-0 group-hover:opacity-100 transition-opacity p-2 text-zinc-300 hover:text-red-500"
                                    >
                                        <Trash2 className="h-4 w-4" />
                                    </button>
                                </div>

                                <div className="flex-1">
                                    <h3 className="text-2xl font-black text-swiss-header mb-4 group-hover:text-brand transition-colors">
                                        {deck.title}
                                    </h3>
                                    <div className="flex items-center gap-3 mb-8">
                                        <div className="h-1 bg-zinc-100 dark:bg-zinc-900 flex-1">
                                            <div
                                                className="h-full bg-brand"
                                                style={{ width: `${Math.min(100, (deck.cards[0]?.count || 0) * 10)}%` }}
                                            />
                                        </div>
                                        <span className="text-[10px] font-bold text-zinc-400 uppercase tracking-widest">
                                            {deck.cards[0]?.count || 0} Cards
                                        </span>
                                    </div>
                                </div>

                                <div className="flex border border-zinc-100 dark:border-zinc-900 divide-x divide-zinc-100 dark:divide-zinc-900 mt-auto overflow-hidden rounded-sm">
                                    <button
                                        onClick={() => setDeckToExport(deck)}
                                        className="flex-1 py-3 text-[10px] font-black uppercase tracking-widest hover:bg-brand hover:text-white transition-all ripple"
                                    >
                                        Exportar
                                    </button>
                                    <Link
                                        href={`/decks/${deck.id}`}
                                        className="flex-1 py-3 text-[10px] font-black uppercase tracking-widest text-center hover:bg-zinc-900 dark:hover:bg-zinc-100 hover:text-white dark:hover:text-black transition-all ripple"
                                    >
                                        Abrir
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
            </AppShell>
        </LazyMotion>
    );
}
