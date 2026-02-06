import React from 'react';
import {
    Trash2,
    GripVertical,
    X,
} from 'lucide-react';
import type { Flashcard, ImageDropTarget } from './types';

interface CardPreviewProps {
    card: Flashcard;
    index: number;
    dropTarget: ImageDropTarget | null;
    draggedImage: { cardId: string; section: 'question' | 'answer'; imageUrl: string } | null;
    onDeleteCard: (id: string) => void;
    onUpdateCard: (id: string, field: 'question' | 'answer', value: string) => void;
    onRemoveImage: (cardId: string, section: 'question' | 'answer') => void;
    onImageDragStart: (e: React.DragEvent, cardId: string, section: 'question' | 'answer', imageUrl: string) => void;
    onImageDragEnd: () => void;
    onImageDragOver: (e: React.DragEvent, cardId: string, section: 'question' | 'answer') => void;
    onImageDragLeave: () => void;
    onImageDrop: (e: React.DragEvent, targetCardId: string, targetSection: 'question' | 'answer') => void;
}

export function CardPreview({
    card,
    index,
    dropTarget,
    draggedImage,
    onDeleteCard,
    onUpdateCard,
    onRemoveImage,
    onImageDragStart,
    onImageDragEnd,
    onImageDragOver,
    onImageDragLeave,
    onImageDrop,
}: CardPreviewProps) {
    return (
        <div className="group bg-white border border-border rounded-sm hover:border-brand/40 transition-all p-5 shadow-sm relative overflow-hidden">
            <div className="absolute top-0 right-0 p-3 opacity-0 group-hover:opacity-100 transition-opacity flex gap-1">
                <button
                    onClick={() => onDeleteCard(card.id)}
                    className="p-1.5 text-foreground/30 hover:text-red-500 hover:bg-red-50 rounded-sm transition-colors"
                >
                    <Trash2 className="h-4 w-4" />
                </button>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {/* Secao Pergunta */}
                <div
                    className={`space-y-2 rounded-sm transition-all ${dropTarget?.cardId === card.id && dropTarget?.section === 'question' ? 'bg-brand/5 ring-2 ring-brand/30 ring-dashed p-2 -m-2' : ''}`}
                    onDragOver={(e) => onImageDragOver(e, card.id, 'question')}
                    onDragLeave={onImageDragLeave}
                    onDrop={(e) => onImageDrop(e, card.id, 'question')}
                >
                    <label className="text-[10px] font-black uppercase tracking-widest text-brand">Pergunta #{index + 1}</label>
                    {card.question_image_url ? (
                        <div className="relative group/img w-full">
                            <img
                                src={card.question_image_url}
                                alt={`Imagem da pergunta ${index + 1}`}
                                className="w-full h-40 object-cover rounded-sm border border-border cursor-grab active:cursor-grabbing"
                                draggable
                                onDragStart={(e) => onImageDragStart(e, card.id, 'question', card.question_image_url!)}
                                onDragEnd={onImageDragEnd}
                                onError={() => onRemoveImage(card.id, 'question')}
                            />
                            <div className="absolute top-2 right-2 flex gap-1 opacity-0 group-hover/img:opacity-100 transition-opacity">
                                <div className="bg-black/60 text-white p-1.5 rounded-sm cursor-grab">
                                    <GripVertical className="h-3.5 w-3.5" />
                                </div>
                                <button
                                    onClick={() => onRemoveImage(card.id, 'question')}
                                    className="bg-red-500/90 hover:bg-red-600 text-white p-1.5 rounded-sm transition-colors"
                                    title="Remover imagem"
                                >
                                    <X className="h-3.5 w-3.5" />
                                </button>
                            </div>
                            <p className="text-[9px] text-foreground/40 mt-1 text-center">Arraste para mover</p>
                        </div>
                    ) : (
                        <div
                            className={`w-full h-20 border-2 border-dashed rounded-sm flex items-center justify-center text-xs text-foreground/30 transition-all ${draggedImage ? 'border-brand/40 bg-brand/5' : 'border-border'}`}
                        >
                            {draggedImage ? 'Solte aqui' : 'Arraste uma imagem aqui'}
                        </div>
                    )}
                    <textarea
                        value={card.question}
                        onChange={(e) => onUpdateCard(card.id, 'question', e.target.value)}
                        className="w-full bg-transparent border border-transparent hover:border-border/50 focus:border-border focus:bg-white p-2 -ml-2 rounded-sm focus:ring-0 text-sm font-bold resize-none leading-relaxed text-foreground transition-all"
                        rows={3}
                    />
                </div>

                {/* Secao Resposta */}
                <div
                    className={`space-y-2 border-t md:border-t-0 md:border-l border-border pt-4 md:pt-0 md:pl-6 text-foreground rounded-sm transition-all ${dropTarget?.cardId === card.id && dropTarget?.section === 'answer' ? 'bg-brand/5 ring-2 ring-brand/30 ring-dashed p-2 -m-2' : ''}`}
                    onDragOver={(e) => onImageDragOver(e, card.id, 'answer')}
                    onDragLeave={onImageDragLeave}
                    onDrop={(e) => onImageDrop(e, card.id, 'answer')}
                >
                    <label className="text-[10px] font-black uppercase tracking-widest text-foreground/30">Resposta</label>
                    {card.answer_image_url ? (
                        <div className="relative group/img w-full">
                            <img
                                src={card.answer_image_url}
                                alt={`Imagem da resposta ${index + 1}`}
                                className="w-full h-40 object-cover rounded-sm border border-border cursor-grab active:cursor-grabbing"
                                draggable
                                onDragStart={(e) => onImageDragStart(e, card.id, 'answer', card.answer_image_url!)}
                                onDragEnd={onImageDragEnd}
                                onError={() => onRemoveImage(card.id, 'answer')}
                            />
                            <div className="absolute top-2 right-2 flex gap-1 opacity-0 group-hover/img:opacity-100 transition-opacity">
                                <div className="bg-black/60 text-white p-1.5 rounded-sm cursor-grab">
                                    <GripVertical className="h-3.5 w-3.5" />
                                </div>
                                <button
                                    onClick={() => onRemoveImage(card.id, 'answer')}
                                    className="bg-red-500/90 hover:bg-red-600 text-white p-1.5 rounded-sm transition-colors"
                                    title="Remover imagem"
                                >
                                    <X className="h-3.5 w-3.5" />
                                </button>
                            </div>
                            <p className="text-[9px] text-foreground/40 mt-1 text-center">Arraste para mover</p>
                        </div>
                    ) : (
                        <div
                            className={`w-full h-20 border-2 border-dashed rounded-sm flex items-center justify-center text-xs text-foreground/30 transition-all ${draggedImage ? 'border-brand/40 bg-brand/5' : 'border-border'}`}
                        >
                            {draggedImage ? 'Solte aqui' : 'Arraste uma imagem aqui'}
                        </div>
                    )}
                    <textarea
                        value={card.answer}
                        onChange={(e) => onUpdateCard(card.id, 'answer', e.target.value)}
                        className="w-full bg-transparent border border-transparent hover:border-border/50 focus:border-border focus:bg-white p-2 -ml-2 rounded-sm focus:ring-0 text-sm font-medium text-foreground/80 resize-none leading-relaxed text-foreground transition-all"
                        rows={3}
                    />
                </div>
            </div>
        </div>
    );
}
