'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { X, Zap, ArrowRight } from 'lucide-react';

interface UpgradeModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export default function UpgradeModal({ isOpen, onClose }: UpgradeModalProps) {
    const router = useRouter();

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isOpen && (
                    <div
                        className="fixed inset-0 z-[100] flex items-center justify-center p-4"
                        role="dialog"
                        aria-modal="true"
                        aria-labelledby="upgrade-modal-title"
                    >
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                            onClick={onClose}
                            aria-hidden="true"
                        />
                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="bg-white border-2 border-brand w-full max-w-md p-8 rounded-sm relative z-10 shadow-2xl"
                        >
                            <button
                                onClick={onClose}
                                className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors"
                                aria-label="Fechar modal"
                            >
                                <X className="h-5 w-5" aria-hidden="true" />
                            </button>

                            <m.div
                                initial={{ scale: 0 }}
                                animate={{ scale: 1 }}
                                transition={{ type: 'spring', delay: 0.1 }}
                                className="bg-brand/10 w-16 h-16 rounded-full flex items-center justify-center mb-6 mx-auto"
                                aria-hidden="true"
                            >
                                <Zap className="h-8 w-8 text-brand" />
                            </m.div>

                            <h2 id="upgrade-modal-title" className="text-2xl font-bold text-center mb-2 text-foreground">
                                Acelere seus estudos com o Plano Pro
                            </h2>
                            <div className="space-y-4 mb-8">
                                <ul className="space-y-2 text-sm text-foreground/80 font-medium bg-gray-50 p-4 rounded-sm border border-border">
                                    {[
                                        'Histórico salvo de todos os baralhos',
                                        '15 gerações por dia (vs 3 no Grátis)',
                                        'Pastas por matéria e Modo ENEM'
                                    ].map((item, index) => (
                                        <m.li
                                            key={index}
                                            initial={{ opacity: 0, x: -10 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.2 + index * 0.1 }}
                                            className="flex items-center gap-2"
                                        >
                                            <Zap className="h-4 w-4 text-brand" />
                                            <span>{item}</span>
                                        </m.li>
                                    ))}
                                </ul>
                                <m.div
                                    initial={{ opacity: 0 }}
                                    animate={{ opacity: 1 }}
                                    transition={{ delay: 0.5 }}
                                    className="text-center"
                                >
                                    <span className="text-3xl font-black text-brand">R$ 9,90</span>
                                    <span className="text-sm font-bold text-foreground/40">/mês</span>
                                </m.div>
                            </div>

                            <div className="space-y-4">
                                <m.button
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    onClick={() => {
                                        onClose();
                                        router.push('/#pricing');
                                    }}
                                    className="group w-full bg-brand text-white py-4 font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 flex items-center justify-center gap-2"
                                >
                                    Liberar Pro agora
                                    <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                </m.button>
                                <button
                                    onClick={onClose}
                                    className="w-full text-foreground/40 font-bold py-2 text-sm hover:text-foreground/60 transition-colors"
                                >
                                    Continuar no Plano Grátis
                                </button>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
