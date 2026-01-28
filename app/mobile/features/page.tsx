'use client';

import { useEffect } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import {
    ArrowRight,
    Zap,
    Brain,
    Download,
    BarChart3,
    Palette,
    Globe
} from 'lucide-react';
import { isTauriApp } from '@/lib/tauri';
import { setMobileOnboardingStep, skipMobileOnboarding } from '@/lib/mobile-onboarding';
import OnboardingProgressDots from '@/components/OnboardingProgressDots';

const features = [
    {
        icon: Zap,
        title: 'Geração Instantânea',
        description: 'Cole qualquer texto e gere flashcards em segundos.',
    },
    {
        icon: Brain,
        title: 'IA Inteligente',
        description: 'Identifica pontos importantes e cria perguntas relevantes.',
    },
    {
        icon: Download,
        title: 'Exportar para Anki',
        description: 'Exporte seus decks para o Anki e outros apps.',
    },
    {
        icon: BarChart3,
        title: 'Estatísticas',
        description: 'Acompanhe seu progresso com métricas detalhadas.',
    },
    {
        icon: Palette,
        title: 'Personalização',
        description: 'Customize flashcards com cores e imagens.',
    },
    {
        icon: Globe,
        title: 'Marketplace',
        description: 'Acesse decks prontos criados pela comunidade.',
    },
];

export default function MobileFeaturesPage() {
    const router = useRouter();

    useEffect(() => {
        setMobileOnboardingStep('features');
        if (!isTauriApp()) {
            router.replace('/');
        }
    }, [router]);

    const handleNext = () => {
        router.push('/mobile/plans');
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
                    className="text-center mb-6"
                >
                    <h1 className="text-2xl font-bold text-[var(--foreground)] mb-2 tracking-tight">
                        Recursos do aplicativo
                    </h1>
                    <p className="text-sm text-[var(--color-text-secondary)] max-w-sm mx-auto">
                        Ferramentas para transformar sua forma de estudar
                    </p>
                </motion.div>

                {/* Features Grid - 2 columns for mobile */}
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.1 }}
                    className="grid grid-cols-2 gap-3 mb-6"
                >
                    {features.map((feature, index) => (
                        <motion.div
                            key={index}
                            initial={{ opacity: 0, y: 12 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.1 + index * 0.05 }}
                            className="p-4 bg-[var(--surface,var(--background))] rounded-xl border border-[var(--color-border)]"
                        >
                            <div className="w-9 h-9 rounded-lg bg-brand/10 flex items-center justify-center mb-2">
                                <feature.icon className="w-4.5 h-4.5 text-brand" />
                            </div>
                            <h3 className="text-xs font-semibold text-[var(--foreground)] mb-0.5">
                                {feature.title}
                            </h3>
                            <p className="text-[11px] text-[var(--color-text-secondary)] leading-relaxed">
                                {feature.description}
                            </p>
                        </motion.div>
                    ))}
                </motion.div>

                {/* Progress & Button */}
                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.4 }}
                    className="text-center"
                >
                    <div className="mb-5">
                        <OnboardingProgressDots currentStep={1} />
                    </div>

                    <div className="flex flex-col items-center gap-3">
                        <button
                            onClick={handleNext}
                            className="inline-flex items-center gap-2.5 px-8 py-3.5 bg-brand text-white font-semibold rounded-xl active:scale-[0.98] transition-all w-full justify-center"
                        >
                            <span>Ver Planos</span>
                            <ArrowRight className="w-5 h-5" />
                        </button>
                        <button
                            onClick={handleSkip}
                            className="text-sm text-[var(--color-text-secondary)] hover:text-[var(--foreground)] transition-colors py-2"
                        >
                            Pular introdução
                        </button>
                    </div>
                </motion.div>
            </div>
        </div>
    );
}
