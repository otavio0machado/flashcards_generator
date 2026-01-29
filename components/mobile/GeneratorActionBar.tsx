'use client';

import React from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Save, Download, RefreshCw, Loader2 } from 'lucide-react';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface GeneratorActionBarProps {
    visible: boolean;
    cardCount: number;
    onSave: () => void;
    onExport: () => void;
    onRegenerate: () => void;
    isSaving?: boolean;
    isExporting?: boolean;
    isRegenerating?: boolean;
    saveDisabled?: boolean;
    exportDisabled?: boolean;
    regenerateDisabled?: boolean;
}

export default function GeneratorActionBar({
    visible,
    cardCount,
    onSave,
    onExport,
    onRegenerate,
    isSaving = false,
    isExporting = false,
    isRegenerating = false,
    saveDisabled = false,
    exportDisabled = false,
    regenerateDisabled = false,
}: GeneratorActionBarProps) {
    const [prefs] = useMobilePreferences();

    const handleAction = (action: () => void, disabled: boolean) => {
        if (disabled) return;
        if (prefs.hapticFeedbackEnabled) {
            haptic('impact');
        }
        action();
    };

    return (
        <AnimatePresence>
            {visible && cardCount > 0 && (
                <motion.div
                    initial={{ y: 100, opacity: 0 }}
                    animate={{ y: 0, opacity: 1 }}
                    exit={{ y: 100, opacity: 0 }}
                    transition={{ type: 'spring', stiffness: 400, damping: 30 }}
                    className="fixed bottom-20 left-0 right-0 z-40 px-4 pb-safe md:hidden"
                >
                    <div className="bg-[var(--secondary-system-background)] border border-zinc-200/50 dark:border-zinc-800/50 rounded-[var(--corner-soft)] p-2 shadow-[0_-4px_20px_-5px_rgba(0,0,0,0.15)] backdrop-blur-xl">
                        <div className="flex items-center gap-2">
                            {/* Save Button */}
                            <button
                                onClick={() => handleAction(onSave, saveDisabled || isSaving)}
                                disabled={saveDisabled || isSaving}
                                className={`
                                    flex-1 flex items-center justify-center gap-2
                                    h-12 rounded-[var(--corner-card)]
                                    font-bold text-sm
                                    transition-all active:scale-95
                                    ${saveDisabled || isSaving
                                        ? 'bg-zinc-100 dark:bg-zinc-800 text-zinc-400'
                                        : 'bg-brand text-white shadow-lg shadow-brand/20'
                                    }
                                `}
                                aria-label="Salvar deck"
                            >
                                {isSaving ? (
                                    <Loader2 className="w-4 h-4 animate-spin" />
                                ) : (
                                    <Save className="w-4 h-4" />
                                )}
                                <span>Salvar</span>
                            </button>

                            {/* Export Button */}
                            <button
                                onClick={() => handleAction(onExport, exportDisabled || isExporting)}
                                disabled={exportDisabled || isExporting}
                                className={`
                                    flex items-center justify-center gap-2
                                    h-12 px-4 rounded-[var(--corner-card)]
                                    font-bold text-sm
                                    border-2 transition-all active:scale-95
                                    ${exportDisabled || isExporting
                                        ? 'border-zinc-200 dark:border-zinc-700 text-zinc-400'
                                        : 'border-zinc-300 dark:border-zinc-600 text-[var(--label)] hover:border-brand'
                                    }
                                `}
                                aria-label="Exportar cards"
                            >
                                {isExporting ? (
                                    <Loader2 className="w-4 h-4 animate-spin" />
                                ) : (
                                    <Download className="w-4 h-4" />
                                )}
                            </button>

                            {/* Regenerate Button */}
                            <button
                                onClick={() => handleAction(onRegenerate, regenerateDisabled || isRegenerating)}
                                disabled={regenerateDisabled || isRegenerating}
                                className={`
                                    flex items-center justify-center
                                    h-12 w-12 rounded-[var(--corner-card)]
                                    border-2 transition-all active:scale-95
                                    ${regenerateDisabled || isRegenerating
                                        ? 'border-zinc-200 dark:border-zinc-700 text-zinc-400'
                                        : 'border-zinc-300 dark:border-zinc-600 text-[var(--label)] hover:border-brand'
                                    }
                                `}
                                aria-label="Gerar novamente"
                            >
                                {isRegenerating ? (
                                    <Loader2 className="w-4 h-4 animate-spin" />
                                ) : (
                                    <RefreshCw className="w-4 h-4" />
                                )}
                            </button>
                        </div>

                        {/* Card count indicator */}
                        <div className="flex items-center justify-center mt-2">
                            <span className="text-[10px] font-bold text-zinc-400 uppercase tracking-widest">
                                {cardCount} {cardCount === 1 ? 'card' : 'cards'} gerados
                            </span>
                        </div>
                    </div>
                </motion.div>
            )}
        </AnimatePresence>
    );
}
