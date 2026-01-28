'use client';

import React, { useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { supabase } from '@/lib/supabase';
import { trackEvent } from '@/lib/analytics';
import { deckService } from '@/services/deckService';
import { Search, Loader2, Layers, ArrowRight, Copy, Tag, Star, BadgeCheck, ChevronDown } from 'lucide-react';
import Toast, { ToastType } from '@/components/Toast';
import AppShell from '@/components/AppShell';
import { buildCategoryLabelMap, buildCategoryOptions, Category } from '@/lib/category-utils';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

interface PublicDeck {
    id: string;
    title: string;
    description?: string | null;
    price?: number;
    rating?: number;
    rating_count?: number;
    is_verified?: boolean;
    tags?: string[];
    created_at: string;
    published_at?: string | null;
    cards: { count: number }[];
    category?: Category | null;
}

export default function MarketplacePage() {
    const [decks, setDecks] = useState<PublicDeck[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [activeTag, setActiveTag] = useState<string | null>(null);
    const [categories, setCategories] = useState<Category[]>([]);
    const [activeCategoryId, setActiveCategoryId] = useState<string | null>(null);
    const [cloningId, setCloningId] = useState<string | null>(null);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);

    useEffect(() => {
        trackEvent('marketplace_view', { source: 'marketplace_page' });
    }, []);

    useEffect(() => {
        const fetchDecks = async () => {
            setLoading(true);
            const [decksResult, categoriesResult] = await Promise.all([
                supabase
                    .from('decks')
                    .select('id, title, description, price, rating, rating_count, is_verified, tags, created_at, published_at, cards(count), category:categories(id, name, parent_id, slug)')
                    .eq('is_public', true)
                    .order('published_at', { ascending: false, nullsFirst: false })
                    .order('created_at', { ascending: false }),
                supabase
                    .from('categories')
                    .select('id, name, parent_id, slug')
            ]);

            if (decksResult.error) {
                console.error(decksResult.error);
                setToast({ message: 'Erro ao carregar marketplace', type: 'error' });
                setDecks([]);
            } else {
                const normalized = (decksResult.data || []).map((deck) => ({
                    ...deck,
                    category: Array.isArray(deck.category) ? deck.category[0] ?? null : deck.category
                }));
                setDecks(normalized);
            }

            if (categoriesResult.error) {
                console.error(categoriesResult.error);
            } else {
                setCategories(categoriesResult.data || []);
            }
            setLoading(false);
        };

        fetchDecks();
    }, []);

    const tags = useMemo(() => {
        const tagSet = new Set<string>();
        decks.forEach((deck) => {
            (deck.tags || []).forEach((tag) => {
                if (tag) tagSet.add(tag);
            });
        });
        return Array.from(tagSet).slice(0, 10);
    }, [decks]);

    const categoryOptions = useMemo(() => buildCategoryOptions(categories), [categories]);
    const categoryLabels = useMemo(() => buildCategoryLabelMap(categories), [categories]);

    const filteredDecks = useMemo(() => {
        const query = search.trim().toLowerCase();
        return decks.filter((deck) => {
            const categoryLabel = deck.category?.id ? (categoryLabels[deck.category.id] || deck.category.name || '') : '';
            const matchesQuery = !query
                || deck.title.toLowerCase().includes(query)
                || (deck.description || '').toLowerCase().includes(query)
                || categoryLabel.toLowerCase().includes(query)
                || (deck.tags || []).some((tag) => tag.toLowerCase().includes(query));

            const matchesTag = !activeTag || (deck.tags || []).includes(activeTag);
            const matchesCategory = !activeCategoryId || deck.category?.id === activeCategoryId;
            return matchesQuery && matchesTag && matchesCategory;
        });
    }, [decks, search, activeTag, activeCategoryId, categoryLabels]);

    const formatPrice = (price?: number) => {
        const value = typeof price === 'number' ? price : Number(price || 0);
        if (!value) return 'Grátis';
        return value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    };

    const handleClone = async (deckId: string) => {
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) {
            setToast({ message: 'Faca login para clonar', type: 'info' });
            return;
        }

        setCloningId(deckId);
        trackEvent('deck_clone_started', { deckId, source: 'marketplace_page' });
        try {
            await deckService.clonePublicDeck(session.user.id, deckId);
            setToast({ message: 'Deck clonado com sucesso', type: 'success' });
            trackEvent('deck_clone_completed', { deckId, source: 'marketplace_page' });
        } catch (error) {
            console.error(error);
            setToast({ message: 'Erro ao clonar deck', type: 'error' });
        } finally {
            setCloningId(null);
        }
    };

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
                eyebrow="MARKETPLACE"
                title="Marketplace de Decks"
                subtitle="Explore decks publicados pela comunidade e clone direto para a sua biblioteca."
                headerActions={(
                    <m.div
                        whileHover={{ scale: 1.02 }}
                        whileTap={{ scale: 0.98 }}
                    >
                        <Link
                            href="/app"
                            className="group bg-brand text-white px-6 py-3 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 w-auto"
                        >
                            <Layers className="h-4 w-4" />
                            Criar meu deck
                        </Link>
                    </m.div>
                )}
                maxWidthClass="max-w-7xl"
            >

                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.1 }}
                    className="bg-white border border-border rounded-sm p-4 mb-10 shadow-sm"
                >
                    <div className="flex flex-col gap-4 sm:flex-row sm:items-center">
                        <div className="flex items-center gap-3 flex-1">
                            <Search className="h-4 w-4 text-foreground/40" />
                            <input
                                value={search}
                                onChange={(event) => setSearch(event.target.value)}
                                placeholder="Buscar por titulo, tag ou categoria"
                                className="w-full bg-transparent text-sm font-medium text-foreground placeholder:text-foreground/40 focus:outline-none"
                            />
                        </div>
                        <div className="relative w-full sm:w-64">
                            <select
                                value={activeCategoryId || ''}
                                onChange={(event) => setActiveCategoryId(event.target.value || null)}
                                className="w-full appearance-none bg-gray-50 border border-border px-3 py-2 rounded-sm text-xs font-bold uppercase tracking-widest text-foreground/60 focus:ring-1 focus:ring-brand outline-none pr-8"
                            >
                                <option value="">Todas as categorias</option>
                                {categoryOptions.map((option) => (
                                    <option key={option.id} value={option.id}>
                                        {option.label}
                                    </option>
                                ))}
                            </select>
                            <ChevronDown className="absolute right-2 top-1/2 -translate-y-1/2 h-4 w-4 text-foreground/30 pointer-events-none" />
                        </div>
                    </div>
                    {tags.length > 0 && (
                        <div className="flex flex-wrap gap-2 mt-4">
                            <m.button
                                whileHover={{ scale: 1.02 }}
                                whileTap={{ scale: 0.98 }}
                                onClick={() => setActiveTag(null)}
                                className={`px-3 py-1 rounded-sm text-[10px] font-bold uppercase tracking-widest border transition-all ${!activeTag ? 'bg-brand text-white border-brand' : 'bg-gray-50 text-foreground/60 border-border hover:border-brand/40'}`}
                            >
                                Todos
                            </m.button>
                            {tags.map((tag) => (
                                <m.button
                                    key={tag}
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    onClick={() => setActiveTag(tag)}
                                    className={`px-3 py-1 rounded-sm text-[10px] font-bold uppercase tracking-widest border transition-all ${activeTag === tag ? 'bg-brand text-white border-brand' : 'bg-gray-50 text-foreground/60 border-border hover:border-brand/40'}`}
                                >
                                    <span className="inline-flex items-center gap-1">
                                        <Tag className="h-3 w-3" />
                                        {tag}
                                    </span>
                                </m.button>
                            ))}
                        </div>
                    )}
                </m.div>

                {loading ? (
                    <div className="h-64 flex items-center justify-center">
                        <Loader2 className="h-8 w-8 animate-spin text-brand" />
                    </div>
                ) : filteredDecks.length === 0 ? (
                    <m.div
                        initial={{ opacity: 0, scale: 0.95 }}
                        animate={{ opacity: 1, scale: 1 }}
                        className="border-2 border-dashed border-border rounded-sm py-20 sm:py-32 flex flex-col items-center justify-center text-center px-4 bg-white/50"
                    >
                        <div className="bg-gray-100 p-6 rounded-full mb-6">
                            <Layers className="h-10 w-10 text-foreground/20" />
                        </div>
                        <h3 className="text-xl font-bold mb-2">Nenhum deck encontrado</h3>
                        <p className="text-foreground/40 font-medium max-w-xs mb-8">
                            Tente outra busca ou publique o seu primeiro deck para ajudar a comunidade.
                        </p>
                        <Link href="/app" className="group text-brand font-bold hover:underline underline-offset-4 inline-flex items-center gap-2">
                            Criar deck agora
                            <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                        </Link>
                    </m.div>
                ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
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
                                <div className="flex items-start justify-between mb-6">
                                    <div className="bg-brand/10 p-2 rounded-sm">
                                        <Layers className="h-5 w-5 text-brand" />
                                    </div>
                                    <div className="flex flex-col items-end gap-2">
                                        {deck.is_verified && (
                                            <span className="inline-flex items-center gap-1 text-[9px] font-black uppercase tracking-widest text-brand bg-brand/10 px-2 py-1 rounded-sm">
                                                <BadgeCheck className="h-3 w-3" />
                                                Verificado
                                            </span>
                                        )}
                                        <div className="text-[10px] uppercase tracking-widest font-black text-foreground/30">
                                            {new Date(deck.published_at || deck.created_at).toLocaleDateString('pt-BR')}
                                        </div>
                                    </div>
                                </div>

                                {deck.category?.id && (
                                    <div className="text-[10px] uppercase tracking-widest font-black text-foreground/30 mb-2">
                                        {categoryLabels[deck.category.id] || deck.category.name}
                                    </div>
                                )}

                                <h3 className="text-xl font-bold mb-2 group-hover:text-brand transition-colors line-clamp-2">
                                    {deck.title}
                                </h3>

                                {deck.description && (
                                    <p className="text-sm text-foreground/60 font-medium mb-4 line-clamp-2">
                                        {deck.description}
                                    </p>
                                )}

                                <div className="flex flex-wrap items-center gap-3 text-xs font-bold text-foreground/40 mb-6">
                                    <div className="bg-gray-100 px-2 py-0.5 rounded-sm">
                                        {deck.cards?.[0]?.count || 0} CARDS
                                    </div>
                                    <div className="bg-emerald-50 text-emerald-700 px-2 py-0.5 rounded-sm">
                                        {formatPrice(deck.price)}
                                    </div>
                                    {(deck.rating_count || 0) > 0 && (
                                        <div className="flex items-center gap-1">
                                            <Star className="h-3.5 w-3.5" />
                                            {Number(deck.rating || 0).toFixed(1)} ({deck.rating_count})
                                        </div>
                                    )}
                                    {(deck.tags || []).length > 0 && (
                                        <div className="flex items-center gap-1">
                                            <Tag className="h-3.5 w-3.5" />
                                            {(deck.tags || []).slice(0, 2).join(', ')}
                                        </div>
                                    )}
                                </div>

                                <div className="flex flex-col sm:flex-row gap-2">
                                    <button
                                        onClick={() => handleClone(deck.id)}
                                        disabled={cloningId === deck.id}
                                        className="w-full sm:flex-1 bg-brand text-white py-2 rounded-sm text-xs font-bold hover:bg-brand/90 transition-all flex items-center justify-center gap-2 disabled:opacity-70 disabled:cursor-not-allowed"
                                    >
                                        <Copy className="h-3.5 w-3.5" />
                                        {cloningId === deck.id ? 'Clonando...' : 'Clonar'}
                                    </button>
                                    <Link
                                        href={`/marketplace/${deck.id}`}
                                        className="group/link w-full sm:flex-1 bg-white border border-border py-2 rounded-sm text-xs font-bold text-center hover:bg-gray-50 transition-all flex items-center justify-center gap-2"
                                    >
                                        Ver Deck
                                        <ArrowRight className="h-3.5 w-3.5 cta-arrow-shift" />
                                    </Link>
                                </div>
                            </m.div>
                        ))}
                    </div>
                )}

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
