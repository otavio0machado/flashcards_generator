'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { supabase } from '@/lib/supabase';
import { Library, Folder, Calendar, ArrowRight, Loader2, Plus, Download, Trash2 } from 'lucide-react';

export default function DecksPage() {
    const [decks, setDecks] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchDecks();
    }, []);

    const fetchDecks = async () => {
        const { data: { session } } = await supabase.auth.getSession();
        if (!session) return;

        const { data, error } = await supabase
            .from('decks')
            .select('*, cards(count)')
            .eq('user_id', session.user.id)
            .order('created_at', { ascending: false });

        if (error) console.error(error);
        else setDecks(data || []);
        setLoading(false);
    };

    const deleteDeck = async (id: string) => {
        if (!confirm('Tem certeza que deseja excluir este baralho?')) return;

        const { error } = await supabase.from('decks').delete().eq('id', id);
        if (error) alert('Erro ao excluir');
        else setDecks(decks.filter(d => d.id !== id));
    };

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 pt-32">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 mb-12">
                <div>
                    <h1 className="text-4xl font-bold tracking-tight mb-2">Minha Biblioteca</h1>
                    <p className="text-foreground/60 font-medium">Todos os seus baralhos gerados e salvos.</p>
                </div>
                <Link
                    href="/app"
                    className="bg-brand text-white px-6 py-3 rounded-sm font-bold flex items-center gap-2 hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 self-start"
                >
                    <Plus className="h-5 w-5" />
                    Novo Baralho
                </Link>
            </div>

            {loading ? (
                <div className="h-64 flex items-center justify-center">
                    <Loader2 className="h-8 w-8 animate-spin text-brand" />
                </div>
            ) : decks.length === 0 ? (
                <div className="border-2 border-dashed border-border rounded-sm py-32 flex flex-col items-center justify-center text-center px-4 bg-white/50">
                    <div className="bg-gray-100 p-6 rounded-full mb-6">
                        <Library className="h-10 w-10 text-foreground/20" />
                    </div>
                    <h3 className="text-xl font-bold mb-2">Sua biblioteca está vazia</h3>
                    <p className="text-foreground/40 font-medium max-w-xs mb-8">
                        Gere seu primeiro baralho usando nossa IA para começar a estudar.
                    </p>
                    <Link href="/app" className="text-brand font-bold hover:underline underline-offset-4">
                        Ir para o Gerador
                    </Link>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {decks.map((deck) => (
                        <div key={deck.id} className="group bg-white border border-border p-6 rounded-sm shadow-sm hover:border-brand/40 transition-all relative overflow-hidden">
                            <div className="flex items-start justify-between mb-8">
                                <div className="bg-brand/10 p-2 rounded-sm">
                                    <Folder className="h-5 w-5 text-brand" />
                                </div>
                                <button
                                    onClick={() => deleteDeck(deck.id)}
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

                            <div className="flex gap-2">
                                <button className="flex-1 bg-white border border-border py-2 rounded-sm text-xs font-bold hover:bg-gray-50 transition-all flex items-center justify-center gap-2">
                                    <Download className="h-3.5 w-3.5" />
                                    Exportar
                                </button>
                                <Link
                                    href={`/decks/${deck.id}`}
                                    className="flex-1 bg-gray-50 border border-border py-2 rounded-sm text-xs font-bold text-center hover:bg-white transition-all flex items-center justify-center gap-2"
                                >
                                    Ver Cards
                                    <ArrowRight className="h-3.5 w-3.5" />
                                </Link>
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
