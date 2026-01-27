'use client';

import Link from 'next/link';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { trackEvent } from '@/lib/analytics';
import {
    ArrowLeft,
    ArrowRight,
    Monitor,
    Smartphone,
    Zap,
    Info,
    ChevronRight,
    Import,
    Check
} from 'lucide-react';

function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">
            {text}
        </p>
    );
}

export default function GuiaPage() {
    const handleSectionView = (section: string) => {
        trackEvent('guide_section_viewed', { section });
    };

    return (
        <LazyMotion features={domAnimation}>
            <div className="min-h-screen pb-24">
                {/* Article Header */}
                <header className="bg-white border-b border-border py-24 mb-16">
                    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                        >
                            <Link href="/" className="group inline-flex items-center gap-2 text-brand font-bold text-sm mb-8 hover:gap-3 transition-all">
                                <ArrowLeft className="h-4 w-4" />
                                Voltar para o Início
                            </Link>
                            <SectionLabel text="GUIA DE IMPORTAÇÃO" />
                            <h1 className="text-4xl md:text-6xl font-bold tracking-tight text-foreground mb-6 leading-tight">
                                Como Importar seus <br className="hidden md:block" /> Decks no <span className="text-brand">Anki</span> e Quizlet
                            </h1>
                            <p className="text-xl text-foreground/60 font-medium leading-relaxed max-w-2xl">
                                Siga este guia visual para transferir os cards gerados por nossa IA para sua ferramenta de estudo favorita em menos de 2 minutos.
                            </p>
                        </m.div>
                    </div>
                </header>

                <article className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
                    {/* Quick Nav */}
                    <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-16">
                        {[
                            { href: '#anki-desktop', label: 'Anki Desktop' },
                            { href: '#anki-mobile', label: 'AnkiDroid/iOS' },
                            { href: '#quizlet', label: 'Quizlet' },
                        ].map((item, index) => (
                            <m.a
                                key={item.href}
                                href={item.href}
                                onClick={() => handleSectionView(item.label)}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.2 + index * 0.1 }}
                                whileHover={{ y: -3 }}
                                className="p-4 bg-white border border-border rounded-sm hover:border-brand transition-all flex items-center justify-between group"
                            >
                                <span className="font-bold text-sm">{item.label}</span>
                                <ChevronRight className="h-4 w-4 text-foreground/20 group-hover:text-brand transition-colors" />
                            </m.a>
                        ))}
                    </div>

                    {/* Section: Anki Desktop */}
                    <m.section
                        id="anki-desktop"
                        initial={{ opacity: 0 }}
                        whileInView={{ opacity: 1 }}
                        viewport={{ once: true }}
                        className="mb-24 scroll-mt-24"
                    >
                        <div className="flex items-center gap-3 mb-8">
                            <div className="bg-brand/10 p-2 rounded-sm text-brand">
                                <Monitor className="h-6 w-6" />
                            </div>
                            <div>
                                <SectionLabel text="DESKTOP" />
                                <h2 className="text-3xl font-bold tracking-tight">Anki Desktop</h2>
                            </div>
                        </div>

                        <div className="space-y-12">
                            <div className="flex flex-col md:flex-row gap-8 items-start">
                                <div className="flex-1 space-y-4">
                                    {[
                                        { step: 1, text: 'No gerador do Flashcards Generator, clique em', highlight: '"Exportar Anki (.txt)"' },
                                        { step: 2, text: 'Abra o Anki no seu computador e clique no botão', highlight: 'Importar Arquivo', isButton: true },
                                    ].map((item, index) => (
                                        <m.div
                                            key={item.step}
                                            initial={{ opacity: 0, x: -20 }}
                                            whileInView={{ opacity: 1, x: 0 }}
                                            viewport={{ once: true }}
                                            transition={{ delay: index * 0.15 }}
                                            className="flex gap-4"
                                        >
                                            <span className="bg-brand text-white w-6 h-6 rounded-full flex items-center justify-center shrink-0 text-xs font-bold">{item.step}</span>
                                            <p className="font-medium text-foreground/70">
                                                {item.text}{' '}
                                                {item.isButton ? (
                                                    <span className="bg-gray-100 px-2 py-0.5 border border-border rounded text-xs font-bold">{item.highlight}</span>
                                                ) : (
                                                    <span className="text-brand font-bold">{item.highlight}</span>
                                                )}
                                                {item.step === 2 && ' na parte inferior.'}
                                            </p>
                                        </m.div>
                                    ))}
                                </div>

                                {/* Simulated UI: Anki Button */}
                                <m.div
                                    initial={{ opacity: 0, scale: 0.95 }}
                                    whileInView={{ opacity: 1, scale: 1 }}
                                    viewport={{ once: true }}
                                    className="w-full md:w-72 bg-white border border-border p-6 rounded-sm shadow-sm relative overflow-hidden group"
                                >
                                    <div className="flex gap-1 mb-4">
                                        <div className="w-2 h-2 rounded-full bg-red-400"></div>
                                        <div className="w-2 h-2 rounded-full bg-yellow-400"></div>
                                        <div className="w-2 h-2 rounded-full bg-green-400"></div>
                                    </div>
                                    <div className="h-20 bg-gray-50 flex items-center justify-center border border-dashed border-border mb-4">
                                        <span className="text-[10px] uppercase font-bold text-foreground/20">Seus Decks Aqui</span>
                                    </div>
                                    <div className="flex justify-center border-t border-border pt-4">
                                        <div className="bg-blue-50 border border-blue-200 px-3 py-1.5 rounded-sm flex items-center gap-2 scale-110 shadow-lg ring-4 ring-blue-500/10">
                                            <Import className="h-3 w-3 text-blue-600" />
                                            <span className="text-[10px] font-bold text-blue-600">Importar Arquivo</span>
                                        </div>
                                    </div>
                                </m.div>
                            </div>

                            <m.div
                                initial={{ opacity: 0, y: 10 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                className="bg-brand/5 border-l-4 border-brand p-6"
                            >
                                <div className="flex gap-3">
                                    <Info className="h-5 w-5 text-brand shrink-0" />
                                    <div>
                                        <h4 className="font-bold text-brand mb-1">Dica de Configuração</h4>
                                        <p className="text-sm font-medium text-brand/80 leading-relaxed">
                                            Ao importar, certifique-se de que a opção &quot;Campos separados por:&quot; esteja definida como <span className="font-bold underline">Tabulação</span>. Nossa IA já formata o arquivo dessa maneira para garantir que a frente e o verso fiquem corretos.
                                        </p>
                                    </div>
                                </div>
                            </m.div>
                        </div>
                    </m.section>

                    {/* Section: Anki Mobile */}
                    <m.section
                        id="anki-mobile"
                        initial={{ opacity: 0 }}
                        whileInView={{ opacity: 1 }}
                        viewport={{ once: true }}
                        className="mb-24 scroll-mt-24"
                    >
                        <div className="flex items-center gap-3 mb-8">
                            <div className="bg-brand/10 p-2 rounded-sm text-brand">
                                <Smartphone className="h-6 w-6" />
                            </div>
                            <div>
                                <SectionLabel text="MOBILE" />
                                <h2 className="text-3xl font-bold tracking-tight">AnkiDroid / iOS</h2>
                            </div>
                        </div>

                        <p className="text-lg text-foreground/60 font-medium mb-8">
                            A forma mais fácil de levar seus cards para o celular é através da sincronização do <span className="text-foreground font-bold underline">AnkiWeb</span>.
                        </p>

                        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                            {[
                                { step: 1, text: 'Após importar no Desktop, clique no botão Sincronizar (ou no ícone de nuvem) no topo da tela do Anki.' },
                                { step: 2, text: 'No seu celular, abra o app e clique em Sincronizar. Faça login com a mesma conta e pronto!' },
                            ].map((item, index) => (
                                <m.div
                                    key={item.step}
                                    initial={{ opacity: 0, y: 20 }}
                                    whileInView={{ opacity: 1, y: 0 }}
                                    viewport={{ once: true }}
                                    transition={{ delay: index * 0.15 }}
                                    whileHover={{ y: -3 }}
                                    className="bg-white border border-border p-8 rounded-sm"
                                >
                                    <h3 className="font-bold mb-4 flex items-center gap-2">
                                        <Check className="h-4 w-4 text-green-500" /> Passo {item.step}
                                    </h3>
                                    <p className="text-sm font-medium text-foreground/60 leading-relaxed">
                                        {item.text.split('Sincronizar').map((part, i) => 
                                            i === 0 ? <span key={i}>{part}</span> : <span key={i}><span className="font-bold text-brand">Sincronizar</span>{part}</span>
                                        )}
                                    </p>
                                </m.div>
                            ))}
                        </div>
                    </m.section>

                    {/* Section: Quizlet */}
                    <m.section
                        id="quizlet"
                        initial={{ opacity: 0 }}
                        whileInView={{ opacity: 1 }}
                        viewport={{ once: true }}
                        className="mb-24 scroll-mt-24"
                    >
                        <div className="flex items-center gap-3 mb-8">
                            <div className="bg-brand/10 p-2 rounded-sm text-brand">
                                <Zap className="h-6 w-6" />
                            </div>
                            <div>
                                <SectionLabel text="ALTERNATIVA" />
                                <h2 className="text-3xl font-bold tracking-tight">Quizlet</h2>
                            </div>
                        </div>

                        <div className="space-y-6">
                            <p className="text-lg text-foreground/60 font-medium">
                                O Quizlet permite criar listas instantaneamente usando a função de importação rápida.
                            </p>

                            <ol className="space-y-4">
                                {[
                                    { step: 1, text: 'Crie uma nova "Lista de Estudos" no Quizlet.' },
                                    { step: 2, text: 'Clique em + Importar (geralmente abaixo do campo de título).', highlight: '+ Importar' },
                                    { step: 3, text: 'Copie os cards do nosso preview e cole na caixa de texto do Quizlet.' },
                                ].map((item, index) => (
                                    <m.li
                                        key={item.step}
                                        initial={{ opacity: 0, x: -20 }}
                                        whileInView={{ opacity: 1, x: 0 }}
                                        viewport={{ once: true }}
                                        transition={{ delay: index * 0.1 }}
                                        className="flex items-start gap-4 p-4 hover:bg-white rounded-sm transition-colors group"
                                    >
                                        <div className="bg-gray-100 group-hover:bg-brand/10 w-8 h-8 rounded-sm flex items-center justify-center shrink-0 font-bold text-xs transition-colors group-hover:text-brand">{item.step}</div>
                                        <div>
                                            <p className="font-bold">
                                                {item.highlight ? (
                                                    <>
                                                        {item.text.split(item.highlight)[0]}
                                                        <span className="text-brand">{item.highlight}</span>
                                                        {item.text.split(item.highlight)[1]}
                                                    </>
                                                ) : item.text}
                                            </p>
                                        </div>
                                    </m.li>
                                ))}
                            </ol>
                        </div>
                    </m.section>

                    {/* Closing CTA */}
                    <m.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        className="border-t border-border pt-16 text-center"
                    >
                        <h2 className="text-3xl font-bold mb-6">Pronto para começar?</h2>
                        <Link
                            href="/app"
                            onClick={() => trackEvent('cta_generate_clicked', { location: 'guide' })}
                            className="group inline-flex bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg items-center gap-2"
                        >
                            Criar meu primeiro deck agora
                            <ArrowRight className="h-5 w-5 cta-arrow-shift" />
                        </Link>
                    </m.div>
                </article>

                {/* Structured Data for Google (Schema.js) */}
                <script
                    type="application/ld+json"
                    dangerouslySetInnerHTML={{
                        __html: JSON.stringify({
                            "@context": "https://schema.org",
                            "@type": "HowTo",
                            "name": "Como importar flashcards no Anki",
                            "step": [
                                {
                                    "@type": "HowToStep",
                                    "text": "Exportar deck formatado do Flashcards Generator"
                                },
                                {
                                    "@type": "HowToStep",
                                    "text": "Usar a função Importar no Anki Desktop"
                                },
                                {
                                    "@type": "HowToStep",
                                    "text": "Sincronizar com AnkiWeb para usar no mobile"
                                }
                            ]
                        }),
                    }}
                />
            </div>
        </LazyMotion>
    );
}
