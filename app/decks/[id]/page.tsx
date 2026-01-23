'use client';

import React, { useEffect, useState, use } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { ArrowLeft, Loader2, FileDown, ExternalLink, Calendar, Layers } from 'lucide-react';
import FlashcardPlayer from '@/components/FlashcardPlayer';

interface Card {
    id: string;
    front: string;
    back: string;
}

interface Deck {
    id: string;
    title: string;
    created_at: string;
    cards: Card[];
}

export default function DeckDetailPage({ params }: { params: Promise<{ id: string }> }) {
    const resolvedParams = use(params);
    const [deck, setDeck] = useState<Deck | null>(null);
    const [loading, setLoading] = useState(true);
    const [mode, setMode] = useState<'overview' | 'study'>('overview');

    useEffect(() => {
        if (resolvedParams.id) {
            fetchDeck(resolvedParams.id);
        }
    }, [resolvedParams.id]);

    const fetchDeck = async (id: string) => {
        const { data, error } = await supabase
            .from('decks')
            .select('*, cards(*)')
            .eq('id', id)
            .single();

        if (error) {
            console.error(error);
        } else {
            setDeck(data);
        }
        setLoading(false);
    };

    const exportToAnki = () => {
        if (!deck) return;
        const content = deck.cards.map(c => `${c.front}\t${c.back}`).join('\n');
        const blob = new Blob([content], { type: 'text/plain;charset=utf-8' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = `${deck.title.toLowerCase().replace(/\s+/g, '-')}-anki.txt`;
        link.click();
    };

    if (loading) {
        return (
            <div className="min-h-screen flex items-center justify-center pt-20">
                <Loader2 className="h-8 w-8 animate-spin text-brand" />
            </div>
        );
    }

    if (!deck) {
        return (
            <div className="min-h-screen flex flex-col items-center justify-center pt-20 px-4">
                <h1 className="text-2xl font-bold mb-4">Baralho não encontrado</h1>
                <Link href="/decks" className="text-brand font-bold hover:underline">
                    Voltar para a Biblioteca
                </Link>
            </div>
        );
    }

    return (
        <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
            <Link
                href="/decks"
                className="inline-flex items-center gap-2 text-foreground/40 hover:text-brand transition-colors font-bold text-sm mb-8 group"
            >
                <ArrowLeft className="h-4 w-4 group-hover:-translate-x-1 transition-transform" />
                Voltar para Biblioteca
            </Link>

            <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12 border-b border-border pb-12">
                <div>
                    <div className="flex items-center gap-3 mb-4">
                        <div className="bg-brand/10 p-2 rounded-sm text-brand">
                            <Layers className="h-5 w-5" />
                        </div>
                        <span className="text-[10px] font-black uppercase tracking-[0.2em] text-foreground/30">Visualizando Baralho</span>
                    </div>
                    <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{deck.title}</h1>
                    <div className="flex items-center gap-6 text-sm font-bold text-foreground/40">
                        <div className="flex items-center gap-2">
                            <Calendar className="h-4 w-4" />
                            {new Date(deck.created_at).toLocaleDateString('pt-BR')}
                        </div>
                        <div className="bg-gray-100 px-3 py-1 rounded-sm text-foreground text-[10px]">
                            {deck.cards.length} CARDS
                        </div>
                    </div>
                </div>

                <div className="flex gap-3">
                    <button
                        onClick={exportToAnki}
                        className="bg-white border border-border px-6 py-3 rounded-sm font-bold text-sm hover:bg-gray-50 transition-all flex items-center gap-2 shadow-sm"
                    >
                        <FileDown className="h-4 w-4 text-brand" />
                        Exportar Anki
                    </button>
                    <button
                        onClick={() => setMode(mode === 'overview' ? 'study' : 'overview')}
                        className={`px-6 py-3 rounded-sm font-bold text-sm transition-all flex items-center gap-2 shadow-lg ${mode === 'study'
                            ? 'bg-gray-100 text-foreground hover:bg-gray-200'
                            : 'bg-brand text-white hover:bg-brand/90 shadow-brand/20'
                            }`}
                    >
                        {mode === 'overview' ? (
                            <>
                                Estudar agora
                                <ExternalLink className="h-4 w-4" />
                            </>
                        ) : (
                            <>
                                <Layers className="h-4 w-4" />
                                Ver Lista
                            </>
                        )}
                    </button>
                </div>
            </div>

            {mode === 'overview' ? (
                <div className="grid grid-cols-1 gap-6">
                    {deck.cards.map((card, index) => (
                        <div key={card.id} className="bg-white border border-border rounded-sm overflow-hidden shadow-sm hover:border-brand/40 transition-all group">
                            <div className="grid grid-cols-1 md:grid-cols-2">
                                <div className="p-8 border-b md:border-b-0 md:border-r border-border relative">
                                    <span className="absolute top-4 left-4 text-[9px] font-black text-brand/20 uppercase tracking-widest">Frente #{index + 1}</span>
                                    <div className="mt-4 text-lg font-bold text-foreground leading-relaxed">
                                        {card.front}
                                    </div>
                                </div>
                                <div className="p-8 bg-gray-50/50 relative">
                                    <span className="absolute top-4 left-4 text-[9px] font-black text-foreground/10 uppercase tracking-widest">Verso / Resposta</span>
                                    <div className="mt-4 text-lg font-medium text-foreground/60 leading-relaxed">
                                        {card.back}
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            ) : (
                <FlashcardPlayer cards={deck.cards} />
            )}
        </div>
    );
}
