'use client';

import { motion } from 'framer-motion';

interface Props {
    currentStep: number; // 0-3
    totalSteps?: number;
}

export default function OnboardingProgressDots({ currentStep, totalSteps = 4 }: Props) {
    return (
        <div
            className="flex items-center justify-center gap-2"
            role="progressbar"
            aria-valuenow={currentStep + 1}
            aria-valuemin={1}
            aria-valuemax={totalSteps}
            aria-label={`Passo ${currentStep + 1} de ${totalSteps}`}
        >
            {Array.from({ length: totalSteps }, (_, i) => (
                <motion.div
                    key={i}
                    className={`h-2.5 rounded-full transition-colors ${
                        i === currentStep
                            ? 'bg-[var(--color-brand)] w-8'
                            : i < currentStep
                            ? 'bg-[var(--color-brand)]/40 w-2.5'
                            : 'bg-[var(--color-border)] w-2.5'
                    }`}
                    animate={{ scale: i === currentStep ? 1.1 : 1 }}
                    transition={{ type: 'spring', stiffness: 300, damping: 20 }}
                />
            ))}
        </div>
    );
}
