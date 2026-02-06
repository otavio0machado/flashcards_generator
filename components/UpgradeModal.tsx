'use client';

import React from 'react';
import { useRouter } from 'next/navigation';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { X, Zap, ArrowRight, Check, Minus, Crown } from 'lucide-react';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';

interface UpgradeModalProps {
    isOpen: boolean;
    onClose: () => void;
}

const plans: { key: PlanKey; highlight?: boolean }[] = [
    { key: 'free' },
    { key: 'pro', highlight: true },
    { key: 'ultimate' },
];

const featureRows: { label: string; getValue: (key: PlanKey) => string | boolean }[] = [
    { label: 'Gerações/dia', getValue: (k) => `${PLAN_LIMITS[k].dailyGens}` },
    { label: 'Cards por geração', getValue: (k) => `${PLAN_LIMITS[k].maxCardsPerGen}` },
    { label: 'Caracteres máx.', getValue: (k) => PLAN_LIMITS[k].maxChars >= 100000 ? '100k' : `${(PLAN_LIMITS[k].maxChars / 1000).toFixed(0)}k` },
    { label: 'Upload PDF/DOCX', getValue: (k) => PLAN_LIMITS[k].allowFile },
    { label: 'OCR de imagem', getValue: (k) => PLAN_LIMITS[k].allowOCR },
    { label: 'Modo ENEM', getValue: (k) => PLAN_LIMITS[k].allowEnemMode },
    { label: 'Histórico salvo', getValue: (k) => PLAN_LIMITS[k].historySaved },
    { label: 'Suporte prioritário', getValue: (k) => PLAN_LIMITS[k].prioritySupport },
];

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
                            className="bg-white w-full max-w-2xl p-6 sm:p-8 rounded-sm relative z-10 shadow-2xl border border-border max-h-[90vh] overflow-y-auto"
                        >
                            <button
                                onClick={onClose}
                                className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors"
                                aria-label="Fechar modal"
                            >
                                <X className="h-5 w-5" aria-hidden="true" />
                            </button>

                            <div className="flex items-center justify-center gap-2 mb-2">
                                <Crown className="h-5 w-5 text-brand" />
                                <h2 id="upgrade-modal-title" className="text-xl font-bold text-foreground">
                                    Compare os planos
                                </h2>
                            </div>
                            <p className="text-center text-sm text-foreground/50 font-medium mb-6">
                                Escolha o plano ideal para seus estudos.
                            </p>

                            {/* Plan headers */}
                            <div className="grid grid-cols-4 gap-2 mb-1">
                                <div />
                                {plans.map(({ key, highlight }) => (
                                    <m.div
                                        key={key}
                                        initial={{ opacity: 0, y: 10 }}
                                        animate={{ opacity: 1, y: 0 }}
                                        transition={{ delay: 0.1 }}
                                        className={`text-center p-3 rounded-sm ${highlight ? 'bg-brand/5 border-2 border-brand' : 'bg-gray-50 border border-border'}`}
                                    >
                                        <div className="text-[10px] font-black uppercase tracking-widest text-foreground/40 mb-1">
                                            {PLAN_LIMITS[key].name}
                                        </div>
                                        <div className={`text-lg font-black ${highlight ? 'text-brand' : 'text-foreground'}`}>
                                            {PLAN_LIMITS[key].price}
                                        </div>
                                        {key !== 'free' && (
                                            <div className="text-[10px] font-medium text-foreground/30">/mês</div>
                                        )}
                                    </m.div>
                                ))}
                            </div>

                            {/* Feature comparison rows */}
                            <div className="divide-y divide-border">
                                {featureRows.map((row, i) => (
                                    <m.div
                                        key={row.label}
                                        initial={{ opacity: 0, x: -5 }}
                                        animate={{ opacity: 1, x: 0 }}
                                        transition={{ delay: 0.15 + i * 0.03 }}
                                        className="grid grid-cols-4 gap-2 py-2.5 items-center"
                                    >
                                        <div className="text-xs font-bold text-foreground/60">{row.label}</div>
                                        {plans.map(({ key }) => {
                                            const value = row.getValue(key);
                                            return (
                                                <div key={key} className="text-center text-sm font-bold">
                                                    {typeof value === 'boolean' ? (
                                                        value ? (
                                                            <Check className="h-4 w-4 text-brand mx-auto" />
                                                        ) : (
                                                            <Minus className="h-4 w-4 text-foreground/15 mx-auto" />
                                                        )
                                                    ) : (
                                                        <span className="text-foreground/80">{value}</span>
                                                    )}
                                                </div>
                                            );
                                        })}
                                    </m.div>
                                ))}
                            </div>

                            {/* CTA buttons */}
                            <div className="mt-6 space-y-3">
                                <m.button
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    onClick={() => {
                                        onClose();
                                        router.push('/#pricing');
                                    }}
                                    className="group w-full bg-brand text-white py-3.5 font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 flex items-center justify-center gap-2"
                                >
                                    <Zap className="h-4 w-4" />
                                    Ver planos e assinar
                                    <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                                </m.button>
                                <button
                                    onClick={onClose}
                                    className="w-full text-foreground/40 font-bold py-2 text-sm hover:text-foreground/60 transition-colors"
                                >
                                    Continuar no plano atual
                                </button>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
