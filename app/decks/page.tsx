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
                    <div id="decks-list" className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        {decks.map((deck, index) => (
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
