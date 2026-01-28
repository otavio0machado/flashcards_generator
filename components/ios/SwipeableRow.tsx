'use client';

import React, { useState, useRef } from 'react';
import { motion, PanInfo, useReducedMotion } from 'framer-motion';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface SwipeAction {
    id: string;
    icon: React.ComponentType<{ className?: string }>;
    label: string;
    color: 'red' | 'blue' | 'green' | 'yellow' | 'zinc';
    onAction: () => void;
}

interface SwipeableRowProps {
    children: React.ReactNode;
    leftActions?: SwipeAction[];
    rightActions?: SwipeAction[];
    onPress?: () => void;
    onLongPress?: (e: React.PointerEvent) => void;
    className?: string;
    threshold?: number;
}

const colorClasses: Record<SwipeAction['color'], string> = {
    red: 'bg-red-500',
    blue: 'bg-blue-500',
    green: 'bg-green-500',
    yellow: 'bg-yellow-500',
    zinc: 'bg-zinc-500',
};

export default function SwipeableRow({
    children,
    leftActions = [],
    rightActions = [],
    onPress,
    onLongPress,
    className = '',
    threshold = 60,
}: SwipeableRowProps) {
    const [dragX, setDragX] = useState(0);
    const [isDragging, setIsDragging] = useState(false);
    const longPressTimer = useRef<number | null>(null);
    const hasTriggeredAction = useRef(false);
    const [prefs] = useMobilePreferences();
    const reduceMotion = useReducedMotion();

    const triggerHaptic = (type: 'selection' | 'impact' | 'success') => {
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
            if (info.offset.x > threshold && leftActions.length > 0) {
                hasTriggeredAction.current = true;
                triggerHaptic('selection');
            } else if (info.offset.x < -threshold && rightActions.length > 0) {
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

        if (offset > threshold || (offset > 30 && velocity > 200)) {
            if (leftActions.length > 0) {
                triggerHaptic('impact');
                leftActions[0].onAction();
            }
        } else if (offset < -threshold || (offset < -30 && velocity > 200)) {
            if (rightActions.length > 0) {
                triggerHaptic('impact');
                rightActions[0].onAction();
            }
        }
    };

    const startLongPress = (e: React.PointerEvent) => {
        if (onLongPress) {
            longPressTimer.current = window.setTimeout(() => {
                triggerHaptic('selection');
                onLongPress(e);
            }, 500);
        }
    };

    const clearLongPress = () => {
        if (longPressTimer.current) {
            clearTimeout(longPressTimer.current);
            longPressTimer.current = null;
        }
    };

    const handlePointerUp = () => {
        clearLongPress();
        if (!isDragging && onPress) {
            onPress();
        }
    };

    const leftAction = leftActions[0];
    const rightAction = rightActions[0];

    const leftOpacity = Math.min(Math.max(dragX / threshold, 0), 1);
    const rightOpacity = Math.min(Math.max(-dragX / threshold, 0), 1);

    const animationProps = reduceMotion
        ? { transition: { duration: 0 } }
        : { transition: { type: 'spring' as const, stiffness: 500, damping: 35 } };

    return (
        <div className={`relative overflow-hidden rounded-[var(--corner-card)] ${className}`}>
            {leftAction && (
                <div
                    className={`
                        absolute inset-y-0 left-0 w-20
                        ${colorClasses[leftAction.color]}
                        flex items-center justify-center
                    `}
                    style={{ opacity: leftOpacity }}
                >
                    <leftAction.icon className="w-6 h-6 text-white" />
                </div>
            )}

            {rightAction && (
                <div
                    className={`
                        absolute inset-y-0 right-0 w-20
                        ${colorClasses[rightAction.color]}
                        flex items-center justify-center
                    `}
                    style={{ opacity: rightOpacity }}
                >
                    <rightAction.icon className="w-6 h-6 text-white" />
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
                onPointerUp={handlePointerUp}
                onPointerCancel={clearLongPress}
                animate={{ x: 0 }}
                {...animationProps}
                className="relative bg-[var(--secondary-system-background)] touch-pan-y"
            >
                {children}
            </motion.div>
        </div>
    );
}
