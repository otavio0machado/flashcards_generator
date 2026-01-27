'use client';

import React from 'react';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { AlertCircle, X } from 'lucide-react';

interface ConfirmationModalProps {
    isOpen: boolean;
    onClose: () => void;
    onConfirm: () => void;
    title: string;
    description: string;
    confirmText?: string;
    cancelText?: string;
    variant?: 'danger' | 'warning' | 'info';
}

export default function ConfirmationModal({
    isOpen,
    onClose,
    onConfirm,
    title,
    description,
    confirmText = 'Confirmar',
    cancelText = 'Cancelar',
    variant = 'danger'
}: ConfirmationModalProps) {
    const variantStyles = {
        danger: 'bg-red-500 hover:bg-red-600 shadow-red-500/20',
        warning: 'bg-amber-500 hover:bg-amber-600 shadow-amber-500/20',
        info: 'bg-brand hover:bg-brand/90 shadow-brand/20'
    };

    const iconStyles = {
        danger: 'text-red-500 bg-red-50',
        warning: 'text-amber-500 bg-amber-50',
        info: 'text-brand bg-brand/10'
    };

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isOpen && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6">
                        {/* Backdrop */}
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/40 backdrop-blur-sm"
                            onClick={onClose}
                        />

                        {/* Modal Content */}
                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="relative w-full max-w-md bg-white rounded-sm shadow-2xl overflow-hidden"
                        >
                            <div className="p-6">
                                <div className="flex items-start gap-4">
                                    <m.div
                                        initial={{ scale: 0 }}
                                        animate={{ scale: 1 }}
                                        transition={{ type: 'spring', delay: 0.1 }}
                                        className={`p-2 rounded-sm shrink-0 ${iconStyles[variant]}`}
                                    >
                                        <AlertCircle className="h-6 w-6" />
                                    </m.div>
                                    <div className="flex-1 min-w-0">
                                        <m.h3
                                            initial={{ opacity: 0, x: -10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.1 }}
                                            className="text-xl font-bold text-foreground mb-1 leading-tight"
                                        >
                                            {title}
                                        </m.h3>
                                        <m.p
                                            initial={{ opacity: 0, x: -10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.15 }}
                                            className="text-foreground/60 text-sm font-medium"
                                        >
                                            {description}
                                        </m.p>
                                    </div>
                                    <button
                                        onClick={onClose}
                                        className="text-foreground/20 hover:text-foreground transition-colors p-1"
                                    >
                                        <X className="h-5 w-5" />
                                    </button>
                                </div>

                                <m.div
                                    initial={{ opacity: 0, y: 10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.2 }}
                                    className="mt-8 flex flex-col sm:flex-row gap-3 justify-end uppercase tracking-wider text-[10px] font-black"
                                >
                                    <m.button
                                        whileHover={{ scale: 1.02 }}
                                        whileTap={{ scale: 0.98 }}
                                        onClick={onClose}
                                        className="px-6 py-3 border border-border rounded-sm hover:bg-gray-50 transition-all text-foreground/60"
                                    >
                                        {cancelText}
                                    </m.button>
                                    <m.button
                                        whileHover={{ scale: 1.02 }}
                                        whileTap={{ scale: 0.98 }}
                                        onClick={() => {
                                            onConfirm();
                                            onClose();
                                        }}
                                        className={`px-6 py-3 text-white rounded-sm transition-all shadow-lg ${variantStyles[variant]}`}
                                    >
                                        {confirmText}
                                    </m.button>
                                </m.div>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
