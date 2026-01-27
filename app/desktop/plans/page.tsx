'use client';

import { useEffect } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import { ArrowRight, Check } from 'lucide-react';
import { isTauriApp } from '@/lib/tauri';
import { setOnboardingStep, skipOnboarding } from '@/lib/desktop-onboarding';
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

export default function PlansPage() {
    const router = useRouter();

    useEffect(() => {
        setOnboardingStep('plans');
        if (!isTauriApp()) {
            router.replace('/');
        }
    }, [router]);

    const handleNext = () => {
        router.push('/desktop/login');
    };

    const handleSkip = () => {
        skipOnboarding();
        router.replace('/auth/login');
    };

    return (
        <div className="fixed inset-0 flex flex-col items-center justify-center p-6 overflow-auto bg-[var(--background)]">
            <div className="max-w-3xl w-full py-8">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 16 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="text-center mb-10"
                >
                    <h1 className="text-3xl font-bold text-[var(--foreground)] mb-3 tracking-tight">
                        Escolha seu plano
                    </h1>
                    <p className="text-base text-[var(--color-text-secondary)]">
                        Comece gratuitamente. Faça upgrade quando precisar.
                    </p>
                </motion.div>

                {/* Plans Grid */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-5 mb-10">
                    {plans.map((plan, index) => (
                        <motion.div
                            key={plan.name}
                            initial={{ opacity: 0, y: 12 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: index * 0.1 }}
                            className={`relative p-6 rounded-xl border-2 bg-[var(--surface,var(--background))] ${
                                plan.popular
                                    ? 'border-brand shadow-lg shadow-brand/10'
                                    : 'border-[var(--color-border)]'
                            }`}
                        >
                            {plan.popular && (
                                <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-brand text-white text-xs font-semibold rounded-full">
                                    Recomendado
                                </div>
                            )}

                            <h3 className="text-xl font-bold text-[var(--foreground)] mb-1">
                                {plan.name}
                            </h3>

                            <div className="flex items-baseline gap-1 mb-5">
                                <span className="text-3xl font-bold text-[var(--foreground)]">
                                    {plan.price}
                                </span>
                                <span className="text-sm text-[var(--color-text-secondary)]">
                                    {plan.period}
                                </span>
                            </div>

                            <ul className="space-y-2.5">
                                {plan.features.map((feature, i) => (
                                    <li key={i} className="flex items-center gap-2.5">
                                        <div className={`w-4 h-4 rounded-full flex items-center justify-center ${
                                            plan.popular
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
                                    <li key={i} className="flex items-center gap-2.5 opacity-40">
                                        <div className="w-4 h-4 rounded-full bg-[var(--color-border)] flex items-center justify-center">
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
                    <div className="mb-8">
                        <OnboardingProgressDots currentStep={2} />
                    </div>

                    <div className="flex flex-col items-center gap-3">
                        <button
                            onClick={handleNext}
                            className="inline-flex items-center gap-2.5 px-8 py-3.5 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 transition-colors"
                        >
                            <span>Criar Conta</span>
                            <ArrowRight className="w-5 h-5" />
                        </button>
                        <button
                            onClick={handleSkip}
                            className="text-sm text-[var(--color-text-secondary)] hover:text-[var(--foreground)] transition-colors"
                        >
                            Pular introdução
                        </button>
                    </div>

                    <p className="text-sm text-[var(--color-text-secondary)] mt-4">
                        Escolha o plano após criar sua conta
                    </p>
                </motion.div>
            </div>
        </div>
    );
}
