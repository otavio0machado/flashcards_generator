'use client';

import React from 'react';
import Image from 'next/image';
import { motion, useMotionValue, useTransform, PanInfo } from 'framer-motion';
import { useMobilePreferences } from '@/lib/mobile-preferences';
import { haptic } from '@/lib/haptics';
import { useSwipeGesture } from '@/hooks/useSwipeGesture';
import { ThumbsUp, ThumbsDown, RotateCcw } from 'lucide-react';

interface Card {
    id: string;
    front: string;
    back: string;
    image_url?: string | null;
}

interface SwipeableFlashcardProps {
    card: Card;
    isFlipped: boolean;
    onFlip: () => void;
    onReview: (quality: number) => void;
    showHint?: boolean;
}

export default function SwipeableFlashcard({
    card,
    isFlipped,
    onFlip,
    onReview,
    showHint = true,
}: SwipeableFlashcardProps) {
    const [prefs] = useMobilePreferences();

    const x = useMotionValue(0);
    const y = useMotionValue(0);

    // Visual transforms based on drag position
    const rotateZ = useTransform(x, [-200, 0, 200], [-8, 0, 8]);

    // Background color hints during drag
    const bgColorFront = useTransform(
        x,
        [-100, 0, 100],
        ['rgba(251, 191, 36, 0.1)', 'transparent', 'rgba(251, 191, 36, 0.1)']
    );

    // For vertical swipe review hints (only when flipped)
    const bgColorBack = useTransform(
        y,
        [-100, 0, 100],
        ['rgba(34, 197, 94, 0.15)', 'transparent', 'rgba(239, 68, 68, 0.15)']
    );

    // Indicator opacities
    const flipIndicatorOpacity = useTransform(x, [-80, -40, 0, 40, 80], [1, 0.5, 0, 0.5, 1]);
    const goodIndicatorOpacity = useTransform(y, [0, -60, -100], [0, 0.5, 1]);
    const againIndicatorOpacity = useTransform(y, [0, 60, 100], [0, 0.5, 1]);

    const swipeHandlers = useSwipeGesture({
        enabled: prefs.swipeGesturesEnabled,
        threshold: 60,
        velocityThreshold: 400,
        onSwipeLeft: prefs.swipeToFlipEnabled ? () => {
            haptic('tap');
            onFlip();
        } : undefined,
        onSwipeRight: prefs.swipeToFlipEnabled ? () => {
            haptic('tap');
            onFlip();
        } : undefined,
        onSwipeUp: (isFlipped && prefs.swipeToReviewEnabled) ? () => {
            haptic('success');
            onReview(4); // Good
        } : undefined,
        onSwipeDown: (isFlipped && prefs.swipeToReviewEnabled) ? () => {
            haptic('warning');
            onReview(0); // Again
        } : undefined,
    });

    const handleDragEnd = (event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        swipeHandlers.onDragEnd(event, info);
        // Reset position
        x.set(0);
        y.set(0);
    };

    const handleTap = () => {
        if (!swipeHandlers.state.isDragging) {
            haptic('tap');
            onFlip();
        }
    };

    const gesturesEnabled = prefs.swipeGesturesEnabled;
    const canDragX = prefs.swipeToFlipEnabled;
    const canDragY = isFlipped && prefs.swipeToReviewEnabled;

    return (
        <div className="perspective-1000 h-[380px] sm:h-[450px] relative">
            {/* Swipe Indicators - Only show when dragging */}
            {gesturesEnabled && (
                <>
                    {/* Flip indicator (horizontal swipe) */}
                    {!isFlipped && canDragX && (
                        <motion.div
                            style={{ opacity: flipIndicatorOpacity }}
                            className="absolute inset-x-0 top-1/2 -translate-y-1/2 flex justify-between px-4 pointer-events-none z-10"
                        >
                            <div className="bg-amber-500/20 backdrop-blur-sm rounded-full p-3">
                                <RotateCcw className="h-6 w-6 text-amber-600" />
                            </div>
                            <div className="bg-amber-500/20 backdrop-blur-sm rounded-full p-3">
                                <RotateCcw className="h-6 w-6 text-amber-600 scale-x-[-1]" />
                            </div>
                        </motion.div>
                    )}

                    {/* Good indicator (swipe up) */}
                    {isFlipped && canDragY && (
                        <motion.div
                            style={{ opacity: goodIndicatorOpacity }}
                            className="absolute top-4 inset-x-0 flex justify-center pointer-events-none z-10"
                        >
                            <div className="bg-green-500 text-white rounded-full px-6 py-3 flex items-center gap-2 shadow-lg">
                                <ThumbsUp className="h-5 w-5" />
                                <span className="font-bold text-sm uppercase tracking-wider">Bom</span>
                            </div>
                        </motion.div>
                    )}

                    {/* Again indicator (swipe down) */}
                    {isFlipped && canDragY && (
                        <motion.div
                            style={{ opacity: againIndicatorOpacity }}
                            className="absolute bottom-4 inset-x-0 flex justify-center pointer-events-none z-10"
                        >
                            <div className="bg-red-500 text-white rounded-full px-6 py-3 flex items-center gap-2 shadow-lg">
                                <ThumbsDown className="h-5 w-5" />
                                <span className="font-bold text-sm uppercase tracking-wider">Errei</span>
                            </div>
                        </motion.div>
                    )}
                </>
            )}

            {/* Card with drag */}
            <motion.div
                style={{
                    x: gesturesEnabled ? x : 0,
                    y: (gesturesEnabled && isFlipped) ? y : 0,
                    rotateZ: gesturesEnabled ? rotateZ : 0,
                }}
                drag={gesturesEnabled ? (canDragY ? true : (canDragX ? 'x' : false)) : false}
                dragConstraints={{ left: 0, right: 0, top: 0, bottom: 0 }}
                dragElastic={0.5}
                onDragStart={swipeHandlers.onDragStart}
                onDrag={swipeHandlers.onDrag}
                onDragEnd={handleDragEnd}
                onTap={handleTap}
                className="w-full h-full cursor-pointer touch-manipulation"
                whileTap={!gesturesEnabled ? { scale: 0.98 } : undefined}
            >
                <div
                    className={`relative w-full h-full text-center transition-transform duration-500 transform-style-3d ${isFlipped ? 'rotate-y-180' : ''}`}
                >
                    {/* Front */}
                    <motion.div
                        style={{ backgroundColor: gesturesEnabled ? bgColorFront : 'transparent' }}
                        className="absolute inset-0 backface-hidden bg-white border border-border shadow-lg rounded-xl flex flex-col items-center justify-center p-6 sm:p-8 md:p-12"
                    >
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-brand/40">
                            Pergunta
                        </span>
                        {card.image_url && (
                            <div className="relative w-full h-40 mb-4">
                                <Image
                                    src={card.image_url}
                                    alt="Conteúdo do card"
                                    fill
                                    className="object-contain rounded-lg"
                                    sizes="(max-width: 768px) 100vw, 500px"
                                />
                            </div>
                        )}
                        <p className="text-2xl md:text-3xl font-bold text-foreground leading-relaxed select-none">
                            {card.front}
                        </p>
                        {showHint && (
                            <span className="absolute bottom-6 text-xs text-foreground/20 font-medium">
                                {gesturesEnabled && prefs.swipeToFlipEnabled
                                    ? 'Deslize para os lados ou toque para virar'
                                    : 'Toque ou Espaço para virar'}
                            </span>
                        )}
                    </motion.div>

                    {/* Back */}
                    <motion.div
                        style={{ backgroundColor: gesturesEnabled ? bgColorBack : 'transparent' }}
                        className="absolute inset-0 backface-hidden rotate-y-180 bg-zinc-900 border border-zinc-800 shadow-xl rounded-xl flex flex-col items-center justify-center p-6 sm:p-8 md:p-12"
                    >
                        <span className="absolute top-6 left-6 text-[10px] font-black uppercase tracking-widest text-white/40">
                            Resposta
                        </span>
                        {card.image_url && (
                            <div className="relative w-full h-40 mb-4">
                                <Image
                                    src={card.image_url}
                                    alt="Conteúdo do card"
                                    fill
                                    className="object-contain rounded-lg border border-white/10"
                                    sizes="(max-width: 768px) 100vw, 500px"
                                />
                            </div>
                        )}
                        <p className="text-xl md:text-2xl font-medium text-white leading-relaxed select-none">
                            {card.back}
                        </p>
                        {showHint && (
                            <span className="absolute bottom-6 text-xs text-white/30 font-medium">
                                {gesturesEnabled && prefs.swipeToReviewEnabled
                                    ? 'Deslize ↑ Bom · ↓ Errei'
                                    : 'Avalie para continuar'}
                            </span>
                        )}
                    </motion.div>
                </div>
            </motion.div>
        </div>
    );
}
