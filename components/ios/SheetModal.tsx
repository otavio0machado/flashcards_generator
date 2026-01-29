'use client';

import React, { useEffect, useCallback } from 'react';
import { motion, AnimatePresence, PanInfo, useReducedMotion } from 'framer-motion';
import { X } from 'lucide-react';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

type SheetDetent = 'medium' | 'large' | 'full';

interface SheetModalProps {
    open: boolean;
    onClose: () => void;
    children: React.ReactNode;
    title?: string;
    detent?: SheetDetent;
    showCloseButton?: boolean;
    showDragHandle?: boolean;
    className?: string;
}

const detentHeights: Record<SheetDetent, string> = {
    medium: '50vh',
    large: '85vh',
    full: '100vh',
};

export default function SheetModal({
    open,
    onClose,
    children,
    title,
    detent = 'large',
    showCloseButton = true,
    showDragHandle = true,
    className = '',
}: SheetModalProps) {
    const [prefs] = useMobilePreferences();
    const reduceMotion = useReducedMotion();

    const triggerHaptic = useCallback(() => {
        if (prefs.hapticFeedbackEnabled) {
            haptic('impact');
        }
    }, [prefs.hapticFeedbackEnabled]);

    useEffect(() => {
        if (open) {
            document.body.style.overflow = 'hidden';
            triggerHaptic();
        } else {
            document.body.style.overflow = '';
        }
        return () => {
            document.body.style.overflow = '';
        };
    }, [open, triggerHaptic]);

    useEffect(() => {
        const handleEscape = (e: KeyboardEvent) => {
            if (e.key === 'Escape' && open) {
                onClose();
            }
        };
        document.addEventListener('keydown', handleEscape);
        return () => document.removeEventListener('keydown', handleEscape);
    }, [open, onClose]);

    const handleDragEnd = (_: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        if (info.velocity.y > 300 || info.offset.y > 100) {
            onClose();
        }
    };

    const animationProps = reduceMotion
        ? { transition: { duration: 0 } }
        : { transition: { type: 'spring' as const, stiffness: 400, damping: 35 } };

    return (
        <AnimatePresence>
            {open && (
                <>
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        transition={{ duration: reduceMotion ? 0 : 0.2 }}
                        className="fixed inset-0 z-[80] bg-black/40 backdrop-blur-sm"
                        onClick={onClose}
                        aria-hidden="true"
                    />

                    <motion.div
                        initial={{ y: '100%' }}
                        animate={{ y: 0 }}
                        exit={{ y: '100%' }}
                        {...animationProps}
                        drag="y"
                        dragConstraints={{ top: 0 }}
                        dragElastic={0.2}
                        onDragEnd={handleDragEnd}
                        style={{ maxHeight: detentHeights[detent] }}
                        className={`
                            fixed bottom-0 left-0 right-0 z-[90]
                            bg-[var(--secondary-system-background)]
                            rounded-t-[20px]
                            shadow-[0_-10px_40px_-10px_rgba(0,0,0,0.2)]
                            flex flex-col
                            pb-safe
                            ${className}
                        `}
                        role="dialog"
                        aria-modal="true"
                        aria-labelledby={title ? 'sheet-title' : undefined}
                    >
                        {showDragHandle && (
                            <div className="flex justify-center pt-3 pb-2 cursor-grab active:cursor-grabbing">
                                <div className="w-10 h-1 bg-zinc-300 dark:bg-zinc-600 rounded-full" />
                            </div>
                        )}

                        {(title || showCloseButton) && (
                            <div className="flex items-center justify-between px-4 py-3 border-b border-zinc-200/50 dark:border-zinc-800/50">
                                {title && (
                                    <h2
                                        id="sheet-title"
                                        className="text-lg font-bold text-[var(--label)]"
                                    >
                                        {title}
                                    </h2>
                                )}
                                {showCloseButton && (
                                    <button
                                        onClick={onClose}
                                        className="p-2 -mr-2 text-zinc-500 hover:text-zinc-700 dark:hover:text-zinc-300 transition-colors"
                                        aria-label="Fechar"
                                    >
                                        <X className="w-5 h-5" />
                                    </button>
                                )}
                            </div>
                        )}

                        <div className="flex-1 overflow-y-auto overscroll-contain">
                            {children}
                        </div>
                    </motion.div>
                </>
            )}
        </AnimatePresence>
    );
}
