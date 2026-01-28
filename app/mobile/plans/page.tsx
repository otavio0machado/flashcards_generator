'use client';

import { useEffect } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import { ArrowRight, Check } from 'lucide-react';
import { isTauriApp } from '@/lib/tauri';
import { setMobileOnboardingStep, skipMobileOnboarding } from '@/lib/mobile-onboarding';
import OnboardingProgressDots from '@/components/OnboardingProgressDots';

const plans = [
    {
        name: 'Gratuito',
        price: 'R$ 0',
        period: 'para sempre',
        features: [
            '3 decks por mês',
            '10 flashcards por deck',
            'Exportar para Anki',
            'Acesso ao Marketplace',
        ],
        limitations: [
            'Sem imagens nos cards',
            'Sem estatísticas avançadas',
        ],
        popular: false,
    },
    {
        name: 'Pro',
        price: 'R$ 19,90',
        period: '/mês',
        features: [
            'Decks ilimitados',
            'Flashcards ilimitados',
            'Imagens com IA',
            'Estatísticas avançadas',
            'Prioridade no suporte',
            'Sem anúncios',
        ],
        limitations: [],
        popular: true,
    },
];

export default function MobilePlansPage() {
    const router = useRouter();

    useEffect(() => {
        setMobileOnboardingStep('plans');
        if (!isTauriApp()) {
            router.replace('/');
        }
    }, [router]);

    const handleNext = () => {
        router.push('/mobile/login');
    };

    const handleSkip = () => {
        skipMobileOnboarding();
        router.replace('/auth/login');
    };

    return (
        <div className="fixed inset-0 flex flex-col items-center justify-center p-5 overflow-auto bg-[var(--background)] safe-area-inset">
            <div className="max-w-md w-full py-6">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 16 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="text-center mb-5"
                >
                    <h1 className="text-2xl font-bold text-[var(--foreground)] mb-2 tracking-tight">
                        Escolha seu plano
                    </h1>
                    <p className="text-sm text-[var(--color-text-secondary)]">
                        Comece gratuitamente. Faça upgrade quando precisar.
                    </p>
                </motion.div>

                {/* Plans - stacked for mobile */}
                <div className="flex flex-col gap-3 mb-6">
                    {plans.map((plan, index) => (
                        <motion.div
                            key={plan.name}
                            initial={{ opacity: 0, y: 12 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: index * 0.1 }}
                            className={`relative p-5 rounded-xl border-2 bg-[var(--surface,var(--background))] ${plan.popular
                                ? 'border-brand shadow-lg shadow-brand/10'
                                : 'border-[var(--color-border)]'
                                }`}
                        >
                            {plan.popular && (
                                <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-brand text-white text-xs font-semibold rounded-full">
                                    Recomendado
                                </div>
                            )}

                            <div className="flex items-baseline justify-between mb-4">
                                <h3 className="text-lg font-bold text-[var(--foreground)]">
                                    {plan.name}
                                </h3>
                                <div className="flex items-baseline gap-1">
                                    <span className="text-2xl font-bold text-[var(--foreground)]">
                                        {plan.price}
                                    </span>
                                    <span className="text-xs text-[var(--color-text-secondary)]">
                                        {plan.period}
                                    </span>
                                </div>
                            </div>

                            <ul className="space-y-2">
                                {plan.features.map((feature, i) => (
                                    <li key={i} className="flex items-center gap-2">
                                        <div className={`w-4 h-4 rounded-full flex items-center justify-center shrink-0 ${plan.popular
                                            ? 'bg-brand/15 text-brand'
                                            : 'bg-[var(--color-border)] text-[var(--color-text-secondary)]'
                                            }`}>
                                            <Check className="w-2.5 h-2.5" strokeWidth={3} />
                                        </div>
                                        <span className="text-sm text-[var(--foreground)]">
                                            {feature}
                                        </span>
                                    </li>
                                ))}
                                {plan.limitations.map((limitation, i) => (
                                    <li key={i} className="flex items-center gap-2 opacity-40">
                                        <div className="w-4 h-4 rounded-full bg-[var(--color-border)] flex items-center justify-center shrink-0">
                                            <span className="text-[10px] text-[var(--color-text-secondary)]">✕</span>
                                        </div>
                                        <span className="text-sm text-[var(--color-text-secondary)] line-through">
                                            {limitation}
                                        </span>
                                    </li>
                                ))}
                            </ul>
                        </motion.div>
                    ))}
                </div>

                {/* Progress & Button */}
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.3 }}
                    className="text-center"
                >
                    <div className="mb-5">
                        <OnboardingProgressDots currentStep={2} />
                    </div>

                    <div className="flex flex-col items-center gap-3">
                        <button
                            onClick={handleNext}
                            className="inline-flex items-center gap-2.5 px-8 py-3.5 bg-brand text-white font-semibold rounded-xl active:scale-[0.98] transition-all w-full justify-center"
                        >
                            <span>Criar Conta</span>
                            <ArrowRight className="w-5 h-5" />
                        </button>
                        <button
                            onClick={handleSkip}
                            className="text-sm text-[var(--color-text-secondary)] hover:text-[var(--foreground)] transition-colors py-2"
                        >
                            Pular introdução
                        </button>
                    </div>

                    <p className="text-xs text-[var(--color-text-secondary)] mt-3">
                        Escolha o plano após criar sua conta
                    </p>
                </motion.div>
            </div>
        </div>
    );
}
