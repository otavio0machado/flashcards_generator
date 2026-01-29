'use client';

import React, { useState, useRef } from 'react';
import Link from 'next/link';
import { motion, PanInfo, useReducedMotion } from 'framer-motion';
import { Layers, Star, Tag, Heart, Bookmark, ChevronRight, BadgeCheck } from 'lucide-react';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface DeckCardProps {
    deck: {
        id: string;
        title: string;
        description?: string | null;
        price?: number;
        rating?: number;
        rating_count?: number;
        is_verified?: boolean;
        tags?: string[];
        cards: { count: number }[];
        category?: { id: string; name: string } | null;
    };
    categoryLabel?: string;
    onClone: (id: string) => void;
    onLike?: (id: string) => void;
    isCloning?: boolean;
}

export default function DeckCard({
    deck,
    categoryLabel,
    onClone,
    onLike,
    isCloning = false,
}: DeckCardProps) {
    const [dragX, setDragX] = useState(0);
    const [isDragging, setIsDragging] = useState(false);
    const hasTriggeredAction = useRef(false);
    const [prefs] = useMobilePreferences();
    const reduceMotion = useReducedMotion();

    const cardCount = deck.cards?.[0]?.count || 0;
    const threshold = 60;

    const triggerHaptic = (type: 'selection' | 'impact') => {
        if (prefs.hapticFeedbackEnabled) {
            haptic(type);
        }
    };

    const handleDragStart = () => {
        setIsDragging(true);
        hasTriggeredAction.current = false;
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

        // Swipe right = clone/save
        if (offset > threshold || (offset > 30 && velocity > 200)) {
            triggerHaptic('impact');
            onClone(deck.id);
        }
        // Swipe left = like
        else if ((offset < -threshold || (offset < -30 && velocity > 200)) && onLike) {
            triggerHaptic('impact');
            onLike(deck.id);
        }
    };

    const formatPrice = (price?: number) => {
        const value = typeof price === 'number' ? price : Number(price || 0);
        if (!value) return 'Grátis';
        return value.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    };

    const leftOpacity = Math.min(Math.max(-dragX / threshold, 0), 1);
    const rightOpacity = Math.min(Math.max(dragX / threshold, 0), 1);

    const animationProps = reduceMotion
        ? { transition: { duration: 0 } }
        : { transition: { type: 'spring' as const, stiffness: 500, damping: 35 } };

    return (
        <div className="relative overflow-hidden rounded-[var(--corner-card)]">
            {/* Left action indicator (like) */}
            {onLike && (
                <div
                    className="absolute inset-y-0 right-0 w-20 bg-pink-500 flex items-center justify-center"
                    style={{ opacity: leftOpacity }}
                >
                    <Heart className="w-6 h-6 text-white" />
                </div>
            )}

            {/* Right action indicator (clone/save) */}
            <div
                className="absolute inset-y-0 left-0 w-20 bg-green-500 flex items-center justify-center"
                style={{ opacity: rightOpacity }}
            >
                <Bookmark className="w-6 h-6 text-white" />
            </div>

            <motion.div
                drag="x"
                dragConstraints={{ left: 0, right: 0 }}
                dragElastic={0.15}
                onDragStart={handleDragStart}
                onDrag={handleDrag}
                onDragEnd={handleDragEnd}
                animate={{ x: 0 }}
                {...animationProps}
                className="relative bg-[var(--secondary-system-background)] touch-pan-y"
            >
                <Link
                    href={`/marketplace/${deck.id}`}
                    className="block p-4"
                    onClick={(e) => {
                        if (isDragging) {
                            e.preventDefault();
                        }
                    }}
                >
                    <div className="flex gap-4">
                        {/* Icon */}
                        <div className="flex-shrink-0 w-14 h-14 bg-brand/10 rounded-[var(--corner-card)] flex items-center justify-center">
                            <Layers className="w-7 h-7 text-brand" />
                        </div>

                        {/* Content */}
                        <div className="flex-1 min-w-0">
                            {/* Header with verified badge */}
                            <div className="flex items-center gap-2 mb-1">
                                {deck.is_verified && (
                                    <BadgeCheck className="w-4 h-4 text-brand flex-shrink-0" />
                                )}
                                {categoryLabel && (
                                    <span className="text-[10px] font-bold text-zinc-400 uppercase tracking-wider truncate">
                                        {categoryLabel}
                                    </span>
                                )}
                            </div>

                            {/* Title */}
                            <h3 className="font-bold text-[var(--label)] line-clamp-1 mb-1">
                                {deck.title}
                            </h3>

                            {/* Description */}
                            {deck.description && (
                                <p className="text-xs text-zinc-400 line-clamp-1 mb-2">
                                    {deck.description}
                                </p>
                            )}

                            {/* Meta info */}
                            <div className="flex flex-wrap items-center gap-2">
                                <span className="text-xs font-medium text-zinc-500 bg-zinc-100 dark:bg-zinc-800 px-2 py-0.5 rounded">
                                    {cardCount} cards
                                </span>
                                <span className="text-xs font-medium text-green-600 bg-green-50 dark:bg-green-900/20 px-2 py-0.5 rounded">
                                    {formatPrice(deck.price)}
                                </span>
                                {(deck.rating_count || 0) > 0 && (
                                    <span className="flex items-center gap-1 text-xs text-zinc-400">
                                        <Star className="w-3 h-3 fill-yellow-400 text-yellow-400" />
                                        {Number(deck.rating || 0).toFixed(1)}
                                    </span>
                                )}
                                {(deck.tags || []).length > 0 && (
                                    <span className="flex items-center gap-1 text-xs text-zinc-400">
                                        <Tag className="w-3 h-3" />
                                        {deck.tags![0]}
                                    </span>
                                )}
                            </div>
                        </div>

                        {/* Arrow */}
                        <ChevronRight className="w-5 h-5 text-zinc-300 flex-shrink-0 self-center" />
                    </div>
                </Link>

                {/* Clone button */}
                {isCloning && (
                    <div className="absolute inset-0 bg-white/80 dark:bg-zinc-900/80 flex items-center justify-center">
                        <span className="text-sm font-bold text-brand">Clonando...</span>
                    </div>
                )}
            </motion.div>
        </div>
    );
}
