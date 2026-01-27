'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import { Sparkles, ArrowRight } from 'lucide-react';
import { supabase } from '@/lib/supabase';
import { isTauriApp } from '@/lib/tauri';
import { setOnboardingStep, skipOnboarding } from '@/lib/desktop-onboarding';
import OnboardingProgressDots from '@/components/OnboardingProgressDots';

export default function WelcomePage() {
    const router = useRouter();
    const [checking, setChecking] = useState(true);

    useEffect(() => {
        setOnboardingStep('welcome');

        const checkStatus = async () => {
            if (!isTauriApp()) {
                router.replace('/');
                return;
            }

            try {
                const onboardingComplete = localStorage.getItem('desktop_onboarding_complete');
                const { data: { session } } = await supabase.auth.getSession();

                if (onboardingComplete === 'true' && session) {
                    router.replace('/app');
                    return;
                }
            } catch {
                // Continue to onboarding
            }

            setChecking(false);
        };

        checkStatus();
    }, [router]);

    const handleNext = () => {
        router.push('/desktop/features');
    };

    const handleSkip = () => {
        skipOnboarding();
        router.replace('/auth/login');
    };

    if (checking) {
        return (
            <div className="fixed inset-0 flex items-center justify-center bg-[var(--background)]">
                <div className="w-10 h-10 border-3 border-[var(--color-border)] border-t-brand rounded-full animate-spin" />
            </div>
        );
    }

    return (
        <div className="fixed inset-0 flex flex-col items-center justify-center p-8 bg-[var(--background)]">
            <motion.div
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.4 }}
                className="max-w-xl w-full text-center"
            >
                <motion.div
                    initial={{ scale: 0.9, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    transition={{ delay: 0.1 }}
                    className="mx-auto mb-10 w-20 h-20 bg-brand rounded-2xl flex items-center justify-center"
                >
                    <Sparkles className="w-10 h-10 text-white" />
                </motion.div>

                <motion.h1
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.15 }}
                    className="text-4xl font-bold text-[var(--foreground)] mb-4 tracking-tight"
                >
                    Bem-vindo ao Flashcards Generator
                </motion.h1>

                <motion.p
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.2 }}
                    className="text-lg text-[var(--color-text-secondary)] mb-4 leading-relaxed"
                >
                    Obrigado por baixar o aplicativo desktop.
                </motion.p>

                <motion.p
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.25 }}
                    className="text-base text-[var(--color-text-secondary)] mb-12 leading-relaxed max-w-md mx-auto"
                >
                    Transforme qualquer texto em flashcards de alta qualidade em segundos.
                </motion.p>

                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.3 }}
                    className="mb-8"
                >
                    <OnboardingProgressDots currentStep={0} />
                </motion.div>

                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.35 }}
                    className="flex flex-col items-center gap-3"
                >
                    <button
                        onClick={handleNext}
                        className="inline-flex items-center gap-2.5 px-8 py-3.5 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 transition-colors"
                    >
                        <span>Começar</span>
                        <ArrowRight className="w-5 h-5" />
                    </button>
                    <button
                        onClick={handleSkip}
                        className="text-sm text-[var(--color-text-secondary)] hover:text-[var(--foreground)] transition-colors"
                    >
                        Pular introdução
                    </button>
                </motion.div>
            </motion.div>
        </div>
    );
}
