'use client';

import React from 'react';
import { motion } from 'framer-motion';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface Segment {
    id: string;
    label: string;
    icon?: React.ComponentType<{ className?: string }>;
}

interface SegmentedControlProps {
    segments: Segment[];
    selected: string;
    onChange: (id: string) => void;
    className?: string;
    size?: 'sm' | 'md';
}

export default function SegmentedControl({
    segments,
    selected,
    onChange,
    className = '',
    size = 'md',
}: SegmentedControlProps) {
    const [prefs] = useMobilePreferences();

    const handleSelect = (id: string) => {
        if (id === selected) return;
        if (prefs.hapticFeedbackEnabled) {
            haptic('selection');
        }
        onChange(id);
    };

    const sizeClasses = size === 'sm'
        ? 'h-8 text-xs'
        : 'h-11 text-sm';

    return (
        <div
            className={`relative flex p-1 bg-zinc-100 dark:bg-zinc-800/60 rounded-[var(--corner-card)] ${className}`}
            role="tablist"
            aria-label="View options"
        >
            {segments.map((segment) => {
                const isSelected = segment.id === selected;
                return (
                    <button
                        key={segment.id}
                        role="tab"
                        aria-selected={isSelected}
                        aria-controls={`panel-${segment.id}`}
                        onClick={() => handleSelect(segment.id)}
                        className={`
                            relative flex-1 flex items-center justify-center gap-1.5
                            ${sizeClasses}
                            font-semibold
                            transition-colors duration-150
                            min-w-[44px]
                            ${isSelected
                                ? 'text-zinc-900 dark:text-white'
                                : 'text-zinc-500 dark:text-zinc-400 active:text-zinc-700 dark:active:text-zinc-300'
                            }
                        `}
                    >
                        {isSelected && (
                            <motion.div
                                layoutId="segmented-control-indicator"
                                className="absolute inset-0 bg-white dark:bg-zinc-700 rounded-[calc(var(--corner-card)-4px)] shadow-sm"
                                transition={{
                                    type: 'spring',
                                    stiffness: 500,
                                    damping: 35,
                                }}
                            />
                        )}
                        <span className="relative z-10 flex items-center gap-1.5">
                            {segment.icon && <segment.icon className="w-4 h-4" />}
                            {segment.label}
                        </span>
                    </button>
                );
            })}
        </div>
    );
}
