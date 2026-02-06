'use client';

import React, { useCallback, useEffect, useMemo, useState } from 'react';
import Image from 'next/image';
import { CheckCircle, Loader2, BarChart3, Clock, ArrowRight } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { previewIntervals, formatInterval, type SRSCardData } from '@/lib/srs';

interface Card {
    id: string;
    front: string;
    back: string;
    next_review?: string;
    ease_factor?: number;
    interval?: number;
    repetitions?: number;
    image_url?: string | null;
}

interface ReviewResult {
    cardId: string;
    quality: number;
    intervalDays: number;
    nextReview: Date;
}

interface FlashcardPlayerProps {
    cards: Card[];
    disableProgress?: boolean;
    onReviewCard?: (cardId: string, quality: number) => Promise<{ intervalDays: number; nextReview: Date }>;
}

interface ReviewOption {
    label: string;
    quality: number;
    className: string;
    intervalLabel?: string;
}

export default function FlashcardPlayer({ cards, disableProgress = false, onReviewCard }: FlashcardPlayerProps) {
    const [queue, setQueue] = useState<Card[]>([]);
    const [currentIndex, setCurrentIndex] = useState(0);
    const [isFlipped, setIsFlipped] = useState(false);
    const [reviewLoading, setReviewLoading] = useState(false);
    const [sessionResults, setSessionResults] = useState<ReviewResult[]>([]);
    const [sessionComplete, setSessionComplete] = useState(false);
    const [totalCardsInSession, setTotalCardsInSession] = useState(0);

    useEffect(() => {
        const incoming = cards || [];
        setQueue(incoming);
        setCurrentIndex(0);
        setIsFlipped(false);
        setSessionResults([]);
        setSessionComplete(false);
        setTotalCardsInSession(incoming.length);
    }, [cards]);

    const currentCard = queue[currentIndex];

    // Preview intervals for the current card so button labels show upcoming schedule
    const intervalPreviews = useMemo(() => {
        if (!currentCard) return {};
        const srsData: Partial<SRSCardData> = {
            easeFactor: currentCard.ease_factor,
            interval: currentCard.interval,
            repetitions: currentCard.repetitions,
        };
        return previewIntervals(srsData);
    }, [currentCard]);

    const reviewOptions: ReviewOption[] = useMemo(() => [
        {
            label: 'Errei',
            quality: 0,
            className: 'bg-red-50 text-red-700 border-red-200 hover:bg-red-100',
            intervalLabel: intervalPreviews[0] != null ? formatInterval(intervalPreviews[0]) : undefined,
        },
        {
            label: 'Difícil',
            quality: 3,
            className: 'bg-amber-50 text-amber-800 border-amber-200 hover:bg-amber-100',
            intervalLabel: intervalPreviews[3] != null ? formatInterval(intervalPreviews[3]) : undefined,
        },
        {
            label: 'Bom',
            quality: 4,
            className: 'bg-blue-50 text-blue-700 border-blue-200 hover:bg-blue-100',
            intervalLabel: intervalPreviews[4] != null ? formatInterval(intervalPreviews[4]) : undefined,
        },
        {
            label: 'Fácil',
            quality: 5,
            className: 'bg-green-50 text-green-700 border-green-200 hover:bg-green-100',
            intervalLabel: intervalPreviews[5] != null ? formatInterval(intervalPreviews[5]) : undefined,
        }
    ], [intervalPreviews]);

    // Compute progress based on how many cards we have reviewed out of the total session
    const reviewedCount = sessionResults.length;
    const progress = totalCardsInSession > 0
        ? (reviewedCount / totalCardsInSession) * 100
        : 0;

    const handleFlip = () => {
        if (reviewLoading) return;
        setIsFlipped((prev) => !prev);
    };

    const handleReview = async (quality: number) => {
        if (!currentCard || reviewLoading) return;
        setReviewLoading(true);

        const cardId = currentCard.id;

        // Simple vibration for feedback if available
        if (typeof navigator !== 'undefined' && navigator.vibrate) {
            navigator.vibrate(50);
        }

        let reviewResult: ReviewResult | null = null;

        if (!disableProgress && onReviewCard) {
            // Use the parent-provided callback (which calls SRS + Supabase)
            try {
                const { intervalDays, nextReview } = await onReviewCard(cardId, quality);
                reviewResult = { cardId, quality, intervalDays, nextReview };
            } catch (err) {
                console.error('Erro ao atualizar card via onReviewCard:', err);
            }
        } else if (!disableProgress) {
            // Fallback: direct RPC call (legacy behavior)
            const { data, error } = await supabase.rpc('update_card_progress', {
                p_card_id: cardId,
                p_quality: quality
            });

            if (error) {
                console.error('Erro ao atualizar card:', JSON.stringify(error, null, 2));
            } else {
                window.dispatchEvent(new Event('study-activity-updated'));
                const row = Array.isArray(data) ? data[0] : data;
                if (row) {
                    reviewResult = {
                        cardId,
                        quality,
                        intervalDays: row.interval ?? 1,
                        nextReview: new Date(row.next_review),
                    };
                }
            }
        }

        // Record the result for session summary
        if (reviewResult) {
            setSessionResults((prev) => [...prev, reviewResult!]);
        } else {
            // Even if there was an error, record a minimal result so the session can complete
            setSessionResults((prev) => [...prev, { cardId, quality, intervalDays: 0, nextReview: new Date() }]);
        }

        // Advance to next card
        const nextQueue = queue.filter((_, index) => index !== currentIndex);
        let nextIndex = currentIndex;
        if (nextIndex >= nextQueue.length) {
            nextIndex = Math.max(0, nextQueue.length - 1);
        }

        if (nextQueue.length === 0) {
            // Session complete
            setSessionComplete(true);
        }

        setQueue(nextQueue);
        setCurrentIndex(nextIndex);
        setIsFlipped(false);
        setReviewLoading(false);
    };

    const handleRestartSession = useCallback(() => {
        setQueue(cards || []);
        setCurrentIndex(0);
        setIsFlipped(false);
        setSessionResults([]);
        setSessionComplete(false);
        setTotalCardsInSession((cards || []).length);
    }, [cards]);

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

    // Session complete: show summary
    if (sessionComplete && sessionResults.length > 0) {
        const qualityLabels: Record<number, string> = { 0: 'Errei', 3: 'Difícil', 4: 'Bom', 5: 'Fácil' };
        const qualityCounts: Record<number, number> = {};
        let earliestNext: Date | null = null;

        for (const r of sessionResults) {
            qualityCounts[r.quality] = (qualityCounts[r.quality] || 0) + 1;
            if (!earliestNext || r.nextReview < earliestNext) {
                earliestNext = r.nextReview;
            }
        }

        return (
            <div className="w-full max-w-3xl mx-auto space-y-6">
                <div className="border-2 border-dashed border-border rounded-sm py-12 sm:py-16 flex flex-col items-center justify-center text-center px-6 bg-white/50">
                    <div className="bg-green-50 p-4 rounded-full mb-5">
                        <CheckCircle className="h-8 w-8 text-green-500" />
                    </div>
                    <h3 className="text-xl font-black mb-2">Sessão concluída!</h3>
                    <p className="text-foreground/50 font-medium max-w-sm mb-8">
                        Você revisou {sessionResults.length} {sessionResults.length === 1 ? 'card' : 'cards'} nesta sessão.
                    </p>

                    {/* Quality breakdown */}
                    <div className="w-full max-w-md space-y-3 mb-8">
                        <div className="flex items-center gap-2 text-[10px] font-black uppercase tracking-widest text-foreground/30 mb-3">
                            <BarChart3 className="h-3.5 w-3.5" />
                            Resumo das respostas
                        </div>
                        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
                            {[0, 3, 4, 5].map((q) => {
                                const count = qualityCounts[q] || 0;
                                if (count === 0) return null;
                                const colorMap: Record<number, string> = {
                                    0: 'bg-red-50 text-red-700 border-red-200',
                                    3: 'bg-amber-50 text-amber-800 border-amber-200',
                                    4: 'bg-blue-50 text-blue-700 border-blue-200',
                                    5: 'bg-green-50 text-green-700 border-green-200',
                                };
                                return (
                                    <div key={q} className={`border rounded-sm px-3 py-3 text-center ${colorMap[q]}`}>
                                        <div className="text-2xl font-black">{count}</div>
                                        <div className="text-[10px] font-bold uppercase tracking-wider mt-1">{qualityLabels[q]}</div>
                                    </div>
                                );
                            })}
                        </div>
                    </div>

                    {/* Next review info */}
                    {earliestNext && (
                        <div className="flex items-center gap-2 text-sm font-bold text-foreground/40 mb-6">
                            <Clock className="h-4 w-4" />
                            <span>
                                Próxima revisão: {earliestNext.toLocaleDateString('pt-BR', { day: 'numeric', month: 'short' })}
                            </span>
                        </div>
                    )}

                    <button
                        onClick={handleRestartSession}
                        className="inline-flex items-center gap-2 bg-brand text-white px-6 py-3 rounded-sm font-bold text-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                    >
                        Estudar novamente
                        <ArrowRight className="h-4 w-4" />
                    </button>
                </div>
            </div>
        );
    }

    // No cards at all (nothing due)
    if (!queue || queue.length === 0) {
        return (
            <div className="border-2 border-dashed border-border rounded-sm py-16 sm:py-20 flex flex-col items-center justify-center text-center px-4 bg-white/50">
                <div className="bg-green-50 p-4 rounded-full mb-4">
                    <CheckCircle className="h-7 w-7 text-green-500" />
                </div>
                <h3 className="text-lg font-bold mb-2">Tudo em dia!</h3>
                <p className="text-foreground/50 font-medium max-w-xs">
                    {'Você não tem revisões pendentes hoje.'}
                </p>
            </div>
        );
    }

    return (
        <div className="w-full max-w-3xl mx-auto space-y-6 sm:space-y-8">
            {/* Progress Bar */}
            <div className="space-y-2">
                <div className="flex justify-between text-xs font-bold text-foreground/40 uppercase tracking-wider">
                    <span>Progresso</span>
                    <span>{reviewedCount} / {totalCardsInSession} ({queue.length} restantes)</span>
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
                className="perspective-1000 h-[380px] sm:h-[450px] cursor-pointer group touch-manipulation"
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
                        {currentCard.image_url && (
                            <div className="relative w-full h-40 mb-4">
                                <Image
                                    src={currentCard.image_url}
                                    alt="Conteúdo do card"
                                    fill
                                    className="object-contain rounded-sm"
                                    sizes="(max-width: 768px) 100vw, 500px"
                                    priority={currentIndex === 0}
                                />
                            </div>
                        )}
                        <p className="text-2xl md:text-3xl font-bold text-foreground leading-relaxed select-none">
                            {currentCard.front}
                        </p>
                        <span className="absolute bottom-6 text-xs text-foreground/20 font-medium">
                            {'Toque ou Espaço para virar'}
                        </span>
                    </div>

                    {/* Back */}
                    <div className="absolute inset-0 backface-hidden rotate-y-180 bg-gray-900 border border-gray-900 shadow-xl rounded-sm flex flex-col items-center justify-center p-6 sm:p-8 md:p-12">
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-white/40">
                            Resposta
                        </span>
                        {currentCard.image_url && (
                            <div className="relative w-full h-40 mb-4">
                                <Image
                                    src={currentCard.image_url}
                                    alt="Conteúdo do card"
                                    fill
                                    className="object-contain rounded-sm border border-white/10"
                                    sizes="(max-width: 768px) 100vw, 500px"
                                />
                            </div>
                        )}
                        <p className="text-xl md:text-2xl font-medium text-white leading-relaxed select-none">
                            {currentCard.back}
                        </p>
                        <span className="absolute bottom-6 text-xs text-white/30 font-medium">
                            Avalie para continuar
                        </span>
                    </div>
                </div>
            </div>

            {/* Review Controls */}
            <div className="w-full">
                {isFlipped ? (
                    <div className="grid grid-cols-2 gap-3 sm:flex sm:justify-center sm:gap-4">
                        {reviewOptions.map((option) => (
                            <button
                                key={option.label}
                                type="button"
                                disabled={reviewLoading}
                                onClick={(e) => {
                                    e.stopPropagation();
                                    handleReview(option.quality);
                                }}
                                className={`px-2 py-4 sm:px-6 sm:py-3 rounded-sm border text-xs sm:text-xs font-black uppercase tracking-widest transition-transform active:scale-95 touch-manipulation shadow-sm ${option.className} ${reviewLoading ? 'opacity-50 cursor-not-allowed' : ''}`}
                                style={{ minHeight: '52px' }}
                            >
                                {reviewLoading ? (
                                    <Loader2 className="h-4 w-4 animate-spin mx-auto" />
                                ) : (
                                    <span className="flex flex-col items-center gap-1">
                                        <span>{option.label}</span>
                                        {option.intervalLabel && (
                                            <span className="text-[9px] font-bold opacity-60 normal-case tracking-wide">
                                                {option.intervalLabel}
                                            </span>
                                        )}
                                    </span>
                                )}
                            </button>
                        ))}
                    </div>
                ) : (
                    <div className="text-center py-4 text-xs font-bold text-foreground/30 uppercase tracking-widest animate-pulse">
                        Vire o card para avaliar
                    </div>
                )}
            </div>
        </div>
    );
}
