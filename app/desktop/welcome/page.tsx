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
                    initial={{ scale: 0.95, opacity: 0 }}
                    animate={{ scale: 1, opacity: 1 }}
                    transition={{ delay: 0.1 }}
                    className="mx-auto mb-8 w-16 h-16 bg-brand rounded-xl flex items-center justify-center"
                >
                    <Sparkles className="w-8 h-8 text-white" />
                </motion.div>

                <motion.h1
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.15 }}
                    className="text-3xl font-bold text-[var(--foreground)] mb-3 tracking-tight"
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
                    className="text-base text-[var(--color-text-secondary)] mb-8 leading-relaxed max-w-md mx-auto"
                >
                    Transforme qualquer texto em flashcards de alta qualidade em segundos.
                </motion.p>

                <motion.div
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.3 }}
                    className="mb-6"
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
                        className="inline-flex items-center gap-2.5 px-8 py-3 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 focus:ring-2 focus:ring-brand focus:ring-offset-2 transition-colors"
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
