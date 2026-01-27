'use client';

import React from 'react';
import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { ArrowLeft, ArrowRight, FileText, Scale, AlertTriangle, CreditCard, CheckCircle2 } from 'lucide-react';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

export default function TermsPage() {
    const sections = [
        {
            icon: CheckCircle2,
            title: "1. Aceitação dos Termos",
            content: "Ao acessar ao site Flashcards Generator, você concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis ​​e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum destes termos, está proibido de usar ou acessar este site."
        },
        {
            icon: Scale,
            title: "2. Uso de Licença",
            content: "É concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no site Flashcards Generator, apenas para visualização transitória pessoal e não comercial.",
            list: [
                "Modificar ou copiar os materiais;",
                "Usar os materiais para qualquer finalidade comercial ou para exibição pública;",
                "Tentar descompilar ou fazer engenharia reversa de qualquer software contido no site;",
                "Remover quaisquer direitos autorais ou outras notações de propriedade dos materiais."
            ]
        },
        {
            icon: AlertTriangle,
            title: "3. Isenção de Responsabilidade",
            content: "Os materiais no site da Flashcards Generator são fornecidos \"como estão\". Flashcards Generator não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual."
        },
        {
            icon: FileText,
            title: "4. Limitações",
            content: "Em nenhum caso o Flashcards Generator ou seus fornecedores serão responsáveis ​​por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Flashcards Generator."
        },
        {
            icon: CreditCard,
            title: "5. Assinaturas e Pagamentos",
            content: "Oferecemos planos gratuitos e pagos (Pro e Ultimate). Os pagamentos são processados pelo Stripe. Ao assinar um plano pago, você concorda com as taxas e ciclos de faturamento especificados no momento da compra. Pedidos de reembolso serão analisados individualmente."
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
                            <FileText className="h-6 w-6" />
                        </div>
                        <div>
                            <SectionLabel text="TERMOS DE USO" />
                            <h1 className="text-4xl font-bold tracking-tight">Termos de Uso</h1>
                        </div>
                    </m.div>

                    <div className="space-y-8">
                        {sections.map((section, index) => (
                            <m.section
                                key={section.title}
                                initial={{ opacity: 0, x: -20 }}
                                animate={{ opacity: 1, x: 0 }}
                                transition={{ delay: 0.2 + index * 0.1 }}
                                className="p-4 rounded-sm hover:bg-gray-50 transition-colors"
                            >
                                <div className="flex gap-4 mb-3">
                                    <div className="flex-shrink-0 w-10 h-10 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm">
                                        <section.icon className="h-5 w-5 text-brand" />
                                    </div>
                                    <h2 className="text-xl font-bold text-foreground pt-1.5">{section.title}</h2>
                                </div>
                                <div className="pl-14">
                                    <p className="text-foreground/70 font-medium leading-relaxed">{section.content}</p>
                                    {section.list && (
                                        <ul className="list-disc pl-5 mt-3 space-y-1 text-foreground/60 font-medium">
                                            {section.list.map((item, i) => (
                                                <li key={i}>{item}</li>
                                            ))}
                                        </ul>
                                    )}
                                </div>
                            </m.section>
                        ))}
                    </div>

                    <m.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.8 }}
                        className="pt-8 border-t border-border mt-12"
                    >
                        <div className="text-foreground/40 text-xs text-center font-mono uppercase tracking-widest mb-6">
                            Última atualização: 23 de Janeiro de 2026
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
