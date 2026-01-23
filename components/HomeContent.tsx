"use client";

import Link from 'next/link';
import { motion } from 'framer-motion';
import Image from 'next/image';
import { STRIPE_PRICES } from '@/constants/config';
import CheckoutButton from '@/components/CheckoutButton';
import {
    ArrowRight,
    FileText,
    Cpu,
    Download,
    CheckCircle2,
    Zap,
    Globe,
    Plus,
    Check
} from 'lucide-react';

export default function HomeContent() {
    return (
        <div className="flex flex-col min-h-screen">
            {/* Hero Section */}
            <section className="relative pt-20 pb-32 overflow-hidden">
                {/* Animated Background Elements */}
                <motion.div
                    animate={{
                        scale: [1, 1.2, 1],
                        rotate: [0, 90, 0],
                        opacity: [0.1, 0.2, 0.1]
                    }}
                    transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                    className="absolute -top-24 -left-24 w-96 h-96 bg-brand/20 rounded-full blur-3xl -z-10"
                />
                <motion.div
                    animate={{
                        scale: [1, 1.5, 1],
                        rotate: [0, -45, 0],
                        opacity: [0.1, 0.3, 0.1]
                    }}
                    transition={{ duration: 25, repeat: Infinity, ease: "linear" }}
                    className="absolute top-1/2 -right-24 w-[500px] h-[500px] bg-brand/10 rounded-full blur-3xl -z-10"
                />

                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                    <div className="text-center">
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.8, ease: "easeOut" }}
                        >
                            <h1 className="text-5xl md:text-7xl font-bold tracking-tight text-foreground mb-6 leading-tight">
                                Gere Flashcards para <span className="text-brand">Anki</span> e Quizlet <br className="hidden md:block" /> em Segundos com IA
                            </h1>
                        </motion.div>

                        <motion.p
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.8, delay: 0.2, ease: "easeOut" }}
                            className="text-xl text-foreground/70 max-w-3xl mx-auto mb-10 leading-relaxed font-medium"
                        >
                            Pare de perder horas resumindo. Cole seu texto e deixe nossa Inteligência Artificial criar as perguntas e respostas perfeitas para sua memorização.
                        </motion.p>

                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.8, delay: 0.4, ease: "easeOut" }}
                            className="flex flex-col sm:flex-row gap-4 justify-center items-center"
                        >
                            <Link
                                href="/app"
                                className="group bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg hover:shadow-brand/40 flex items-center gap-2 transform hover:-translate-y-1"
                            >
                                Começar Agora — É Grátis
                                <ArrowRight className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
                            </Link>
                            <Link
                                href="/guia"
                                className="bg-white border border-border text-foreground px-8 py-4 rounded-sm text-lg font-bold hover:bg-gray-50 transition-all flex items-center gap-2 transform hover:-translate-y-1"
                            >
                                Ver Tutorial
                            </Link>
                        </motion.div>

                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            transition={{ duration: 1, delay: 0.8 }}
                            className="mt-16 relative"
                        >
                            <div className="absolute inset-0 flex items-center" aria-hidden="true">
                                <div className="w-full border-t border-border"></div>
                            </div>
                            <div className="relative flex justify-center uppercase tracking-widest text-[10px] font-bold text-foreground/40">
                                <span className="bg-[#FAFAFA] px-4">Compatível com as principais plataformas</span>
                            </div>
                        </motion.div>
                    </div>
                </div>
            </section>

            {/* Como Funciona Section */}
            <section className="py-24 bg-white border-y border-border">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        className="text-center mb-20"
                    >
                        <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-4">Como Funciona</h2>
                        <p className="text-lg text-foreground/60 font-medium">Três passos para acelerar seu aprendizado.</p>
                    </motion.div>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
                        {[
                            { icon: FileText, title: "1. Cole seu conteúdo", text: "Insira textos, resumos ou documentos PDF diretamente no nosso gerador inteligente." },
                            { icon: Cpu, title: "2. IA Processa Tudo", text: "Nossa IA analisa os pontos-chave e cria pares de Pergunta/Resposta otimizados para SRS." },
                            { icon: Download, title: "3. Exporte e Estude", text: "Baixe seu deck para Anki (.apkg), Quizlet ou use nosso preview para estudar na hora." }
                        ].map((step, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, y: 30 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                transition={{ duration: 0.5, delay: index * 0.2 }}
                                whileHover={{ y: -5 }}
                                className="text-center group"
                            >
                                <div className="w-16 h-16 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-6 group-hover:bg-brand group-hover:text-white transition-all duration-300">
                                    <step.icon className="h-8 w-8 text-brand group-hover:text-white transition-colors" />
                                </div>
                                <h3 className="text-xl font-bold mb-3">{step.title}</h3>
                                <p className="text-foreground/60 leading-relaxed">
                                    {step.text}
                                </p>
                            </motion.div>
                        ))}
                    </div>
                </div>
            </section>

            {/* Benefícios Grid */}
            <section className="py-24">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
                        <div>
                            <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-8">Otimizado para quem busca máxima eficiência</h2>
                            <ul className="space-y-6">
                                <li className="flex gap-4">
                                    <div className="mt-1 flex-shrink-0">
                                        <CheckCircle2 className="h-6 w-6 text-brand" />
                                    </div>
                                    <div>
                                        <h4 className="font-bold text-lg">Compatível com Anki</h4>
                                        <p className="text-foreground/60">Gere arquivos .csv ou .txt prontos para importação no Anki Desktop, AnkiDroid ou AnkiMobile.</p>
                                    </div>
                                </li>
                                <li className="flex gap-4">
                                    <div className="mt-1 flex-shrink-0">
                                        <Zap className="h-6 w-6 text-brand" />
                                    </div>
                                    <div>
                                        <h4 className="font-bold text-lg">Resumos Inteligentes</h4>
                                        <p className="text-foreground/60">Não apenas copia o texto, mas reformula perguntas para garantir que você entenda o conceito.</p>
                                    </div>
                                </li>
                                <li className="flex gap-4">
                                    <div className="mt-1 flex-shrink-0">
                                        <Globe className="h-6 w-6 text-brand" />
                                    </div>
                                    <div>
                                        <h4 className="font-bold text-lg">Exportação Universal</h4>
                                        <p className="text-foreground/60">Funciona perfeitamente com Quizlet, RemNote e outras ferramentas de repetição espaçada.</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div className="relative">
                            <div className="aspect-square bg-white border border-border p-8 rounded-sm shadow-2xl relative overflow-hidden">
                                <div className="absolute top-0 right-0 p-4">
                                    <div className="bg-brand/5 px-3 py-1 rounded-sm text-[10px] font-bold text-brand uppercase tracking-wider border border-brand/10">Preview do Deck</div>
                                </div>
                                <div className="space-y-4 mt-8">
                                    {[1, 2, 3].map((i) => (
                                        <div key={i} className="p-4 bg-gray-50 border border-border rounded-sm">
                                            <div className="text-[10px] font-bold text-foreground/40 uppercase mb-1">Pergunta #{i}</div>
                                            <div className="h-3 w-3/4 bg-gray-200 rounded-full mb-3 animate-pulse"></div>
                                            <div className="text-[10px] font-bold text-foreground/40 uppercase mb-1">Resposta</div>
                                            <div className="h-3 w-1/2 bg-gray-200 rounded-full animate-pulse"></div>
                                        </div>
                                    ))}
                                </div>
                                <div className="absolute bottom-4 right-4 translate-y-12 blur-sm opacity-50 bg-brand/20 w-32 h-32 rounded-full -z-10"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Pricing Section */}
            <section id="pricing" className="py-24 bg-white border-y border-border">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        className="text-center mb-32"
                    >
                        <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-4">Planos e Preços</h2>
                        <p className="text-lg text-foreground/60 font-medium">Escolha o plano ideal para sua rotina de estudos.</p>
                    </motion.div>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-8 items-end pt-10">
                        {/* Free Plan */}
                        <motion.div
                            initial={{ opacity: 0, x: -30 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            whileHover={{ y: -10 }}
                            className="bg-white border border-border p-8 rounded-sm shadow-sm flex flex-col h-full hover:border-foreground/20 transition-all"
                        >
                            <div className="mb-8">
                                <h3 className="text-xl font-bold mb-2">Básico</h3>
                                <div className="flex items-baseline gap-1 mb-4">
                                    <span className="text-4xl font-bold tracking-tighter">Grátis</span>
                                </div>
                                <p className="text-sm font-medium text-foreground/50">Para estudantes ocasionais.</p>
                            </div>
                            <ul className="space-y-4 mb-8 flex-1">
                                <PricingItem text="3 gerações por dia" />
                                <PricingItem text="Até 5 cards por geração" />
                                <PricingItem text="Limite de 2.000 caracteres" />
                                <PricingItem text="Apenas texto (Copy/Paste)" />
                                <PricingItem text="Exportação Anki" />
                            </ul>
                            <Link href="/app" className="w-full py-3 border border-border text-center font-bold text-sm rounded-sm hover:bg-gray-50 transition-all">
                                Começar Grátis
                            </Link>
                        </motion.div>

                        {/* Pro Plan */}
                        <motion.div
                            initial={{ opacity: 0, y: 50 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            whileHover={{ scale: 1.07, y: -5 }}
                            transition={{ type: "spring", stiffness: 300 }}
                            className="bg-white border-2 border-brand p-8 rounded-sm shadow-xl flex flex-col h-[110%] relative z-10 scale-105"
                        >
                            <motion.div
                                animate={{
                                    scale: [1, 1.1, 1],
                                }}
                                transition={{ duration: 2, repeat: Infinity }}
                                className="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-brand text-white text-[10px] font-black uppercase tracking-widest px-4 py-1.5 rounded-full"
                            >
                                Mais Popular
                            </motion.div>
                            <div className="mb-8 pt-4">
                                <h3 className="text-xl font-bold text-brand mb-2">Pro</h3>
                                <div className="flex items-baseline gap-1 mb-4">
                                    <span className="text-sm font-bold text-foreground/40">R$</span>
                                    <span className="text-5xl font-bold tracking-tighter">29</span>
                                    <span className="text-sm font-bold text-foreground/40">/mês</span>
                                </div>
                                <p className="text-sm font-medium text-foreground/50">Para vestibulandos e concurseiros.</p>
                            </div>
                            <ul className="space-y-4 mb-8 flex-1">
                                <PricingItem text="Até 10 gerações por dia" />
                                <PricingItem text="Até 15 cards por geração" />
                                <PricingItem text="Até 20.000 caracteres" />
                                <PricingItem text="Histórico Salvo" />
                                <PricingItem text="IA Otimizada" highlight />
                            </ul>
                            <CheckoutButton
                                priceId={STRIPE_PRICES.pro}
                                planName="pro"
                                className="w-full py-4 bg-brand text-white text-center font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 active:scale-95 transform overflow-hidden relative group"
                            >
                                <span className="relative z-10">Assinar Pro</span>
                                <motion.div
                                    initial={{ x: '-100%' }}
                                    whileHover={{ x: '100%' }}
                                    transition={{ duration: 0.5 }}
                                    className="absolute inset-0 bg-white/20 -skew-x-12"
                                />
                            </CheckoutButton>
                        </motion.div>

                        {/* Ultimate Plan */}
                        <motion.div
                            initial={{ opacity: 0, x: 30 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            whileHover={{ y: -10 }}
                            className="bg-[#1A1A1A] border border-[#333] p-8 rounded-sm shadow-sm flex flex-col h-full text-white"
                        >
                            <div className="mb-8">
                                <h3 className="text-xl font-bold mb-2">Ultimate</h3>
                                <div className="flex items-baseline gap-1 mb-4">
                                    <span className="text-sm font-bold text-white/40">R$</span>
                                    <span className="text-4xl font-bold tracking-tighter italic">59</span>
                                    <span className="text-sm font-bold text-white/40">/mês</span>
                                </div>
                                <p className="text-sm font-medium text-white/50">Para heavy users e pesquisadores.</p>
                            </div>
                            <ul className="space-y-4 mb-8 flex-1">
                                <PricingItem text="Até 20 gerações por dia" dark />
                                <PricingItem text="Escolha quantos cards (Até 30)" dark />
                                <PricingItem text="Até 100.000 caracteres" dark />
                                <PricingItem text="Upload de PDF e DOCX" dark />
                                <PricingItem text="Suporte Prioritário" dark highlight />
                            </ul>
                            <CheckoutButton
                                priceId={STRIPE_PRICES.ultimate}
                                planName="ultimate"
                                className="w-full py-3 bg-white text-[#1A1A1A] text-center font-bold text-sm rounded-sm hover:bg-white/90 transition-all active:scale-95 transform"
                            >
                                Ir para o Ultimate
                            </CheckoutButton>
                        </motion.div>
                    </div>
                </div>
            </section>
            <section className="py-24 bg-white border-t border-border">
                <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="text-center mb-16">
                        <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">Perguntas Frequentes</h2>
                        <p className="text-foreground/60 font-medium">Tudo o que você precisa saber sobre o gerador.</p>
                    </div>

                    <div className="space-y-4">
                        <FaqItem
                            question="É gratuito?"
                            answer="Sim! O Flashcards Generator oferece um plano gratuito para você começar a criar seus primeiros decks agora mesmo."
                        />
                        <FaqItem
                            question="Funciona com arquivos PDF?"
                            answer="Com certeza. Você pode copiar o texto do seu PDF e colá-lo em nosso gerador para um processamento instantâneo."
                        />
                        <FaqItem
                            question="Como importar no Anki?"
                            answer="Após gerar os cards, basta clicar em 'Exportar para Anki'. Você receberá um arquivo formatado que o Anki reconhece automaticamente."
                        />
                        <FaqItem
                            question="A IA entende português?"
                            answer="Sim, nossa IA é treinada para processar conteúdos complexos em português, mantendo a precisão técnica e gramatical."
                        />
                    </div>
                </div>
            </section>

            {/* Final CTA */}
            <section className="py-24 bg-brand text-white overflow-hidden relative">
                <div className="absolute -top-24 -right-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>
                <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>

                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
                    <h2 className="text-3xl md:text-5xl font-bold tracking-tight mb-8">Pronto para dominar qualquer conteúdo?</h2>
                    <Link
                        href="/app"
                        className="inline-flex bg-white text-brand px-10 py-5 rounded-sm text-xl font-bold hover:bg-gray-50 transition-all shadow-xl"
                    >
                        Começar a Criar Agora
                    </Link>
                </div>
            </section>

            {/* Footer */}
            <footer className="bg-white border-t border-border py-12">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex flex-col md:flex-row justify-between items-center gap-8">
                        <div className="flex items-center">
                            <Image
                                src="/logo.png"
                                alt="Flashcards Generator Logo"
                                width={150}
                                height={32}
                                className="h-8 w-auto object-contain"
                            />
                        </div>

                        <div className="flex gap-8 text-sm font-medium text-foreground/40">
                            <Link href="/app" className="hover:text-brand transition-colors">App</Link>
                            <Link href="/guia" className="hover:text-brand transition-colors">Guia de Importação</Link>
                            <Link href="/terms" className="hover:text-brand transition-colors">Termos</Link>
                            <Link href="/privacy" className="hover:text-brand transition-colors">Privacidade</Link>
                        </div>

                        <div className="text-sm text-foreground/40 font-medium font-mono uppercase tracking-widest">
                            © 2026 Flashcards Generator.
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    );
}

function PricingItem({ text, highlight, dark }: { text: string; highlight?: boolean; dark?: boolean }) {
    return (
        <li className="flex items-center gap-3">
            <div className={`shrink-0 w-5 h-5 rounded-full flex items-center justify-center ${dark ? 'bg-white/10' : 'bg-brand/10'}`}>
                <Check className={`h-3 w-3 ${dark ? 'text-white' : 'text-brand'}`} />
            </div>
            <span className={`text-sm font-medium ${highlight ? 'font-bold' : ''} ${dark ? 'text-white/80' : 'text-foreground/70'}`}>
                {text}
            </span>
        </li>
    );
}

function FaqItem({ question, answer }: { question: string; answer: string }) {
    return (
        <div className="border border-border rounded-sm bg-gray-50/50 overflow-hidden">
            <details className="group">
                <summary className="flex items-center justify-between p-6 cursor-pointer list-none">
                    <span className="text-lg font-bold text-foreground leading-tight">{question}</span>
                    <span className="bg-white border border-border p-1 rounded-sm group-open:rotate-45 transition-transform">
                        <Plus className="h-5 w-5 text-brand" />
                    </span>
                </summary>
                <div className="px-6 pb-6 text-foreground/70 leading-relaxed font-medium">
                    {answer}
                </div>
            </details>
        </div>
    );
}
