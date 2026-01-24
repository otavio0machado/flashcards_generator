'use client';

import React, { useEffect, useMemo, useState, use } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { ArrowLeft, Loader2, FileDown, ExternalLink, Calendar, Layers, Globe, Lock, Tag } from 'lucide-react';
import FlashcardPlayer from '@/components/FlashcardPlayer';
import ExportModal from '@/components/ExportModal';
import Toast, { ToastType } from '@/components/Toast';
import { buildCategoryLabelMap, buildCategoryOptions, Category } from '@/lib/category-utils';

interface Card {
    id: string;
    front: string;
    back: string;
    next_review?: string;
    image_url?: string | null;
    question_image_url?: string | null;
    answer_image_url?: string | null;
}

interface Deck {
    id: string;
    user_id: string;
    title: string;
    created_at: string;
    is_public: boolean;
    published_at?: string | null;
    tags?: string[];
    description?: string | null;
    category_id?: string | null;
    category?: Category | null;
    price?: number;
    rating?: number;
    rating_count?: number;
    is_verified?: boolean;
    cards: Card[];
}

export default function DeckDetailPage({ params }: { params: Promise<{ id: string }> }) {
    const resolvedParams = use(params);
    const [deck, setDeck] = useState<Deck | null>(null);
    const [loading, setLoading] = useState(true);
    const [mode, setMode] = useState<'overview' | 'study'>('overview');
    const [isExportModalOpen, setIsExportModalOpen] = useState(false);
    const [studyCards, setStudyCards] = useState<Card[]>([]);
    const [studyLoading, setStudyLoading] = useState(false);
    const [isOwner, setIsOwner] = useState(false);
    const [publishLoading, setPublishLoading] = useState(false);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);
    const [categories, setCategories] = useState<Category[]>([]);
    const [metadataSaving, setMetadataSaving] = useState(false);
    const [deckDescription, setDeckDescription] = useState('');
    const [deckTagsInput, setDeckTagsInput] = useState('');
    const [selectedCategoryId, setSelectedCategoryId] = useState<string | null>(null);
    const categoryOptions = useMemo(() => buildCategoryOptions(categories), [categories]);
    const categoryLabels = useMemo(() => buildCategoryLabelMap(categories), [categories]);

    useEffect(() => {
        const fetchDeck = async (id: string) => {
            const { data: { session } } = await supabase.auth.getSession();
            const { data, error } = await supabase
                .from('decks')
                .select('*, cards(*), category:categories(id, name, parent_id, slug)')
                .eq('id', id)
                .single();

            if (error) {
                console.error(error);
            } else {
                setDeck(data);
                setIsOwner(session?.user?.id === data.user_id);
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

    useEffect(() => {
        if (!deck) return;
        setDeckDescription(deck.description || '');
        setDeckTagsInput((deck.tags || []).join(', '));
        setSelectedCategoryId(deck.category_id || deck.category?.id || null);
    }, [deck]);

    useEffect(() => {
        const fetchDueCards = async (id: string) => {
            setStudyLoading(true);
            const nowIso = new Date().toISOString();
            const { data, error } = await supabase
                .from('cards')
                .select('id, front, back, next_review, image_url')
                .eq('deck_id', id)
                .lte('next_review', nowIso)
                .order('next_review', { ascending: true });

            if (error) {
                console.error(error);
                setStudyCards([]);
            } else {
                setStudyCards(data || []);
            }
            setStudyLoading(false);
        };

        if (mode === 'study' && resolvedParams.id) {
            fetchDueCards(resolvedParams.id);
        }
    }, [mode, resolvedParams.id]);

    const parseTags = (value: string) => {
        const rawTags = value
            .split(',')
            .map((tag) => tag.trim())
            .filter(Boolean);

        const seen = new Set<string>();
        const normalized: string[] = [];

        for (const tag of rawTags) {
            const key = tag.toLowerCase();
            if (!seen.has(key)) {
                seen.add(key);
                normalized.push(key);
            }
        }

        return normalized.slice(0, 10);
    };

    const handleSaveMetadata = async () => {
        if (!deck || metadataSaving || !isOwner) return;
        setMetadataSaving(true);

        const tags = parseTags(deckTagsInput);
        const description = deckDescription.trim();

        const { data, error } = await supabase
            .from('decks')
            .update({
                description: description || null,
                tags,
                category_id: selectedCategoryId || null
            })
            .eq('id', deck.id)
            .select('description, tags, category_id, category:categories(id, name, parent_id, slug)')
            .single();

        if (error) {
            console.error(error);
            setToast({ message: 'Erro ao salvar detalhes do baralho', type: 'error' });
        } else if (data) {
            const updatedCategory = selectedCategoryId
                ? categories.find((category) => category.id === selectedCategoryId) ?? null
                : null;
            setDeck({
                ...deck,
                description: data.description,
                tags: data.tags,
                category_id: data.category_id,
                category: updatedCategory
            });
            setToast({ message: 'Detalhes do baralho atualizados', type: 'success' });
        }

        setMetadataSaving(false);
    };

    const handleTogglePublish = async () => {
        if (!deck || publishLoading) return;
        setPublishLoading(true);
        const nextPublic = !deck.is_public;

        const { data, error } = await supabase
            .from('decks')
            .update({
                is_public: nextPublic,
                published_at: nextPublic ? new Date().toISOString() : null
            })
            .eq('id', deck.id)
            .select('id, is_public, published_at')
            .single();

        if (error) {
            setToast({ message: 'Erro ao atualizar visibilidade', type: 'error' });
        } else if (data) {
            setDeck({ ...deck, is_public: data.is_public, published_at: data.published_at });
            setToast({
                message: data.is_public ? 'Deck publicado no marketplace' : 'Deck removido do marketplace',
                type: 'success'
            });
        }

        setPublishLoading(false);
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
                <h2 className="text-2xl font-bold mb-4">Baralho não encontrado</h2>
                <Link href="/decks" className="text-brand font-bold hover:underline">
                    Voltar para a Biblioteca
                </Link>
            </div>
        );
    }

    const categoryLabel = deck.category?.id
        ? categoryLabels[deck.category.id] || deck.category.name
        : deck.category_id
            ? categoryLabels[deck.category_id]
            : undefined;

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
                    {deck.description && (
                        <p className="text-foreground/60 font-medium max-w-2xl mb-4">
                            {deck.description}
                        </p>
                    )}
                    <div className="flex flex-wrap items-center gap-4 text-sm font-bold text-foreground/40">
                        <div className="flex items-center gap-2">
                            <Calendar className="h-4 w-4" />
                            {new Date(deck.created_at).toLocaleDateString('pt-BR')}
                        </div>
                        <div className="bg-gray-100 px-3 py-1 rounded-sm text-foreground text-[10px]">
                            {deck.cards.length} CARDS
                        </div>
                        {categoryLabel && (
                            <div className="bg-gray-100 px-3 py-1 rounded-sm text-[10px] uppercase tracking-widest font-black text-foreground/40">
                                {categoryLabel}
                            </div>
                        )}
                        <div className={`flex items-center gap-2 px-3 py-1 rounded-sm text-[10px] uppercase tracking-widest font-black ${deck.is_public ? 'bg-brand/10 text-brand' : 'bg-gray-100 text-foreground/40'}`}>
                            {deck.is_public ? <Globe className="h-3 w-3" /> : <Lock className="h-3 w-3" />}
                            {deck.is_public ? 'Publicado' : 'Privado'}
                        </div>
                        {(deck.tags || []).length > 0 && (
                            <div className="flex items-center gap-2 text-[10px] uppercase tracking-widest font-black text-foreground/40">
                                <Tag className="h-3 w-3" />
                                {(deck.tags || []).slice(0, 3).join(', ')}
                            </div>
                        )}
                    </div>
                </div>

                <div className="flex flex-col sm:flex-row gap-3 w-full sm:w-auto">
                    {deck.is_public && (
                        <Link
                            href={`/marketplace/${deck.id}`}
                            className="w-full sm:w-auto bg-gray-50 border border-border px-6 py-3 rounded-sm font-bold text-sm hover:bg-white transition-all flex items-center justify-center gap-2 shadow-sm"
                        >
                            <Globe className="h-4 w-4 text-brand" />
                            Ver no Marketplace
                        </Link>
                    )}
                    <button
                        onClick={() => setIsExportModalOpen(true)}
                        className="w-full sm:w-auto bg-white border border-border px-6 py-3 rounded-sm font-bold text-sm hover:bg-gray-50 transition-all flex items-center justify-center gap-2 shadow-sm"
                    >
                        <FileDown className="h-4 w-4 text-brand" />
                        Exportar
                    </button>
                    {isOwner && (
                        <button
                            onClick={handleTogglePublish}
                            disabled={publishLoading}
                            className={`w-full sm:w-auto px-6 py-3 rounded-sm font-bold text-sm transition-all flex items-center justify-center gap-2 shadow-sm ${deck.is_public
                                ? 'bg-gray-100 text-foreground hover:bg-gray-200'
                                : 'bg-brand text-white hover:bg-brand/90 shadow-brand/20'
                                } ${publishLoading ? 'opacity-70 cursor-not-allowed' : ''}`}
                        >
                            {deck.is_public ? 'Remover do Marketplace' : 'Publicar no Marketplace'}
                        </button>
                    )}
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

            {isOwner && (
                <div className="bg-white border border-border rounded-sm p-6 shadow-sm mb-10">
                    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-5">
                        <h3 className="text-sm font-bold uppercase tracking-widest text-foreground/40">Detalhes do Baralho</h3>
                        <button
                            onClick={handleSaveMetadata}
                            disabled={metadataSaving}
                            className="px-4 py-2 bg-brand text-white rounded-sm text-xs font-bold uppercase tracking-widest hover:bg-brand/90 transition-all disabled:opacity-60 disabled:cursor-not-allowed"
                        >
                            {metadataSaving ? 'Salvando...' : 'Salvar detalhes'}
                        </button>
                    </div>
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div className="md:col-span-2 space-y-1">
                            <label htmlFor="deck-meta-description" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                Descrição
                            </label>
                            <textarea
                                id="deck-meta-description"
                                value={deckDescription}
                                onChange={(event) => setDeckDescription(event.target.value)}
                                rows={3}
                                className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground/80 focus:ring-1 focus:ring-brand outline-none resize-none"
                                placeholder="Fale sobre o conteúdo e o objetivo deste baralho."
                            />
                        </div>
                        <div className="space-y-1">
                            <label htmlFor="deck-meta-category" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                Categoria
                            </label>
                            <select
                                id="deck-meta-category"
                                value={selectedCategoryId || ''}
                                onChange={(event) => setSelectedCategoryId(event.target.value || null)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-sm font-bold focus:ring-1 focus:ring-brand outline-none pr-8 cursor-pointer"
                            >
                                <option value="">Sem categoria</option>
                                {categoryOptions.map((option) => (
                                    <option key={option.id} value={option.id}>
                                        {option.label}
                                    </option>
                                ))}
                            </select>
                        </div>
                        <div className="space-y-1">
                            <label htmlFor="deck-meta-tags" className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                                Tags (separadas por vírgulas)
                            </label>
                            <input
                                id="deck-meta-tags"
                                type="text"
                                value={deckTagsInput}
                                onChange={(event) => setDeckTagsInput(event.target.value)}
                                className="w-full bg-gray-50 border border-border rounded-sm px-3 py-2 text-sm font-medium text-foreground/80 focus:ring-1 focus:ring-brand outline-none"
                                placeholder="ex: anatomia, cardio, prova"
                            />
                        </div>
                    </div>
                </div>
            )}

            {mode === 'overview' ? (
                <div className="grid grid-cols-1 gap-6">
                    {deck.cards.map((card, index) => (
                        <div key={card.id} className="bg-white border border-border rounded-sm overflow-hidden shadow-sm hover:border-brand/40 transition-all group">
                            <div className="grid grid-cols-1 md:grid-cols-2">
                                <div className="p-8 border-b md:border-b-0 md:border-r border-border relative">
                                    <span className="absolute top-4 left-4 text-[9px] font-black text-brand/20 uppercase tracking-widest">Frente #{index + 1}</span>
                                    {(card.question_image_url || card.image_url) && (
                                        <div className="mt-4">
                                            <img
                                                src={card.question_image_url || card.image_url || ''}
                                                alt={`Imagem do card ${index + 1}`}
                                                className="w-full h-48 object-cover rounded-sm border border-border"
                                            />
                                        </div>
                                    )}
                                    <div className="mt-4 text-lg font-bold text-foreground leading-relaxed">
                                        {card.front}
                                    </div>
                                </div>
                                <div className="p-8 bg-gray-50/50 relative">
                                    <span className="absolute top-4 left-4 text-[9px] font-black text-foreground/10 uppercase tracking-widest">Verso / Resposta</span>
                                    {card.answer_image_url && (
                                        <div className="mt-4">
                                            <img
                                                src={card.answer_image_url}
                                                alt={`Imagem da resposta ${index + 1}`}
                                                className="w-full h-48 object-cover rounded-sm border border-border"
                                            />
                                        </div>
                                    )}
                                    <div className="mt-4 text-lg font-medium text-foreground/60 leading-relaxed">
                                        {card.back}
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            ) : (
                studyLoading ? (
                    <div className="h-64 flex items-center justify-center">
                        <Loader2 className="h-8 w-8 animate-spin text-brand" />
                    </div>
                ) : (
                    <FlashcardPlayer cards={studyCards} disableProgress={!isOwner} />
                )
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
    );
}
