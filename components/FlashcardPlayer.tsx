'use client';

import React, { useState, useEffect } from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';

interface Card {
    id: string;
    front: string;
    back: string;
}

interface FlashcardPlayerProps {
    cards: Card[];
}

export default function FlashcardPlayer({ cards }: FlashcardPlayerProps) {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [isFlipped, setIsFlipped] = useState(false);

    const currentCard = cards[currentIndex];
    const progress = ((currentIndex + 1) / cards.length) * 100;

    const handleNext = () => {
        if (currentIndex < cards.length - 1) {
            setIsFlipped(false);
            setTimeout(() => setCurrentIndex(prev => prev + 1), 150);
        }
    };

    const handlePrev = () => {
        if (currentIndex > 0) {
            setIsFlipped(false);
            setTimeout(() => setCurrentIndex(prev => prev - 1), 150);
        }
    };

    const handleFlip = () => {
        setIsFlipped(!isFlipped);
    };

    const handleKeyDown = (e: KeyboardEvent) => {
        if (e.key === 'Space' || e.key === ' ') {
            e.preventDefault();
            handleFlip();
        } else if (e.key === 'ArrowRight') {
            handleNext();
        } else if (e.key === 'ArrowLeft') {
            handlePrev();
        }
    };

    useEffect(() => {
        window.addEventListener('keydown', handleKeyDown);
        return () => window.removeEventListener('keydown', handleKeyDown);
    }, [currentIndex, isFlipped]); // eslint-disable-line

    if (!cards || cards.length === 0) return null;

    // Estado Final: Parabéns
    if (currentIndex === cards.length - 1 && isFlipped) {
        // Lógica opcional para fim do deck
    }

    return (
        <div className="w-full max-w-3xl mx-auto space-y-8">
            {/* Progress Bar */}
            <div className="space-y-2">
                <div className="flex justify-between text-xs font-bold text-foreground/40 uppercase tracking-wider">
                    <span>Progresso</span>
                    <span>{currentIndex + 1} / {cards.length}</span>
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
                className="perspective-1000 h-[400px] cursor-pointer group"
                onClick={handleFlip}
            >
                <div
                    className={`relative w-full h-full text-center transition-transform duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}
                >
                    {/* Front */}
                    <div className="absolute inset-0 backface-hidden bg-white border border-border shadow-lg rounded-sm flex flex-col items-center justify-center p-8 md:p-12 hover:border-brand/40 transition-colors">
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-brand/40">
                            Pergunta
                        </span>
                        <p className="text-2xl md:text-3xl font-bold text-foreground leading-relaxed">
                            {currentCard.front}
                        </p>
                        <span className="absolute bottom-6 text-xs text-foreground/20 font-medium">
                            Clique ou Espaço para virar
                        </span>
                    </div>

                    {/* Back */}
                    <div className="absolute inset-0 backface-hidden rotate-y-180 bg-gray-900 border border-gray-900 shadow-xl rounded-sm flex flex-col items-center justify-center p-8 md:p-12">
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-white/40">
                            Resposta
                        </span>
                        <p className="text-xl md:text-2xl font-medium text-white leading-relaxed">
                            {currentCard.back}
                        </p>
                    </div>
                </div>
            </div>

            {/* Controls */}
            <div className="flex items-center justify-center gap-4">
                <button
                    onClick={(e) => { e.stopPropagation(); handlePrev(); }}
                    disabled={currentIndex === 0}
                    className="p-4 rounded-full border border-border bg-white text-foreground hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
                >
                    <ChevronLeft className="h-6 w-6" />
                </button>

                <div className="text-xs font-bold text-foreground/30 uppercase tracking-widest px-4">
                    Navegação
                </div>

                <button
                    onClick={(e) => { e.stopPropagation(); handleNext(); }}
                    disabled={currentIndex === cards.length - 1}
                    className="p-4 rounded-full border border-border bg-white text-foreground hover:bg-gray-50 disabled:opacity-30 disabled:cursor-not-allowed transition-all"
                >
                    <ChevronRight className="h-6 w-6" />
                </button>
            </div>
        </div>
    );
}
