'use client';

import React, { useEffect, useMemo, useState } from 'react';
import { CheckCircle } from 'lucide-react';
import { supabase } from '@/lib/supabase';

interface Card {
    id: string;
    front: string;
    back: string;
    next_review?: string;
}

interface FlashcardPlayerProps {
    cards: Card[];
}

interface ReviewOption {
    label: string;
    quality: number;
    className: string;
}

export default function FlashcardPlayer({ cards }: FlashcardPlayerProps) {
    const [queue, setQueue] = useState<Card[]>([]);
    const [currentIndex, setCurrentIndex] = useState(0);
    const [isFlipped, setIsFlipped] = useState(false);

    useEffect(() => {
        setQueue(cards || []);
        setCurrentIndex(0);
        setIsFlipped(false);
    }, [cards]);

    const currentCard = queue[currentIndex];
    const progress = queue.length > 0 ? ((currentIndex + 1) / queue.length) * 100 : 0;

    const reviewOptions: ReviewOption[] = useMemo(() => [
        {
            label: 'Errei (Again)',
            quality: 0,
            className: 'bg-red-50 text-red-600 border-red-200 hover:bg-red-100'
        },
        {
            label: 'Dif?cil (Hard)',
            quality: 3,
            className: 'bg-amber-50 text-amber-700 border-amber-200 hover:bg-amber-100'
        },
        {
            label: 'Bom (Good)',
            quality: 4,
            className: 'bg-blue-50 text-blue-700 border-blue-200 hover:bg-blue-100'
        },
        {
            label: 'F?cil (Easy)',
            quality: 5,
            className: 'bg-green-50 text-green-700 border-green-200 hover:bg-green-100'
        }
    ], []);

    const handleFlip = () => {
        setIsFlipped((prev) => !prev);
    };

    const handleReview = async (quality: number) => {
        if (!currentCard) return;

        const cardId = currentCard.id;
        const nextQueue = queue.filter((_, index) => index !== currentIndex);
        let nextIndex = currentIndex;
        if (nextIndex >= nextQueue.length) {
            nextIndex = Math.max(0, nextQueue.length - 1);
        }

        setQueue(nextQueue);
        setCurrentIndex(nextIndex);
        setIsFlipped(false);

        const { error } = await supabase.rpc('update_card_progress', {
            p_card_id: cardId,
            p_quality: quality
        });

        if (error) {
            console.error('Erro ao atualizar card:', error);
        }
    };

    const handleKeyDown = (e: KeyboardEvent) => {
        if (e.key === ' ' || e.key === 'Spacebar') {
            e.preventDefault();
            handleFlip();
        }
    };

    useEffect(() => {
        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [currentIndex, isFlipped]); // eslint-disable-line

    if (!queue || queue.length === 0) {
        return (
            <div className="border-2 border-dashed border-border rounded-sm py-16 sm:py-20 flex flex-col items-center justify-center text-center px-4 bg-white/50">
                <div className="bg-green-50 p-4 rounded-full mb-4">
                    <CheckCircle className="h-7 w-7 text-green-500" />
                </div>
                <h3 className="text-lg font-bold mb-2">Tudo em dia!</h3>
                <p className="text-foreground/50 font-medium max-w-xs">
                    Voc? n?o tem revis?es pendentes hoje.
                </p>
            </div>
        );
    }

    return (
        <div className="w-full max-w-3xl mx-auto space-y-8">
            {/* Progress Bar */}
            <div className="space-y-2">
                <div className="flex justify-between text-xs font-bold text-foreground/40 uppercase tracking-wider">
                    <span>Progresso</span>
                    <span>{currentIndex + 1} / {queue.length}</span>
                </div>
                <div className="h-2 bg-gray-100 rounded-full overflow-hidden">
                    <div
                        className="h-full bg-brand transition-all duration-300 ease-out"
                        style={{ width: `${progress}%` }}
                    />
                </div>
            </div>

            {/* Card Area */}
            <div
                className="perspective-1000 h-[320px] sm:h-[400px] cursor-pointer group"
                onClick={handleFlip}
            >
                <div
                    className={`relative w-full h-full text-center transition-transform duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}
                >
                    {/* Front */}
                    <div className="absolute inset-0 backface-hidden bg-white border border-border shadow-lg rounded-sm flex flex-col items-center justify-center p-6 sm:p-8 md:p-12 hover:border-brand/40 transition-colors">
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-brand/40">
                            Pergunta
                        </span>
                        <p className="text-2xl md:text-3xl font-bold text-foreground leading-relaxed">
                            {currentCard.front}
                        </p>
                        <span className="absolute bottom-6 text-xs text-foreground/20 font-medium">
                            Clique ou Espa?o para virar
                        </span>
                    </div>

                    {/* Back */}
                    <div className="absolute inset-0 backface-hidden rotate-y-180 bg-gray-900 border border-gray-900 shadow-xl rounded-sm flex flex-col items-center justify-center p-6 sm:p-8 md:p-12">
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-white/40">
                            Resposta
                        </span>
                        <p className="text-xl md:text-2xl font-medium text-white leading-relaxed">
                            {currentCard.back}
                        </p>
                        <span className="absolute bottom-6 text-xs text-white/30 font-medium">
                            Avalie para continuar
                        </span>
                    </div>
                </div>
            </div>

            {/* Review Controls */}
            <div className="space-y-3">
                {isFlipped ? (
                    <div className="grid grid-cols-2 gap-2 sm:flex sm:justify-center sm:gap-3">
                        {reviewOptions.map((option) => (
                            <button
                                key={option.label}
                                type="button"
                                onClick={() => handleReview(option.quality)}
                                className={`px-3 py-2 rounded-sm border text-[10px] sm:text-xs font-black uppercase tracking-widest transition-colors ${option.className}`}
                            >
                                {option.label}
                            </button>
                        ))}
                    </div>
                ) : (
                    <div className="text-center text-xs font-bold text-foreground/30 uppercase tracking-widest">
                        Vire o card para avaliar
                    </div>
                )}
            </div>
        </div>
    );
}
