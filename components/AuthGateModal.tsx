'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { X, Lock, ArrowRight } from 'lucide-react';

interface AuthGateModalProps {
    isOpen: boolean;
    onClose: () => void;
    title?: string;
    description?: string;
    onSignupClick?: () => void;
    onLoginClick?: () => void;
    onDismiss?: () => void;
}

export default function AuthGateModal({
    isOpen,
    onClose,
    title = 'Salve e exporte seus flashcards',
    description = 'Crie uma conta gratuita em 10 segundos para salvar, exportar e gerar mais.',
    onSignupClick,
    onLoginClick,
    onDismiss,
}: AuthGateModalProps) {
    const router = useRouter();

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isOpen && (
                    <div className="fixed inset-0 z-[110] flex items-center justify-center p-4">
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                            onClick={() => {
                                onDismiss?.();
                                onClose();
                            }}
                        />
                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="bg-white border border-border w-full max-w-md p-8 rounded-sm relative z-10 shadow-2xl"
                        >
                            <button
                                onClick={() => {
                                    onDismiss?.();
                                    onClose();
                                }}
                                className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors"
                                aria-label="Fechar"
                            >
                                <X className="h-5 w-5" />
                            </button>

                            <m.div
                                initial={{ scale: 0 }}
                                animate={{ scale: 1 }}
                                transition={{ type: 'spring', delay: 0.1 }}
                                className="bg-brand/10 w-16 h-16 rounded-full flex items-center justify-center mb-6 mx-auto"
                            >
                                <Lock className="h-8 w-8 text-brand" />
                            </m.div>

                            <m.h2
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.15 }}
                                className="text-2xl font-bold text-center mb-2 text-foreground"
                            >
                                {title}
                            </m.h2>
                            <m.p
                                initial={{ opacity: 0, y: 10 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.2 }}
                                className="text-center text-foreground/60 font-medium mb-8 leading-relaxed"
                            >
                                {description}
                            </m.p>

                            <div className="space-y-3">
                                <m.button
                                    initial={{ opacity: 0, y: 10 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.25 }}
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    onClick={() => {
                                        onSignupClick?.();
                                        onDismiss?.();
                                        onClose();
                                        router.push('/auth/signup');
                                    }}
                                    className="group w-full bg-brand text-white py-4 font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 flex items-center justify-center gap-2"
                                >
                                    Criar conta
                                    <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                </m.button>
                                <m.button
                                    initial={{ opacity: 0 }}
                                    animate={{ opacity: 1 }}
                                    transition={{ delay: 0.3 }}
                                    onClick={() => {
                                        onLoginClick?.();
                                        onDismiss?.();
                                        onClose();
                                        router.push('/auth/login');
                                    }}
                                    className="w-full text-foreground/60 font-bold py-2 text-sm hover:text-foreground transition-colors"
                                >
                                    Já tenho conta → Entrar
                                </m.button>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
