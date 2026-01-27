'use client';

import React from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { ArrowLeft, ArrowRight, Shield, Database, Trash2, CreditCard, Bot } from 'lucide-react';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

export default function PrivacyPage() {
    const sections = [
        {
            icon: Database,
            title: "O texto é armazenado?",
            content: "Não armazenamos o texto bruto do demo. Para usuários com conta, o texto e os cards podem ser salvos na sua biblioteca quando você escolhe salvar."
        },
        {
            icon: Shield,
            title: "Por quanto tempo?",
            content: "Cards salvos ficam na sua conta até você excluir. Logs técnicos e métricas são mantidos apenas pelo tempo necessário para operação e melhoria do serviço."
        },
        {
            icon: Bot,
            title: "Usa IA? Como?",
            content: "Sim. O conteúdo é processado por IA para gerar perguntas e respostas. Não treinamos modelos com o seu conteúdo."
        },
        {
            icon: Trash2,
            title: "Como deletar dados?",
            content: "Você pode excluir decks na área de biblioteca. Para remoções completas, entre em contato via suporte."
        },
        {
            icon: CreditCard,
            title: "Pagamentos",
            content: "Pagamentos são processados pelo Stripe. Não armazenamos dados do cartão."
        }
    ];

    return (
        <LazyMotion features={domAnimation}>
            <div className="min-h-screen bg-gray-50/50 py-24 px-4">
                <m.div
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    className="max-w-3xl mx-auto bg-white border border-border rounded-sm p-8 md:p-12 shadow-sm"
                >
                    <Link
                        href="/"
                        className="group inline-flex items-center gap-2 text-sm font-bold text-brand hover:gap-3 transition-all mb-10"
                    >
                        <ArrowLeft className="h-4 w-4" /> Voltar para o Início
                    </Link>

                    <m.div
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.1 }}
                        className="flex items-center gap-4 mb-8"
                    >
                        <div className="w-12 h-12 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm text-brand">
                            <Shield className="h-6 w-6" />
                        </div>
                        <div>
                            <SectionLabel text="PRIVACIDADE" />
                            <h1 className="text-4xl font-bold tracking-tight">Política de Privacidade</h1>
                        </div>
                    </m.div>

                    <div className="space-y-6">
                        {sections.map((section, index) => (
                            <m.section
                                key={section.title}
                                initial={{ opacity: 0, x: -20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.2 + index * 0.1 }}
                                className="flex gap-4 p-4 rounded-sm hover:bg-gray-50 transition-colors"
                            >
                                <div className="flex-shrink-0 w-10 h-10 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm">
                                    <section.icon className="h-5 w-5 text-brand" />
                                </div>
                                <div>
                                    <h2 className="text-xl font-bold text-foreground mb-2">{section.title}</h2>
                                    <p className="text-foreground/70 font-medium leading-relaxed">{section.content}</p>
                                </div>
                            </m.section>
                        ))}
                    </div>

                    <m.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.8 }}
                        className="pt-8 border-t border-border mt-8"
                    >
                        <div className="text-foreground/40 text-xs text-center font-mono uppercase tracking-widest mb-6">
                            Última atualização: 25 de Janeiro de 2026
                        </div>
                        <div className="text-center">
                            <Link
                                href="/app"
                                className="group inline-flex items-center gap-2 bg-brand text-white px-6 py-3 rounded-sm font-bold hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
                            >
                                Ir para o App
                                <ArrowRight className="h-4 w-4 cta-arrow-shift" />
                            </Link>
                        </div>
                    </m.div>
                </m.div>
            </div>
        </LazyMotion>
    );
}
