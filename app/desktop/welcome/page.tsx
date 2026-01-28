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
        // Simple check to ensure we are in Tauri, but don't auto-redirect if already onboarded
        // We want to SHOW this page if the user was routed here.
        if (!isTauriApp()) {
            router.replace('/');
            return;
        }
        setChecking(false);
    }, [router]);

    const handleContinue = () => {
        // Mark onboarding as done
        if (typeof window !== 'undefined') {
            localStorage.setItem('desktop_onboarding_complete', 'true');
        }
        // Redirect strictly to login as requested
        router.push('/auth/login');
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
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.5 }}
                className="max-w-2xl w-full flex flex-col items-center text-center"
            >
                {/* Logo & Icon */}
                <div className="mb-8 relative">
                    <div className="absolute inset-0 bg-brand/20 blur-xl rounded-full" />
                    <div className="relative w-24 h-24 bg-gradient-to-br from-brand to-orange-600 rounded-2xl flex items-center justify-center shadow-2xl">
                        <Sparkles className="w-12 h-12 text-white" />
                    </div>
                </div>

                <h1 className="text-4xl font-black text-[var(--foreground)] mb-4 tracking-tight">
                    Flashcards Generator
                </h1>

                <p className="text-xl text-[var(--color-text-secondary)] mb-10 max-w-lg leading-relaxed">
                    A maneira mais rápida de criar material de estudo.
                    <br />
                    <span className="text-brand font-medium">Agora no seu Desktop.</span>
                </p>

                {/* Features Grid */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12 w-full text-left">
                    <div className="bg-[var(--card-bg)] border border-[var(--color-border)] p-5 rounded-xl">
                        <div className="w-10 h-10 bg-blue-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg className="w-6 h-6 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                        </div>
                        <h3 className="font-bold text-[var(--foreground)] mb-1">Super Rápido</h3>
                        <p className="text-sm text-[var(--color-text-secondary)]">Gere decks inteiros em segundos com IA avançada.</p>
                    </div>

                    <div className="bg-[var(--card-bg)] border border-[var(--color-border)] p-5 rounded-xl">
                        <div className="w-10 h-10 bg-emerald-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg className="w-6 h-6 text-emerald-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                        <h3 className="font-bold text-[var(--foreground)] mb-1">Funciona Offline</h3>
                        <p className="text-sm text-[var(--color-text-secondary)]">Estude seus cards mesmo sem internet.</p>
                    </div>

                    <div className="bg-[var(--card-bg)] border border-[var(--color-border)] p-5 rounded-xl">
                        <div className="w-10 h-10 bg-purple-500/10 rounded-lg flex items-center justify-center mb-4">
                            <svg className="w-6 h-6 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                            </svg>
                        </div>
                        <h3 className="font-bold text-[var(--foreground)] mb-1">Sincronizado</h3>
                        <p className="text-sm text-[var(--color-text-secondary)]">Seus decks salvos na nuvem e acessíveis em qualquer lugar.</p>
                    </div>
                </div>

                <button
                    onClick={handleContinue}
                    className="group relative inline-flex items-center justify-center px-8 py-4 bg-brand text-white font-bold text-lg rounded-xl hover:bg-brand/90 transition-all transform hover:scale-[1.02] shadow-lg shadow-brand/25 w-full md:w-auto min-w-[200px]"
                >
                    <span>Começar agora</span>
                    <ArrowRight className="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform" />
                </button>

                <p className="mt-4 text-xs text-[var(--color-text-secondary)] uppercase tracking-wider font-semibold">
                    Versão Desktop v1.0.3
                </p>
            </motion.div>
        </div>
    );
}
