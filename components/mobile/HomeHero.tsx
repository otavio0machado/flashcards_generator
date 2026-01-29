'use client';

import Link from 'next/link';
import { motion } from 'framer-motion';
import { ArrowRight } from 'lucide-react';
import { trackEvent } from '@/lib/analytics';
import { ANIMATION } from '@/lib/animation-config';

export default function HomeHero() {
    const handleCtaClick = () => {
        trackEvent('cta_generate_clicked', { location: 'mobile_hero' });
    };

    return (
        <section className="relative px-6 pt-12 pb-16 overflow-hidden">
            {/* Background blobs */}
            <div className="absolute top-0 right-0 w-64 h-64 bg-brand/10 rounded-full blur-3xl -z-10 translate-x-1/2 -translate-y-1/2" />
            <div className="absolute bottom-0 left-0 w-64 h-64 bg-blue-500/5 rounded-full blur-3xl -z-10 -translate-x-1/2 translate-y-1/2" />

            <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6 }}
                className="text-center"
            >
                <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-brand/5 border border-brand/10 mb-6">
                    <span className="relative flex h-2 w-2">
                        <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-brand opacity-75"></span>
                        <span className="relative inline-flex rounded-full h-2 w-2 bg-brand"></span>
                    </span>
                    <span className="text-[10px] font-black uppercase tracking-widest text-brand">
                        Flashcards Generator
                    </span>
                </div>

                <h1 className="text-[40px] leading-[1.1] font-black text-foreground tracking-tight mb-4">
                    Aprenda mais focando no que <span className="text-brand">importa</span>.
                </h1>

                <p className="text-lg text-foreground/60 font-medium mb-8 leading-relaxed">
                    Cole seu resumo e deixe a IA criar seus flashcards do Anki automaticamente.
                </p>

                <div className="flex flex-col gap-3">
                    <Link
                        href="/app/generate"
                        onClick={handleCtaClick}
                        className="w-full bg-brand text-white h-[52px] rounded-xl text-[17px] font-bold flex items-center justify-center gap-2 active:scale-95 transition-transform shadow-lg shadow-brand/20"
                    >
                        Testar grátis agora
                        <ArrowRight className="h-5 w-5 opacity-80" />
                    </Link>

                    <Link
                        href="#how-it-works"
                        className="w-full bg-secondary-system-background text-label h-[52px] rounded-xl text-[17px] font-bold flex items-center justify-center active:scale-95 transition-transform"
                    >
                        Como funciona
                    </Link>
                </div>
            </motion.div>
        </section>
    );
}
