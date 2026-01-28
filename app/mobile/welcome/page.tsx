'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import { useRouter } from 'next/navigation';
import { Sparkles, ArrowRight } from 'lucide-react';
import { isTauriApp } from '@/lib/tauri';

export default function MobileWelcomePage() {
    const router = useRouter();
    const [checking, setChecking] = useState(true);

    useEffect(() => {
        if (!isTauriApp()) {
            router.replace('/');
            return;
        }
        setChecking(false);
    }, [router]);

    const handleContinue = () => {
        if (typeof window !== 'undefined') {
            localStorage.setItem('mobile_onboarding_complete', 'true');
        }
        router.push('/mobile/login');
    };

    if (checking) {
        return (
            <div className="fixed inset-0 flex items-center justify-center bg-[var(--background)]">
                <div className="w-10 h-10 border-3 border-[var(--color-border)] border-t-brand rounded-full animate-spin" />
            </div>
        );
    }

    return (
        <div className="fixed inset-0 flex flex-col items-center justify-center p-6 bg-[var(--background)] safe-area-inset">
            <motion.div
                initial={{ opacity: 0, scale: 0.95 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.5 }}
                className="max-w-md w-full flex flex-col items-center text-center"
            >
                {/* Logo - use packaged app icon for a consistent brand */}
                <div className="mb-8 relative">
                    <div className="absolute inset-0 bg-brand/20 blur-xl rounded-full" />
                    <div className="relative w-20 h-20 bg-gradient-to-br from-brand to-orange-600 rounded-2xl flex items-center justify-center shadow-2xl overflow-hidden">
                        {/* Use the app icon from /public/icons for a more authentic visual */}
                        <img src="/icons/icon-192x192.png" alt="Flashcards Generator" width={64} height={64} className="w-12 h-12 object-contain" />
                    </div>
                </div>

                <h1 className="text-3xl font-black text-[var(--foreground)] mb-3 tracking-tight">
                    Flashcards Generator
                </h1>

                <p className="text-lg text-[var(--color-text-secondary)] mb-10 max-w-sm leading-relaxed">
                    A maneira mais rápida de criar material de estudo.
                    <br />
                    <span className="text-brand font-medium">Agora no seu celular.</span>
                </p>

                {/* Features */}
                <div className="flex flex-col gap-4 mb-10 w-full text-left">
                    <div className="flex items-center gap-4 bg-[var(--card-bg)] border border-[var(--color-border)] p-4 rounded-xl">
                        <div className="w-10 h-10 bg-blue-500/10 rounded-lg flex items-center justify-center shrink-0">
                            <svg className="w-5 h-5 text-blue-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" />
                            </svg>
                        </div>
                        <div>
                            <h3 className="font-bold text-[var(--foreground)] text-sm">Super Rápido</h3>
                            <p className="text-xs text-[var(--color-text-secondary)]">Gere decks inteiros em segundos com IA.</p>
                        </div>
                    </div>

                    <div className="flex items-center gap-4 bg-[var(--card-bg)] border border-[var(--color-border)] p-4 rounded-xl">
                        <div className="w-10 h-10 bg-emerald-500/10 rounded-lg flex items-center justify-center shrink-0">
                            <svg className="w-5 h-5 text-emerald-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                        <div>
                            <h3 className="font-bold text-[var(--foreground)] text-sm">Funciona Offline</h3>
                            <p className="text-xs text-[var(--color-text-secondary)]">Estude seus cards mesmo sem internet.</p>
                        </div>
                    </div>

                    <div className="flex items-center gap-4 bg-[var(--card-bg)] border border-[var(--color-border)] p-4 rounded-xl">
                        <div className="w-10 h-10 bg-purple-500/10 rounded-lg flex items-center justify-center shrink-0">
                            <svg className="w-5 h-5 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                            </svg>
                        </div>
                        <div>
                            <h3 className="font-bold text-[var(--foreground)] text-sm">Sincronizado</h3>
                            <p className="text-xs text-[var(--color-text-secondary)]">Seus decks na nuvem, acessíveis em qualquer lugar.</p>
                        </div>
                    </div>
                </div>

                <button
                    onClick={handleContinue}
                    className="group relative inline-flex items-center justify-center px-8 py-4 bg-brand text-white font-bold text-lg rounded-xl hover:bg-brand/90 transition-all active:scale-[0.98] shadow-lg shadow-brand/25 w-full"
                >
                    <span>Começar agora</span>
                    <ArrowRight className="ml-2 w-5 h-5 group-hover:translate-x-1 transition-transform" />
                </button>

                <p className="mt-4 text-xs text-[var(--color-text-secondary)] uppercase tracking-wider font-semibold">
                    Versão Mobile v1.0.0
                </p>
            </motion.div>
        </div>
    );
}
