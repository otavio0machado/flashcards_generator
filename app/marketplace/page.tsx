'use client';

import React, { useEffect, useMemo, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { deckService } from '@/services/deckService';
import { Search, Loader2, Layers, ArrowRight, Copy, Tag } from 'lucide-react';
import Toast, { ToastType } from '@/components/Toast';

interface PublicDeck {
    id: string;
    title: string;
    tags?: string[];
    created_at: string;
    published_at?: string | null;
    cards: { count: number }[];
}

export default function MarketplacePage() {
    const [decks, setDecks] = useState<PublicDeck[]>([]);
    const [loading, setLoading] = useState(true);
    const [search, setSearch] = useState('');
    const [activeTag, setActiveTag] = useState<string | null>(null);
    const [cloningId, setCloningId] = useState<string | null>(null);
    const [toast, setToast] = useState<{ message: string; type: ToastType } | null>(null);

    useEffect(() => {
        const fetchDecks = async () => {
            setLoading(true);
            const { data, error } = await supabase
                .from('decks')
                .select('id, title, tags, created_at, published_at, cards(count)')
                .eq('is_public', true)
                .order('published_at', { ascending: false, nullsFirst: false })
                .order('created_at', { ascending: false });

            if (error) {
                console.error(error);
                setToast({ message: 'Erro ao carregar marketplace', type: 'error' });
                setDecks([]);
            } else {
                setDecks(data || []);
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

    const filteredDecks = useMemo(() => {
        const query = search.trim().toLowerCase();
        return decks.filter((deck) => {
            const matchesQuery = !query
                || deck.title.toLowerCase().includes(query)
                || (deck.tags || []).some((tag) => tag.toLowerCase().includes(query));

            const matchesTag = !activeTag || (deck.tags || []).includes(activeTag);
            return matchesQuery && matchesTag;
        });
    }, [decks, search, activeTag]);

    const handleClone = async (deckId: string) => {
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) {
            setToast({ message: 'Faca login para clonar', type: 'info' });
            return;
        }

        setCloningId(deckId);
        try {
            await deckService.clonePublicDeck(session.user.id, deckId);
            setToast({ message: 'Deck clonado com sucesso', type: 'success' });
        } catch (error) {
            console.error(error);
            setToast({ message: 'Erro ao clonar deck', type: 'error' });
        } finally {
            setCloningId(null);
        }
    };

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
            <div className="flex flex-col lg:flex-row lg:items-end justify-between gap-6 mb-10">
                <div>
                    <h1 className="text-4xl md:text-5xl font-black tracking-tight mb-3">Marketplace de Decks</h1>
                    <p className="text-foreground/60 font-medium max-w-2xl">
                        Explore decks publicados pela comunidade e clone direto para a sua biblioteca.
                    </p>
                </div>
                <Link
                    href="/app"
                    className="bg-brand text-white px-6 py-3 rounded-sm font-bold flex items-center justify-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 w-full lg:w-auto"
                >
                    <Layers className="h-4 w-4" />
                    Criar meu deck
                </Link>
            </div>

            <div className="bg-white border border-border rounded-sm p-4 mb-10 shadow-sm">
                <div className="flex items-center gap-3">
                    <Search className="h-4 w-4 text-foreground/40" />
                    <input
                        value={search}
                        onChange={(event) => setSearch(event.target.value)}
                        placeholder="Buscar por titulo ou tag"
                        className="w-full bg-transparent text-sm font-medium text-foreground placeholder:text-foreground/40 focus:outline-none"
                    />
                </div>
                {tags.length > 0 && (
                    <div className="flex flex-wrap gap-2 mt-4">
                        <button
                            onClick={() => setActiveTag(null)}
                            className={`px-3 py-1 rounded-sm text-[10px] font-bold uppercase tracking-widest border ${!activeTag ? 'bg-brand text-white border-brand' : 'bg-gray-50 text-foreground/60 border-border hover:border-brand/40'}`}
                        >
                            Todos
                        </button>
                        {tags.map((tag) => (
                            <button
                                key={tag}
                                onClick={() => setActiveTag(tag)}
                                className={`px-3 py-1 rounded-sm text-[10px] font-bold uppercase tracking-widest border ${activeTag === tag ? 'bg-brand text-white border-brand' : 'bg-gray-50 text-foreground/60 border-border hover:border-brand/40'}`}
                            >
                                <span className="inline-flex items-center gap-1">
                                    <Tag className="h-3 w-3" />
                                    {tag}
                                </span>
                            </button>
                        ))}
                    </div>
                )}
            </div>

            {loading ? (
                <div className="h-64 flex items-center justify-center">
                    <Loader2 className="h-8 w-8 animate-spin text-brand" />
                </div>
            ) : filteredDecks.length === 0 ? (
                <div className="border-2 border-dashed border-border rounded-sm py-20 sm:py-32 flex flex-col items-center justify-center text-center px-4 bg-white/50">
                    <div className="bg-gray-100 p-6 rounded-full mb-6">
                        <Layers className="h-10 w-10 text-foreground/20" />
                    </div>
                    <h3 className="text-xl font-bold mb-2">Nenhum deck encontrado</h3>
                    <p className="text-foreground/40 font-medium max-w-xs mb-8">
                        Tente outra busca ou publique o seu primeiro deck para ajudar a comunidade.
                    </p>
                    <Link href="/app" className="text-brand font-bold hover:underline underline-offset-4">
                        Criar deck agora
                    </Link>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {filteredDecks.map((deck) => (
                        <div key={deck.id} className="group bg-white border border-border p-6 rounded-sm shadow-sm hover:border-brand/40 transition-all relative overflow-hidden">
                            <div className="flex items-start justify-between mb-6">
                                <div className="bg-brand/10 p-2 rounded-sm">
                                    <Layers className="h-5 w-5 text-brand" />
                                </div>
                                <div className="text-[10px] uppercase tracking-widest font-black text-foreground/30">
                                    {new Date(deck.published_at || deck.created_at).toLocaleDateString('pt-BR')}
                                </div>
                            </div>

                            <h3 className="text-xl font-bold mb-2 group-hover:text-brand transition-colors line-clamp-2">
                                {deck.title}
                            </h3>

                            <div className="flex items-center gap-4 text-xs font-bold text-foreground/40 mb-6">
                                <div className="bg-gray-100 px-2 py-0.5 rounded-sm">
                                    {deck.cards?.[0]?.count || 0} CARDS
                                </div>
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
                                    className="w-full sm:flex-1 bg-white border border-border py-2 rounded-sm text-xs font-bold text-center hover:bg-gray-50 transition-all flex items-center justify-center gap-2"
                                >
                                    Ver Deck
                                    <ArrowRight className="h-3.5 w-3.5" />
                                </Link>
                            </div>
                        </div>
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
        </div>
    );
}
