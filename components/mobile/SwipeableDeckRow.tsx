'use client';

import React, { useState, useRef } from 'react';
import Link from 'next/link';
import { motion, PanInfo, useReducedMotion } from 'framer-motion';
import { Trash2, Copy, BookOpen, ChevronRight } from 'lucide-react';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface Deck {
    id: string;
    title: string;
    created_at: string;
    cards: { count: number }[];
}

interface SwipeableDeckRowProps {
    deck: Deck;
    onDelete: (id: string) => void;
    onDuplicate?: (id: string) => void;
    onLongPress?: (deck: Deck) => void;
}

export default function SwipeableDeckRow({
    deck,
    onDelete,
    onDuplicate,
    onLongPress,
}: SwipeableDeckRowProps) {
    const [dragX, setDragX] = useState(0);
    const [isDragging, setIsDragging] = useState(false);
    const longPressTimer = useRef<number | null>(null);
    const hasTriggeredAction = useRef(false);
    const [prefs] = useMobilePreferences();
    const reduceMotion = useReducedMotion();

    const cardCount = deck.cards[0]?.count || 0;
    const threshold = 60;

    const triggerHaptic = (type: 'selection' | 'impact') => {
        if (prefs.hapticFeedbackEnabled) {
            haptic(type);
        }
    };

    const handleDragStart = () => {
        setIsDragging(true);
        hasTriggeredAction.current = false;
        clearLongPress();
    };

    const handleDrag = (_: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        setDragX(info.offset.x);

        if (!hasTriggeredAction.current) {
            if (Math.abs(info.offset.x) > threshold) {
                hasTriggeredAction.current = true;
                triggerHaptic('selection');
            }
        }
    };

    const handleDragEnd = (_: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        setIsDragging(false);
        setDragX(0);

        const velocity = Math.abs(info.velocity.x);
        const offset = info.offset.x;

        // Swipe left = delete
        if (offset < -threshold || (offset < -30 && velocity > 200)) {
            triggerHaptic('impact');
            onDelete(deck.id);
        }
        // Swipe right = duplicate
        else if ((offset > threshold || (offset > 30 && velocity > 200)) && onDuplicate) {
            triggerHaptic('impact');
            onDuplicate(deck.id);
        }
    };

    const startLongPress = () => {
        if (onLongPress) {
            longPressTimer.current = window.setTimeout(() => {
                triggerHaptic('selection');
                onLongPress(deck);
            }, 500);
        }
    };

    const clearLongPress = () => {
        if (longPressTimer.current) {
            clearTimeout(longPressTimer.current);
            longPressTimer.current = null;
        }
    };

    const leftOpacity = Math.min(Math.max(-dragX / threshold, 0), 1);
    const rightOpacity = Math.min(Math.max(dragX / threshold, 0), 1);

    const animationProps = reduceMotion
        ? { transition: { duration: 0 } }
        : { transition: { type: 'spring' as const, stiffness: 500, damping: 35 } };

    return (
        <div className="relative overflow-hidden rounded-[var(--corner-card)]">
            {/* Left action indicator (delete) - revealed on swipe left */}
            <div
                className="absolute inset-y-0 right-0 w-20 bg-red-500 flex items-center justify-center"
                style={{ opacity: leftOpacity }}
            >
                <Trash2 className="w-6 h-6 text-white" />
            </div>

            {/* Right action indicator (duplicate) - revealed on swipe right */}
            {onDuplicate && (
                <div
                    className="absolute inset-y-0 left-0 w-20 bg-blue-500 flex items-center justify-center"
                    style={{ opacity: rightOpacity }}
                >
                    <Copy className="w-6 h-6 text-white" />
                </div>
            )}

            <motion.div
                drag="x"
                dragConstraints={{ left: 0, right: 0 }}
                dragElastic={0.15}
                onDragStart={handleDragStart}
                onDrag={handleDrag}
                onDragEnd={handleDragEnd}
                onPointerDown={startLongPress}
                onPointerUp={clearLongPress}
                onPointerCancel={clearLongPress}
                animate={{ x: 0 }}
                {...animationProps}
                className="relative bg-[var(--secondary-system-background)] touch-pan-y"
            >
                <Link
                    href={`/decks/${deck.id}`}
                    className="flex items-center gap-4 p-4"
                    onClick={(e) => {
                        if (isDragging) {
                            e.preventDefault();
                        }
                    }}
                >
                    {/* Icon */}
                    <div className="flex-shrink-0 w-12 h-12 bg-brand/10 rounded-[var(--corner-card)] flex items-center justify-center">
                        <BookOpen className="w-6 h-6 text-brand" />
                    </div>

                    {/* Content */}
                    <div className="flex-1 min-w-0">
                        <h3 className="font-bold text-[var(--label)] truncate">
                            {deck.title}
                        </h3>
                        <div className="flex items-center gap-2 mt-1">
                            <span className="text-xs text-zinc-400">
                                {cardCount} {cardCount === 1 ? 'card' : 'cards'}
                            </span>
                            <span className="text-zinc-300">•</span>
                            <span className="text-xs text-zinc-400">
                                {new Date(deck.created_at).toLocaleDateString('pt-BR', {
                                    day: '2-digit',
                                    month: 'short',
                                })}
                            </span>
                        </div>
                    </div>

                    {/* Arrow */}
                    <ChevronRight className="w-5 h-5 text-zinc-300 flex-shrink-0" />
                </Link>
            </motion.div>
        </div>
    );
}
