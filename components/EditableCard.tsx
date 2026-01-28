'use client';

import React, { useState, useRef } from 'react';
import { motion } from 'framer-motion';
import { Edit2, Trash2, Star, Copy, Share2 } from 'lucide-react';
import ContextMenu from '@/components/ContextMenu';
import { useSwipeGesture } from '@/hooks/useSwipeGesture';
import { haptics } from '@/lib/haptics';

interface CardProps {
    id: string;
    question: string;
    answer: string;
    question_image_url?: string | null;
    answer_image_url?: string | null;
    favorite?: boolean;
}

interface EditableCardProps {
    card: CardProps;
    idx: number;
    onDelete: (id: string) => void;
    onUpdate: (id: string, patched: Partial<CardProps>) => void;
    onToggleFavorite: (id: string) => void;
}

export default function EditableCard({ card, idx, onDelete, onUpdate, onToggleFavorite }: EditableCardProps) {
    const [editing, setEditing] = useState(false);
    const [draftQuestion, setDraftQuestion] = useState(card.question);
    const [draftAnswer, setDraftAnswer] = useState(card.answer);
    const [menuOpen, setMenuOpen] = useState(false);
    const [menuPos, setMenuPos] = useState({ x: 0, y: 0 });
    const longPressTimer = useRef<number | null>(null);

    const handlers = useSwipeGesture({
        onSwipeLeft: () => {
            try { haptics.impact(); } catch (e) {}
            onDelete(card.id);
        },
        onSwipeRight: () => {
            try { haptics.selection(); } catch (e) {}
            onToggleFavorite(card.id);
        },
        threshold: 60,
        velocityThreshold: 200,
    });

    const startLongPress = (e: React.PointerEvent) => {
        longPressTimer.current = window.setTimeout(() => {
            setMenuPos({ x: e.clientX, y: e.clientY });
            setMenuOpen(true);
        }, 700);
    };
    const clearLongPress = () => {
        if (longPressTimer.current) {
            clearTimeout(longPressTimer.current);
            longPressTimer.current = null;
        }
    };

    const handleSave = () => {
        onUpdate(card.id, { question: draftQuestion, answer: draftAnswer });
        setEditing(false);
        try { haptics.success(); } catch (e) {}
    };

    const handleCancel = () => {
        setDraftQuestion(card.question);
        setDraftAnswer(card.answer);
        setEditing(false);
    };

    const menuOptions = [
        { id: 'copy_q', label: 'Copiar pergunta', icon: Copy, onClick: () => navigator.clipboard?.writeText(card.question) },
        { id: 'copy_a', label: 'Copiar resposta', icon: Copy, onClick: () => navigator.clipboard?.writeText(card.answer) },
        { id: 'share', label: 'Compartilhar', icon: Share2, onClick: () => { try { (navigator as any).share?.({ title: 'Flashcard', text: `${card.question}\n\n${card.answer}` }); } catch {} } },
        { id: 'favorite', label: card.favorite ? 'Remover favorito' : 'Marcar favorito', icon: Star, onClick: () => onToggleFavorite(card.id) },
        { id: 'delete', label: 'Excluir', icon: Trash2, destructive: true, onClick: () => onDelete(card.id) },
    ];

    return (
        <motion.div
            className="relative bg-[var(--secondary-system-background)] p-6 rounded-[var(--corner-card)]"
            drag="x"
            dragConstraints={{ left: 0, right: 0 }}
            dragElastic={0.12}
            onDragStart={() => handlers.onDragStart()}
            onDrag={(e: any, info: any) => handlers.onDrag(e, info)}
            onDragEnd={(e: any, info: any) => handlers.onDragEnd(e, info)}
            onContextMenu={(e) => { e.preventDefault(); setMenuPos({ x: e.clientX, y: e.clientY }); setMenuOpen(true); }}
            onPointerDown={startLongPress}
            onPointerUp={() => { clearLongPress(); }}
            onPointerCancel={() => { clearLongPress(); }}
        >
            <div className="flex items-start justify-between mb-4">
                <div className="flex items-center gap-2">
                    <button
                        onClick={() => onToggleFavorite(card.id)}
                        aria-label={card.favorite ? 'Remover favorito' : 'Favoritar'}
                        className={`p-1 ${card.favorite ? 'text-yellow-500' : 'text-zinc-400'}`}
                    >
                        <Star className="w-4 h-4" />
                    </button>
                    <span className="text-[10px] font-black uppercase tracking-[0.2em] text-zinc-300">Card #{idx + 1}</span>
                </div>
                <div className="flex items-center gap-2">
                    <button onClick={() => setEditing(true)} className="p-1" aria-label="Editar">
                        <Edit2 className="w-4 h-4" />
                    </button>
                    <button onClick={() => onDelete(card.id)} className="p-1 text-zinc-200 hover:text-red-500 transition-colors" aria-label="Excluir">
                        <Trash2 className="w-4 h-4" />
                    </button>
                </div>
            </div>

            {editing ? (
                <div className="space-y-4">
                    <label className="text-[9px] font-black uppercase tracking-widest text-brand mb-2 block">Pergunta</label>
                    <textarea value={draftQuestion} onChange={(e) => setDraftQuestion(e.target.value)} className="w-full p-3 border border-border rounded-sm bg-white dark:bg-zinc-900" />
                    <label className="text-[9px] font-black uppercase tracking-widest text-zinc-400 mb-2 block">Resposta</label>
                    <textarea value={draftAnswer} onChange={(e) => setDraftAnswer(e.target.value)} className="w-full p-3 border border-border rounded-sm bg-white dark:bg-zinc-900" />

                    <div className="flex gap-2 mt-2">
                        <button onClick={handleSave} className="px-4 py-2 bg-brand text-white rounded-sm font-bold">Salvar</button>
                        <button onClick={handleCancel} className="px-4 py-2 rounded-sm border">Cancelar</button>
                    </div>
                </div>
            ) : (
                <div className="space-y-6">
                    <div>
                        <label className="text-[9px] font-black uppercase tracking-widest text-brand mb-2 block">Pergunta</label>
                        <p className="text-lg font-black text-swiss-header leading-tight italic">"{card.question}"</p>
                    </div>
                    <div className="pt-6 border-t border-zinc-50 dark:border-zinc-900">
                        <label className="text-[9px] font-black uppercase tracking-widest text-zinc-400 mb-2 block">Resposta</label>
                        <p className="text-base font-bold text-zinc-600 dark:text-zinc-400 leading-snug">{card.answer}</p>
                    </div>
                </div>
            )}

            <ContextMenu
                open={menuOpen}
                x={menuPos.x}
                y={menuPos.y}
                options={menuOptions}
                onClose={() => setMenuOpen(false)}
            />
        </motion.div>
    );
}
