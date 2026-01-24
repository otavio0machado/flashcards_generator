'use client';

import React, { useEffect, useMemo, useState, use } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { deckService } from '@/services/deckService';
import { ArrowLeft, Loader2, FileDown, ExternalLink, Calendar, Layers, Copy, Tag, Star, BadgeCheck } from 'lucide-react';
import FlashcardPlayer from '@/components/FlashcardPlayer';
import ExportModal from '@/components/ExportModal';
import Toast, { ToastType } from '@/components/Toast';
import { buildCategoryLabelMap, Category } from '@/lib/category-utils';

interface Card {
    id: string;
    front: string;
    back: string;
    image_url?: string | null;
}

interface Deck {
    id: string;
    title: string;
    created_at: string;
    published_at?: string | null;
    tags?: string[];
    description?: string | null;
    price?: number;
    rating?: number;
    rating_count?: number;
    is_verified?: boolean;
    category?: Category | null;
    cards: Card[];
}

export default function MarketplaceDeckPage({ params }: { params: Promise<{ id: string }> }) {
    const resolvedParams = use(params);
    const [deck, setDeck] = useState<Deck | null>(null);
    const [loading, setLoading] = useState(true);
    const [mode, setMode] = useState<'overview' | 'study'>('overview');
    const [isExportModalOpen, setIsExportModalOpen] = useState(false);
    const [cloning, setCloning] = useState(false);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);
    const [categories, setCategories] = useState<Category[]>([]);

    const categoryLabels = useMemo(() => buildCategoryLabelMap(categories), [categories]);

    useEffect(() => {
        const fetchDeck = async (id: string) => {
            const { data, error } = await supabase
                .from('decks')
                .select('*, cards(*), category:categories(id, name, parent_id, slug)')
                .eq('id', id)
                .eq('is_public', true)
                .single();

            if (error) {
                console.error(error);
                setDeck(null);
            } else {
                setDeck(data);
            }
            setLoading(false);
        };

        if (resolvedParams.id) {
            fetchDeck(resolvedParams.id);
        }
    }, [resolvedParams.id]);

    useEffect(() => {
        const fetchCategories = async () => {
            const { data, error } = await supabase
                .from('categories')
                .select('id, name, parent_id, slug');

            if (error) {
                console.error(error);
                return;
            }

            setCategories(data || []);
        };

        fetchCategories();
    }, []);

    const handleClone = async () => {
        if (!deck || cloning) return;
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) {
            setToast({ message: 'Faca login para clonar', type: 'info' });
            return;
        }

        setCloning(true);
        try {
            await deckService.clonePublicDeck(session.user.id, deck.id);
            setToast({ message: 'Deck clonado com sucesso', type: 'success' });
        } catch (error) {
            console.error(error);
            setToast({ message: 'Erro ao clonar deck', type: 'error' });
        } finally {
            setCloning(false);
        }
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
                <h2 className="text-2xl font-bold mb-4">Deck nao encontrado</h2>
                <Link href="/marketplace" className="text-brand font-bold hover:underline">
                    Voltar para o Marketplace
                </Link>
            </div>
        );
    }

    const priceLabel = (() => {
        const value = typeof deck.price === 'number' ? deck.price : Number(deck.price || 0);
        if (!value) return 'Grátis';
        return value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    })();

    const categoryLabel = deck.category?.id
        ? categoryLabels[deck.category.id] || deck.category.name
        : undefined;

    return (
        <div className="relative overflow-hidden noise-bg">
            <div className="pointer-events-none absolute inset-x-0 top-0 h-72 bg-gradient-to-b from-brand/10 via-brand/5 to-transparent" />
            <div className="pointer-events-none absolute -right-10 top-24 h-64 w-64 rounded-full bg-brand/10 blur-3xl" />

            <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32 relative z-10">
                <Link
                    href="/marketplace"
                    className="inline-flex items-center gap-2 text-foreground/40 hover:text-brand transition-colors font-bold text-sm mb-8 group"
                >
                    <ArrowLeft className="h-4 w-4 group-hover:-translate-x-1 transition-transform" />
                    Voltar para o Marketplace
                </Link>

                <div className="mb-12 rounded-sm border border-border bg-white/80 backdrop-blur-sm shadow-sm">
                    <div className="flex flex-col md:flex-row md:items-end justify-between gap-6 p-6 md:p-8">
                        <div>
                            <div className="flex items-center gap-3 mb-4">
                                <div className="bg-brand/10 p-2 rounded-sm text-brand">
                                    <Layers className="h-5 w-5" />
                                </div>
                                <span className="text-[10px] font-black uppercase tracking-[0.2em] text-foreground/30">Deck Publico</span>
                                {deck.is_verified && (
                                    <span className="inline-flex items-center gap-1 text-[9px] font-black uppercase tracking-widest text-brand bg-brand/10 px-2 py-1 rounded-sm">
                                        <BadgeCheck className="h-3 w-3" />
                                        Verificado
                                    </span>
                                )}
                            </div>
                            <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-4">{deck.title}</h1>
                            {deck.description && (
                                <p className="text-foreground/60 font-medium max-w-2xl mb-4">
                                    {deck.description}
                                </p>
                            )}
                            <div className="flex flex-wrap items-center gap-3 text-sm font-bold text-foreground/40">
                                <div className="flex items-center gap-2">
                                    <Calendar className="h-4 w-4" />
                                    {new Date(deck.published_at || deck.created_at).toLocaleDateString('pt-BR')}
                                </div>
                                <div className="bg-gray-100/80 border border-border/60 px-3 py-1 rounded-sm text-foreground text-[10px]">
                                    {deck.cards.length} CARDS
                                </div>
                                {categoryLabel && (
                                    <div className="bg-gray-100/80 border border-border/60 px-3 py-1 rounded-sm text-[10px] uppercase tracking-widest font-black text-foreground/40">
                                        {categoryLabel}
                                    </div>
                                )}
                                <div className="bg-emerald-50 text-emerald-700 border border-emerald-100 px-3 py-1 rounded-sm text-[10px] uppercase tracking-widest font-black">
                                    {priceLabel}
                                </div>
                                {(deck.rating_count || 0) > 0 && (
                                    <div className="flex items-center gap-2 text-[10px] uppercase tracking-widest font-black text-foreground/40">
                                        <Star className="h-3 w-3" />
                                        {Number(deck.rating || 0).toFixed(1)} ({deck.rating_count})
                                    </div>
                                )}
                                {(deck.tags || []).length > 0 && (
                                    <div className="flex items-center gap-2 text-[10px] uppercase tracking-widest font-black text-foreground/40">
                                        <Tag className="h-3 w-3" />
                                        {(deck.tags || []).slice(0, 3).join(', ')}
                                    </div>
                                )}
                            </div>
                        </div>

                        <div className="flex flex-col sm:flex-row gap-3 w-full sm:w-auto">
                            <button
                                onClick={handleClone}
                                disabled={cloning}
                                className="w-full sm:w-auto bg-brand text-white px-6 py-3 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all flex items-center justify-center gap-2 shadow-lg shadow-brand/20 disabled:opacity-70 disabled:cursor-not-allowed"
                            >
                                <Copy className="h-4 w-4" />
                                {cloning ? 'Clonando...' : 'Clonar deck'}
                            </button>
                            <button
                                onClick={() => setIsExportModalOpen(true)}
                                className="w-full sm:w-auto bg-white/90 border border-border px-6 py-3 rounded-sm font-bold text-sm hover:bg-gray-50 transition-all flex items-center justify-center gap-2 shadow-sm"
                            >
                                <FileDown className="h-4 w-4 text-brand" />
                                Exportar
                            </button>
                            <button
                                onClick={() => setMode(mode === 'overview' ? 'study' : 'overview')}
                                className={`w-full sm:w-auto px-6 py-3 rounded-sm font-bold text-sm transition-all flex items-center justify-center gap-2 shadow-lg ${mode === 'study'
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
                </div>

                {mode === 'overview' ? (
                    <div className="grid grid-cols-1 gap-6">
                        {deck.cards.map((card, index) => (
                            <div key={card.id} className="bg-white border border-border/80 rounded-sm overflow-hidden shadow-sm hover:border-brand/40 hover:shadow-md transition-all duration-300 group">
                                <div className="grid grid-cols-1 md:grid-cols-2">
                                    <div className="p-8 border-b md:border-b-0 md:border-r border-border/60 relative">
                                        <span className="absolute top-4 left-4 text-[9px] font-black text-brand/30 uppercase tracking-widest">Frente #{index + 1}</span>
                                        {card.image_url && (
                                            <div className="mt-4">
                                                <img
                                                    src={card.image_url}
                                                    alt={`Imagem do card ${index + 1}`}
                                                    className="w-full h-48 object-cover rounded-sm border border-border"
                                                />
                                            </div>
                                        )}
                                        <div className="mt-4 text-lg font-bold text-foreground leading-relaxed">
                                            {card.front}
                                        </div>
                                    </div>
                                    <div className="p-8 bg-gray-50/60 relative">
                                        <span className="absolute top-4 left-4 text-[9px] font-black text-foreground/20 uppercase tracking-widest">Verso / Resposta</span>
                                        <div className="mt-4 text-lg font-medium text-foreground/70 leading-relaxed">
                                            {card.back}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                ) : (
                    <FlashcardPlayer cards={deck.cards} disableProgress />
                )}

                <ExportModal
                    isOpen={isExportModalOpen}
                    onClose={() => setIsExportModalOpen(false)}
                    deck={deck}
                />

                {toast && (
                    <Toast
                        message={toast.message}
                        type={toast.type}
                        onClose={() => setToast(null)}
                    />
                )}
            </div>
        </div>
    );
}
