'use client';

import { useState, useEffect, useCallback } from 'react';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { ClipboardPaste, Zap, Download, ArrowRight, X } from 'lucide-react';

const STORAGE_KEY = 'fg_onboarding_completed';

const steps = [
    {
        icon: ClipboardPaste,
        title: 'Cole seu texto',
        description:
            'Cole ou digite o conte\u00FAdo que deseja transformar em flashcards. Pode ser um resumo, cap\u00EDtulo de livro ou anota\u00E7\u00F5es de aula.',
        iconBg: 'bg-blue-500/10',
        iconColor: 'text-blue-500',
    },
    {
        icon: Zap,
        title: 'IA gera os cards',
        description:
            'Nossa IA analisa o texto e cria perguntas e respostas automaticamente. Voc\u00EA pode editar cada card antes de salvar.',
        iconBg: 'bg-brand/10',
        iconColor: 'text-brand',
    },
    {
        icon: Download,
        title: 'Estude e exporte',
        description:
            'Salve na sua biblioteca, estude com repeti\u00E7\u00E3o espa\u00E7ada ou exporte para o Anki.',
        iconBg: 'bg-emerald-500/10',
        iconColor: 'text-emerald-500',
    },
] as const;

const slideVariants = {
    enter: (direction: number) => ({
        x: direction > 0 ? 80 : -80,
        opacity: 0,
    }),
    center: {
        x: 0,
        opacity: 1,
    },
    exit: (direction: number) => ({
        x: direction > 0 ? -80 : 80,
        opacity: 0,
    }),
};

export default function OnboardingOverlay() {
    const [isVisible, setIsVisible] = useState(false);
    const [currentStep, setCurrentStep] = useState(0);
    const [direction, setDirection] = useState(1);

    useEffect(() => {
        try {
            const completed = localStorage.getItem(STORAGE_KEY);
            if (!completed) {
                setIsVisible(true);
            }
        } catch {
            // localStorage unavailable — do not show
        }
    }, []);

    const completeOnboarding = useCallback(() => {
        try {
            localStorage.setItem(STORAGE_KEY, 'true');
        } catch {
            // ignore storage errors
        }
        setIsVisible(false);
    }, []);

    const handleNext = useCallback(() => {
        if (currentStep < steps.length - 1) {
            setDirection(1);
            setCurrentStep((prev) => prev + 1);
        } else {
            completeOnboarding();
        }
    }, [currentStep, completeOnboarding]);

    const step = steps[currentStep];
    const isLastStep = currentStep === steps.length - 1;
    const Icon = step.icon;

    if (!isVisible) return null;

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {isVisible && (
                    <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 sm:p-6">
                        {/* Backdrop */}
                        <m.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="absolute inset-0 bg-black/40 backdrop-blur-sm"
                            onClick={completeOnboarding}
                        />

                        {/* Modal */}
                        <m.div
                            initial={{ opacity: 0, scale: 0.95, y: 20 }}
                            animate={{ opacity: 1, scale: 1, y: 0 }}
                            exit={{ opacity: 0, scale: 0.95, y: 20 }}
                            transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                            className="relative w-full max-w-md bg-white border border-border rounded-sm shadow-2xl p-8 overflow-hidden"
                        >
                            {/* Close button */}
                            <button
                                onClick={completeOnboarding}
                                className="absolute top-4 right-4 text-foreground/20 hover:text-foreground transition-colors p-1"
                                aria-label="Fechar"
                            >
                                <X className="h-5 w-5" />
                            </button>

                            {/* Step indicator label */}
                            <div className="text-[10px] font-bold uppercase tracking-widest text-foreground/40 mb-6">
                                Passo {currentStep + 1} de {steps.length}
                            </div>

                            {/* Animated step content */}
                            <div className="relative min-h-[200px]">
                                <AnimatePresence mode="wait" custom={direction}>
                                    <m.div
                                        key={currentStep}
                                        custom={direction}
                                        variants={slideVariants}
                                        initial="enter"
                                        animate="center"
                                        exit="exit"
                                        transition={{ type: 'spring', damping: 28, stiffness: 320, duration: 0.3 }}
                                    >
                                        {/* Icon */}
                                        <m.div
                                            initial={{ scale: 0 }}
                                            animate={{ scale: 1 }}
                                            transition={{ type: 'spring', delay: 0.1 }}
                                            className={`w-14 h-14 rounded-sm ${step.iconBg} flex items-center justify-center mb-5`}
                                        >
                                            <Icon className={`w-7 h-7 ${step.iconColor}`} />
                                        </m.div>

                                        {/* Title */}
                                        <h2 className="text-xl font-bold text-foreground mb-2 tracking-tight">
                                            {step.title}
                                        </h2>

                                        {/* Description */}
                                        <p className="text-foreground/60 text-sm font-medium leading-relaxed">
                                            {step.description}
                                        </p>
                                    </m.div>
                                </AnimatePresence>
                            </div>

                            {/* Step dots */}
                            <div className="flex items-center justify-center gap-2 mt-8 mb-6">
                                {steps.map((_, i) => (
                                    <m.div
                                        key={i}
                                        className={`h-2 rounded-full transition-colors ${
                                            i === currentStep
                                                ? 'bg-brand w-6'
                                                : i < currentStep
                                                  ? 'bg-brand/40 w-2'
                                                  : 'bg-border w-2'
                                        }`}
                                        animate={{ scale: i === currentStep ? 1.1 : 1 }}
                                        transition={{ type: 'spring', stiffness: 300, damping: 20 }}
                                    />
                                ))}
                            </div>

                            {/* Actions */}
                            <div className="flex items-center justify-between text-[10px] font-bold uppercase tracking-widest">
                                <button
                                    onClick={completeOnboarding}
                                    className="text-foreground/40 hover:text-foreground transition-colors py-3 px-1"
                                >
                                    Pular
                                </button>

                                <m.button
                                    whileHover={{ scale: 1.02 }}
                                    whileTap={{ scale: 0.98 }}
                                    onClick={handleNext}
                                    className="inline-flex items-center gap-2 px-6 py-3 bg-brand text-white rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                                >
                                    <span>{isLastStep ? 'Come\u00E7ar!' : 'Pr\u00F3ximo'}</span>
                                    {!isLastStep && <ArrowRight className="w-3.5 h-3.5" />}
                                </m.button>
                            </div>
                        </m.div>
                    </div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
