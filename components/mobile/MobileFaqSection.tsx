'use client';

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown, MessageSquare } from 'lucide-react';
import { trackEvent } from '@/lib/analytics';

export default function MobileFaqSection() {
    const faqs = [
        { q: "O plano grátis é limitado?", a: "Você tem 3 gerações por dia, com limite de 2.000 caracteres. Ideal para testar." },
        { q: "Precisa de cartão?", a: "Não. O plano gratuito não pede cartão de crédito." },
        { q: "Exporta para Anki?", a: "Sim! Geramos um arquivo .apkg que você abre direto no Anki." },
        { q: "Funciona com PDF?", a: "O upload de arquivos PDF está disponível no plano Ultimate." },
        { q: "Posso cancelar?", a: "Sim, a qualquer momento pelo próprio app." }
    ];

    return (
        <section className="py-12 px-6 pb-24">
            <div className="mb-8 text-center">
                <span className="text-[10px] font-black uppercase tracking-widest text-brand mb-2 block">
                    FAQ
                </span>
                <h2 className="text-2xl font-bold text-foreground">
                    Dúvidas?
                </h2>
            </div>

            <div className="space-y-3">
                {faqs.map((faq, index) => (
                    <FaqItem key={index} question={faq.q} answer={faq.a} />
                ))}
            </div>

            <div className="mt-8 text-center">
                <a
                    href="mailto:suporte@flashcardsgenerator.com"
                    className="inline-flex items-center gap-2 text-sm font-bold text-brand hover:underline"
                    onClick={() => trackEvent('support_contact_clicked', { source: 'mobile_faq' })}
                >
                    <MessageSquare className="w-4 h-4" />
                    Falar com suporte
                </a>
            </div>
        </section>
    );
}

function FaqItem({ question, answer }: { question: string; answer: string }) {
    const [isOpen, setIsOpen] = useState(false);

    return (
        <div className="border border-border rounded-xl overflow-hidden bg-white">
            <button
                onClick={() => setIsOpen(!isOpen)}
                className="w-full flex items-center justify-between p-4 text-left active:bg-gray-50 transition-colors"
                aria-expanded={isOpen}
            >
                <span className="font-bold text-sm text-foreground">{question}</span>
                <ChevronDown
                    className={`w-5 h-5 text-foreground/40 transition-transform ${isOpen ? 'rotate-180' : ''}`}
                />
            </button>
            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: 'auto', opacity: 1 }}
                        exit={{ height: 0, opacity: 0 }}
                        className="overflow-hidden"
                    >
                        <div className="p-4 pt-0 text-sm text-foreground/70 font-medium leading-relaxed">
                            {answer}
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
