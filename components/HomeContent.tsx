"use client";

import Link from 'next/link';
import { useEffect, useMemo, useRef } from 'react';
import { LazyMotion, domAnimation, m } from 'framer-motion';
import { STRIPE_PRICES } from '@/constants/config';
import CheckoutButton from '@/components/CheckoutButton';
import Logo from '@/components/Logo';
import { trackEvent } from '@/lib/analytics';
import {
    ArrowRight,
    FileText,
    Cpu,
    Download,
    CheckCircle2,
    Zap,
    Globe,
    Plus,
    Check,
    Shield,
    ChevronDown,
    Sparkles,
    BookOpen,
    Briefcase,
    GraduationCap,
    Clock,
    Users,
    Timer,
    Layers,
    Lock,
    Activity
} from 'lucide-react';

// Helper: Section Label component
function SectionLabel({ text }: { text: string }) {
    return (
        <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3 text-center">
            {text}
        </p>
    );
}

// Helper: Inline CTA component
function InlineCta({ location }: { location: string }) {
    const handleClick = () => {
        trackEvent('cta_generate_clicked', { location });
    };

    return (
        <div className="mt-12 text-center">
            <Link
                href="/app"
                onClick={handleClick}
                className="group inline-flex items-center gap-2 bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg shadow-brand/20"
            >
                Testar grátis agora
                <ArrowRight className="h-5 w-5 cta-arrow-shift" />
            </Link>
        </div>
    );
}

export default function HomeContent() {
    const scroll50Tracked = useRef(false);
    const scroll90Tracked = useRef(false);

    useEffect(() => {
        trackEvent('landing_viewed');
    }, []);

    useEffect(() => {
        const handleScroll = () => {
            const scrollTop = window.scrollY;
            const docHeight = document.documentElement.scrollHeight - window.innerHeight;
            if (docHeight <= 0) return;
            const percent = (scrollTop / docHeight) * 100;
            if (percent >= 50 && !scroll50Tracked.current) {
                scroll50Tracked.current = true;
                trackEvent('scroll_depth_50');
            }
            if (percent >= 90 && !scroll90Tracked.current) {
                scroll90Tracked.current = true;
                trackEvent('scroll_depth_90');
            }
        };

        window.addEventListener('scroll', handleScroll, { passive: true });
        return () => window.removeEventListener('scroll', handleScroll);
    }, []);

    const heroVariant = process.env.NEXT_PUBLIC_HERO_VARIANT || 'A';
    const heroHeadline = useMemo(() => {
        switch (heroVariant) {
            case 'B':
                return 'Flashcards prontos para ENEM e concursos.';
            case 'C':
                return 'Exporte para Anki em 1 clique.';
            case 'A':
            default:
                return 'Texto → flashcards em segundos.';
        }
    }, [heroVariant]);

    const handleHeroCta = () => trackEvent('cta_generate_clicked', { location: 'hero' });
    const handlePricingCta = (plan: 'free' | 'pro' | 'ultimate') => {
        if (plan === 'free') {
            trackEvent('signup_started', { plan, location: 'pricing' });
        } else {
            trackEvent('checkout_started', { plan, location: 'pricing' });
        }
    };

    return (
        <LazyMotion features={domAnimation}>
            <div className="flex flex-col min-h-screen pb-16 sm:pb-0">
                {/* Hero Section */}
                <section id="hero" className="relative pt-16 pb-28 overflow-hidden">
                    <m.div
                        animate={{ scale: [1, 1.2, 1], rotate: [0, 90, 0], opacity: [0.08, 0.2, 0.08] }}
                        transition={{ duration: 20, repeat: Infinity, ease: "linear" }}
                        className="absolute -top-24 -left-24 w-96 h-96 bg-brand/20 rounded-full blur-3xl -z-10"
                    />
                    <m.div
                        animate={{ scale: [1, 1.5, 1], rotate: [0, -45, 0], opacity: [0.08, 0.3, 0.08] }}
                        transition={{ duration: 25, repeat: Infinity, ease: "linear" }}
                        className="absolute top-1/2 -right-24 w-[500px] h-[500px] bg-brand/10 rounded-full blur-3xl -z-10"
                    />

                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                            <div>
                                <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-4">Flashcards Generator</p>
                                <h1 className="text-4xl md:text-6xl font-black tracking-tight text-foreground mb-6 leading-tight">
                                    {heroHeadline}
                                </h1>
                                <p className="text-lg text-foreground/70 font-medium mb-8">
                                    Perfeito para ENEM, concursos e faculdade. Gere perguntas e respostas automaticamente e exporte para o Anki.
                                </p>

                                <div className="flex flex-col sm:flex-row gap-4 items-start">
                                    <Link
                                        href="/app"
                                        onClick={handleHeroCta}
                                        className="group w-full sm:w-auto bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 flex items-center justify-center gap-2"
                                    >
                                        Testar grátis agora
                                        <ArrowRight className="h-5 w-5 cta-arrow-shift" />
                                    </Link>
                                    <Link
                                        href="#demo"
                                        onClick={() => trackEvent('cta_generate_clicked', { type: 'example' })}
                                        className="w-full sm:w-auto bg-white border border-border text-foreground px-8 py-4 rounded-sm text-lg font-bold hover:bg-gray-50 transition-all"
                                    >
                                        Ver exemplo
                                    </Link>
                                </div>
                                <p className="text-xs text-foreground/50 font-bold mt-3">
                                    Sem cartão • 3 gerações por dia no plano grátis
                                </p>

                                <div className="mt-8 flex flex-wrap gap-3 text-[11px] font-bold text-foreground/60">
                                    <span className="bg-white border border-border px-3 py-1 rounded-sm">Criado por um desenvolvedor independente</span>
                                    <span className="bg-white border border-border px-3 py-1 rounded-sm">Suporte rápido</span>
                                    <span className="bg-white border border-border px-3 py-1 rounded-sm flex items-center gap-1.5">
                                        <Shield className="h-3 w-3 text-brand" />
                                        Seus dados protegidos
                                    </span>
                                </div>
                            </div>

                            <div className="bg-white border border-border rounded-sm shadow-xl p-6">
                                <div className="text-[10px] font-bold uppercase tracking-widest text-foreground/60 mb-3">Preview real</div>
                                <div className="bg-gray-50 border border-border rounded-sm p-4 mb-4">
                                    <div className="text-[10px] font-bold text-foreground/60 uppercase mb-2">Texto colado</div>
                                    <p className="text-sm text-foreground/70">
                                        "A Revolução Industrial aumentou a produção, mas trouxe jornadas longas, trabalho infantil e urbanização acelerada..."
                                    </p>
                                </div>
                                <div className="space-y-3">
                                    {[
                                        { q: 'O que foi a Revolução Industrial?', a: 'Mudança para produção mecanizada em larga escala.' },
                                        { q: 'Qual efeito social marcante?', a: 'Urbanização rápida e condições de trabalho precárias.' },
                                        { q: 'Consequência na produtividade?', a: 'Aumento expressivo da produção e dos lucros.' },
                                    ].map((card, idx) => (
                                        <div key={idx} className="border border-border rounded-sm p-3">
                                            <div className="text-[9px] font-black uppercase tracking-widest text-brand">Pergunta #{idx + 1}</div>
                                            <p className="text-sm font-bold text-foreground mt-1">{card.q}</p>
                                            <div className="text-[9px] font-black uppercase tracking-widest text-foreground/60 mt-2">Resposta</div>
                                            <p className="text-sm text-foreground/70">{card.a}</p>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>

                        {/* Scroll indicator - desktop only */}
                        <div className="hidden lg:flex justify-center mt-12">
                            <a href="#how-it-works" className="animate-scroll-bounce text-foreground/30 hover:text-brand transition-colors">
                                <ChevronDown className="h-8 w-8" />
                            </a>
                        </div>
                    </div>
                </section>

                {/* How It Works Section */}
                <section id="how-it-works" className="py-24 bg-white border-y border-border">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-12"
                        >
                            <SectionLabel text="COMO FUNCIONA" />
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-3">Como funciona (em 10 segundos)</h2>
                            <p className="text-base text-foreground/60 font-medium">Cole, gere e exporte.</p>
                        </m.div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
                            {[
                                { icon: FileText, title: "1. Cole o texto", text: "Qualquer resumo, apostila ou conteúdo." },
                                { icon: Cpu, title: "2. Gere os flashcards", text: "IA transforma em perguntas e respostas." },
                                { icon: Download, title: "3. Exporte e revise", text: "Anki, CSV ou PDF para imprimir." }
                            ].map((step, index) => (
                                <m.div
                                    key={index}
                                    initial={{ opacity: 0, y: 30 }}
                                    whileInView={{ opacity: 1, y: 0 }}
                                    viewport={{ once: true }}
                                    transition={{ duration: 0.5, delay: index * 0.2 }}
                                    whileHover={{ y: -5 }}
                                    className="text-center group step-connector"
                                >
                                    <div className="w-16 h-16 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-6 group-hover:bg-brand group-hover:text-white transition-all duration-300">
                                        <step.icon className="h-8 w-8 text-brand group-hover:text-white transition-colors" />
                                    </div>
                                    <h3 className="text-xl font-bold mb-3">{step.title}</h3>
                                    <p className="text-foreground/60 leading-relaxed">
                                        {step.text}
                                    </p>
                                </m.div>
                            ))}
                        </div>

                        <InlineCta location="how_it_works" />
                    </div>
                </section>

                {/* Demo Section */}
                <section id="demo" className="py-24">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-12"
                        >
                            <SectionLabel text="VEJA NA PRÁTICA" />
                        </m.div>

                        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
                            <m.div
                                initial={{ opacity: 0, x: -30 }}
                                whileInView={{ opacity: 1, x: 0 }}
                                viewport={{ once: true }}
                            >
                                <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">Veja o resultado real antes de criar conta</h2>
                                <p className="text-foreground/60 font-medium mb-6">
                                    Cole um texto e veja 3 flashcards prontos em segundos.
                                </p>
                                <Link
                                    href="/app"
                                    onClick={handleHeroCta}
                                    className="group inline-flex items-center gap-2 bg-brand text-white px-8 py-4 rounded-sm text-lg font-bold hover:bg-brand/90 transition-all"
                                >
                                    Testar grátis agora
                                    <ArrowRight className="h-5 w-5 cta-arrow-shift" />
                                </Link>
                            </m.div>
                            <m.div
                                initial={{ opacity: 0, x: 30 }}
                                whileInView={{ opacity: 1, x: 0 }}
                                viewport={{ once: true }}
                                className="bg-white border border-border rounded-sm shadow-xl p-6"
                            >
                                <div className="text-[10px] font-bold uppercase tracking-widest text-foreground/60 mb-3">Antes → Depois</div>
                                <div className="grid grid-cols-1 gap-4">
                                    <div className="bg-gray-50 border border-border rounded-sm p-4">
                                        <div className="text-[10px] font-bold uppercase tracking-widest text-foreground/60">Antes</div>
                                        <p className="text-sm text-foreground/70 mt-2">"Fotossíntese converte luz em energia química, produzindo glicose e oxigênio."</p>
                                    </div>

                                    {/* Visual transformation indicator */}
                                    <div className="flex items-center justify-center py-2">
                                        <div className="flex-1 h-px bg-border"></div>
                                        <div className="mx-4 flex items-center gap-2 text-brand">
                                            <Sparkles className="h-5 w-5" />
                                            <span className="text-xs font-bold uppercase tracking-wider">Transformação</span>
                                            <Sparkles className="h-5 w-5" />
                                        </div>
                                        <div className="flex-1 h-px bg-border"></div>
                                    </div>

                                    <div className="bg-gray-50 border border-border rounded-sm p-4">
                                        <div className="text-[10px] font-bold uppercase tracking-widest text-foreground/60">Depois</div>
                                        <ul className="space-y-2 text-sm mt-2">
                                            <li><strong>Pergunta:</strong> O que é fotossíntese?</li>
                                            <li><strong>Resposta:</strong> Processo que transforma luz em energia química.</li>
                                            <li><strong>Pergunta:</strong> Qual produto principal?</li>
                                            <li><strong>Resposta:</strong> Glicose (e liberação de oxigênio).</li>
                                        </ul>
                                    </div>
                                </div>
                            </m.div>
                        </div>
                    </div>
                </section>

                {/* Features Section */}
                <section className="py-24 bg-white border-y border-border">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-12"
                        >
                            <SectionLabel text="RECURSOS" />
                        </m.div>

                        <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
                            <div>
                                <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-6">Pare de perder tempo montando material.</h2>
                                <ul className="space-y-6">
                                    {[
                                        { icon: CheckCircle2, title: "Perguntas e respostas automáticas", text: "Transforma conteúdo em perguntas e respostas em segundos." },
                                        { icon: Zap, title: "Memorize mais rápido", text: "Revisão eficiente com flashcards objetivos." },
                                        { icon: Globe, title: "Funciona para resumos, apostilas e PDFs", text: "Com conta, você também faz upload e salva histórico." },
                                    ].map((item, index) => (
                                        <m.li
                                            key={index}
                                            initial={{ opacity: 0, x: -20 }}
                                            whileInView={{ opacity: 1, x: 0 }}
                                            viewport={{ once: true }}
                                            transition={{ delay: index * 0.15 }}
                                            className="flex gap-4"
                                        >
                                            <div className="mt-1 flex-shrink-0">
                                                <item.icon className="h-6 w-6 text-brand" />
                                            </div>
                                            <div>
                                                <h4 className="font-bold text-lg">{item.title}</h4>
                                                <p className="text-foreground/60">{item.text}</p>
                                            </div>
                                        </m.li>
                                    ))}
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
                                                <div className="text-[10px] font-bold text-foreground/60 uppercase mb-1">Pergunta #{i}</div>
                                                <div className="h-3 w-3/4 bg-gray-200 rounded-full mb-3 animate-pulse"></div>
                                                <div className="text-[10px] font-bold text-foreground/60 uppercase mb-1">Resposta</div>
                                                <div className="h-3 w-1/2 bg-gray-200 rounded-full animate-pulse"></div>
                                            </div>
                                        ))}
                                    </div>
                                    <div className="absolute bottom-4 right-4 translate-y-12 blur-sm opacity-50 bg-brand/20 w-32 h-32 rounded-full -z-10"></div>
                                </div>
                            </div>
                        </div>

                        <InlineCta location="features" />
                    </div>
                </section>

                {/* Use Cases Section */}
                <section className="py-24">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-12"
                        >
                            <SectionLabel text="PARA QUEM" />
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-8">Para quem é</h2>
                        </m.div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                            {[
                                { icon: BookOpen, title: 'ENEM', text: 'Revisões rápidas e perguntas objetivas.' },
                                { icon: Briefcase, title: 'Concursos', text: 'Lei seca, resumos e pegadinhas.' },
                                { icon: GraduationCap, title: 'Faculdade', text: 'Apostilas, artigos e provas.' },
                            ].map((item, index) => (
                                <m.div
                                    key={item.title}
                                    initial={{ opacity: 0, y: 20 }}
                                    whileInView={{ opacity: 1, y: 0 }}
                                    viewport={{ once: true }}
                                    transition={{ delay: index * 0.1 }}
                                    whileHover={{ y: -5 }}
                                    className="bg-white border border-border rounded-sm p-6 text-center"
                                >
                                    <div className="w-12 h-12 bg-brand/5 border border-brand/20 flex items-center justify-center rounded-sm mx-auto mb-4">
                                        <item.icon className="h-6 w-6 text-brand" />
                                    </div>
                                    <h3 className="text-lg font-bold mb-2">{item.title}</h3>
                                    <p className="text-foreground/60 text-sm">{item.text}</p>
                                </m.div>
                            ))}
                        </div>

                        <InlineCta location="use_cases" />
                    </div>
                </section>

                {/* Metrics Section */}
                <section className="py-24 bg-white border-y border-border">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-12"
                        >
                            <SectionLabel text="NOSSOS NÚMEROS" />
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight">Tecnologia que entrega</h2>
                        </m.div>

                        <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
                            {[
                                { icon: Timer, value: '10s', label: 'Tempo médio de geração' },
                                { icon: Layers, value: '3', label: 'Formatos de exportação' },
                                { icon: Lock, value: '100%', label: 'Dados protegidos' },
                                { icon: Activity, value: '24/7', label: 'Disponibilidade' },
                            ].map((metric, index) => (
                                <m.div
                                    key={metric.label}
                                    initial={{ opacity: 0, scale: 0.9 }}
                                    whileInView={{ opacity: 1, scale: 1 }}
                                    viewport={{ once: true }}
                                    transition={{ delay: index * 0.1 }}
                                    className="bg-gray-50 border border-border rounded-sm p-6 text-center"
                                >
                                    <metric.icon className="h-8 w-8 text-brand mx-auto mb-3" />
                                    <div className="text-3xl font-black text-foreground mb-1">{metric.value}</div>
                                    <div className="text-sm text-foreground/60 font-medium">{metric.label}</div>
                                </m.div>
                            ))}
                        </div>
                    </div>
                </section>

                {/* Pricing Section */}
                <section id="pricing" className="py-24 border-b border-border">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-16"
                        >
                            <SectionLabel text="PREÇOS" />
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">Planos claros e sem pegadinha</h2>
                            <p className="text-base text-foreground/60 font-medium">Teste completo com preview e faça upgrade quando fizer sentido.</p>
                        </m.div>

                        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 items-end">
                            <m.div
                                initial={{ opacity: 0, x: -30 }}
                                whileInView={{ opacity: 1, x: 0 }}
                                viewport={{ once: true }}
                                whileHover={{ y: -6 }}
                                className="bg-white border border-border p-8 rounded-sm shadow-sm flex flex-col h-full"
                            >
                                <div className="mb-8">
                                    <h3 className="text-xl font-bold mb-2">Básico</h3>
                                    <div className="flex items-baseline gap-1 mb-4">
                                        <span className="text-4xl font-bold tracking-tighter">Grátis</span>
                                    </div>
                                    <p className="text-sm font-medium text-foreground/50">Teste completo (preview).</p>
                                </div>
                                <ul className="space-y-3 mb-8 flex-1">
                                    <PricingItem text="3 gerações por dia" />
                                    <PricingItem text="até 5 cards por geração" />
                                    <PricingItem text="limite de 2.000 caracteres" />
                                    <PricingItem text="conteúdo por texto (copy/paste)" />
                                    <PricingItem text="exportação para Anki" />
                                </ul>
                                <Link
                                    href="/app"
                                    onClick={() => handlePricingCta('free')}
                                    className="w-full py-3 border border-border text-center font-bold text-sm rounded-sm hover:bg-gray-50 transition-all"
                                >
                                    Começar grátis
                                </Link>
                            </m.div>

                            <m.div
                                initial={{ opacity: 0, y: 50 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                whileHover={{ scale: 1.04, y: -6 }}
                                transition={{ type: "spring", stiffness: 300 }}
                                className="bg-brand/[0.02] border-2 border-brand p-8 rounded-sm shadow-xl flex flex-col h-[110%] relative z-10"
                            >
                                <div className="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 bg-brand text-white text-[10px] font-black uppercase tracking-widest px-4 py-1.5 rounded-full">
                                    Recomendado
                                </div>
                                <div className="mb-8 pt-4">
                                    <h3 className="text-xl font-bold text-brand mb-2">Pro</h3>
                                    <div className="flex items-baseline gap-1 mb-4">
                                        <span className="text-sm font-bold text-foreground/60">R$</span>
                                        <span className="text-5xl font-bold tracking-tighter">9,90</span>
                                        <span className="text-sm font-bold text-foreground/60">/mês</span>
                                    </div>
                                    <p className="text-sm font-medium text-foreground/70">Menos que um lanche por mês.</p>
                                </div>
                                <ul className="space-y-3 mb-8 flex-1">
                                    <PricingItem text="até 10 gerações por dia" />
                                    <PricingItem text="até 15 cards por geração" />
                                    <PricingItem text="até 20.000 caracteres" />
                                    <PricingItem text="histórico salvo" />
                                    <PricingItem text="IA otimizada" highlight />
                                </ul>
                                <CheckoutButton
                                    priceId={STRIPE_PRICES.pro}
                                    planName="pro"
                                    onClick={() => handlePricingCta('pro')}
                                    className="w-full py-4 bg-brand text-white text-center font-bold rounded-sm hover:bg-brand/90 transition-all shadow-lg shadow-brand/20 active:scale-95 transform overflow-hidden relative group"
                                >
                                    <span className="relative z-10">Assinar Pro</span>
                                    <m.div
                                        initial={{ x: '-100%' }}
                                        whileHover={{ x: '100%' }}
                                        transition={{ duration: 0.5 }}
                                        className="absolute inset-0 bg-white/20 -skew-x-12"
                                    />
                                </CheckoutButton>
                            </m.div>

                            <m.div
                                initial={{ opacity: 0, x: 30 }}
                                whileInView={{ opacity: 1, x: 0 }}
                                viewport={{ once: true }}
                                whileHover={{ y: -6 }}
                                className="bg-foreground border border-foreground/20 p-8 rounded-sm shadow-sm flex flex-col h-full text-background"
                            >
                                <div className="mb-8">
                                    <h3 className="text-xl font-bold mb-2">Ultimate</h3>
                                    <div className="flex items-baseline gap-1 mb-4">
                                        <span className="text-sm font-bold text-background/40">R$</span>
                                        <span className="text-4xl font-bold tracking-tighter italic">19,90</span>
                                        <span className="text-sm font-bold text-background/40">/mês</span>
                                    </div>
                                    <p className="text-sm font-medium text-background/50">Pra quem estuda pesado.</p>
                                </div>
                                <ul className="space-y-3 mb-8 flex-1">
                                    <PricingItem text="até 20 gerações por dia" dark />
                                    <PricingItem text="até 30 cards por geração" dark />
                                    <PricingItem text="até 100.000 caracteres" dark />
                                    <PricingItem text="upload de PDF/DOCX/imagens" dark />
                                    <PricingItem text="geração de imagens" dark />
                                    <PricingItem text="suporte prioritário" dark highlight />
                                </ul>
                                <CheckoutButton
                                    priceId={STRIPE_PRICES.ultimate}
                                    planName="ultimate"
                                    onClick={() => handlePricingCta('ultimate')}
                                    className="w-full py-3 bg-background theme-static-light text-foreground text-center font-bold text-sm rounded-sm hover:bg-background/90 transition-all"
                                >
                                    Assinar Ultimate
                                </CheckoutButton>
                            </m.div>
                        </div>

                        {/* Comparison Table */}
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="mt-16 overflow-x-auto"
                        >
                            <table className="comparison-table min-w-full bg-white border border-border rounded-sm">
                                <thead>
                                    <tr>
                                        <th className="rounded-tl-sm">Recurso</th>
                                        <th>Básico</th>
                                        <th className="bg-brand/5 text-brand">Pro</th>
                                        <th className="rounded-tr-sm">Ultimate</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td className="font-medium">Gerações/dia</td>
                                        <td>3</td>
                                        <td className="bg-brand/[0.02]">10</td>
                                        <td>20</td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium">Cards/geração</td>
                                        <td>5</td>
                                        <td className="bg-brand/[0.02]">15</td>
                                        <td>30</td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium">Caracteres</td>
                                        <td>2.000</td>
                                        <td className="bg-brand/[0.02]">20.000</td>
                                        <td>100.000</td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium">Upload PDF/DOCX</td>
                                        <td>—</td>
                                        <td className="bg-brand/[0.02]">—</td>
                                        <td><Check className="h-4 w-4 text-brand inline" /></td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium">Geração de imagens</td>
                                        <td>—</td>
                                        <td className="bg-brand/[0.02]">—</td>
                                        <td><Check className="h-4 w-4 text-brand inline" /></td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium">IA otimizada</td>
                                        <td>—</td>
                                        <td className="bg-brand/[0.02]"><Check className="h-4 w-4 text-brand inline" /></td>
                                        <td><Check className="h-4 w-4 text-brand inline" /></td>
                                    </tr>
                                    <tr>
                                        <td className="font-medium rounded-bl-sm">Suporte prioritário</td>
                                        <td>—</td>
                                        <td className="bg-brand/[0.02]">—</td>
                                        <td className="rounded-br-sm"><Check className="h-4 w-4 text-brand inline" /></td>
                                    </tr>
                                </tbody>
                            </table>
                        </m.div>

                        <div className="mt-8 text-center text-xs font-bold text-foreground/50">
                            ✅ Cancele quando quiser • ✅ Sem pegadinhas • ✅ Acelera semanas de estudo
                        </div>
                    </div>
                </section>

                {/* FAQ Section */}
                <section className="py-24 bg-white border-b border-border">
                    <div className="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
                        <m.div
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            viewport={{ once: true }}
                            className="text-center mb-10"
                        >
                            <SectionLabel text="PERGUNTAS FREQUENTES" />
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4">Dúvidas? A gente responde.</h2>
                            <p className="text-foreground/60 font-medium">Respostas diretas para quem quer testar rápido.</p>
                        </m.div>

                        {/* FAQ Group: Planos e Pagamento */}
                        <div className="mb-8">
                            <h3 className="text-sm font-bold uppercase tracking-widest text-foreground/50 mb-4">Planos e Pagamento</h3>
                            <div className="space-y-4">
                                <FaqItem question="O plano grátis é realmente grátis?" answer="Sim. Você pode testar sem pagar e sem cartão." index={0} />
                                <FaqItem question="Preciso de cartão para testar?" answer="Não. Só pedimos cartão no upgrade." index={1} />
                                <FaqItem question="Posso cancelar quando quiser?" answer="Sim, sem fidelidade." index={2} />
                            </div>
                        </div>

                        {/* FAQ Group: Funcionalidades */}
                        <div>
                            <h3 className="text-sm font-bold uppercase tracking-widest text-foreground/50 mb-4">Funcionalidades</h3>
                            <div className="space-y-4">
                                <FaqItem question="Consigo exportar para Anki?" answer="Sim. Exportação para Anki disponível." index={3} />
                                <FaqItem question="O que significa 'IA otimizada'?" answer="Prompt melhor para gerar cards mais claros e úteis." index={4} />
                                <FaqItem question="Posso usar no celular?" answer="Sim, a versão mobile é responsiva." index={5} />
                                <FaqItem question="No Ultimate eu posso subir PDF e imagem?" answer="Sim, com upload de PDF/DOCX e imagens." index={6} />
                            </div>
                        </div>
                    </div>
                </section>

                {/* Trust Section */}
                <section className="py-16">
                    <div className="max-w-5xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 text-center">
                            {[
                                { icon: Users, text: "Criado por um desenvolvedor independente" },
                                { icon: Clock, text: "Suporte rápido" },
                                { icon: Shield, text: "Seus dados são protegidos" },
                            ].map((item, index) => (
                                <m.div
                                    key={index}
                                    initial={{ opacity: 0, y: 10 }}
                                    whileInView={{ opacity: 1, y: 0 }}
                                    viewport={{ once: true }}
                                    transition={{ delay: index * 0.1 }}
                                    className="bg-white border border-border rounded-sm p-4 flex items-center justify-center gap-3"
                                >
                                    <item.icon className="h-5 w-5 text-brand flex-shrink-0" />
                                    <span className="text-sm font-bold text-foreground/70">{item.text}</span>
                                </m.div>
                            ))}
                        </div>
                        <div className="mt-4 text-center text-xs font-bold text-foreground/50">
                            🔒 Seus dados nunca são compartilhados com terceiros
                        </div>
                        <div className="mt-4 text-center text-xs font-bold text-foreground/50">
                            <Link href="/privacy" className="underline">Privacidade</Link> • <Link href="/terms" className="underline">Termos</Link>
                        </div>
                    </div>
                </section>

                {/* Final CTA Section */}
                <section className="py-24 bg-brand text-white overflow-hidden relative">
                    <div className="absolute -top-24 -right-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>
                    <div className="absolute -bottom-24 -left-24 w-96 h-96 bg-white/10 rounded-full blur-3xl"></div>

                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center relative z-10">
                        <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-6">Gere seus primeiros flashcards agora.</h2>
                        <Link
                            href="/app"
                            onClick={handleHeroCta}
                            className="group inline-flex items-center gap-2 bg-white theme-static-light text-brand px-10 py-4 rounded-sm text-lg font-bold hover:bg-gray-50 transition-all shadow-xl"
                        >
                            Testar grátis agora
                            <ArrowRight className="h-5 w-5 cta-arrow-shift" />
                        </Link>
                        <p className="text-xs text-white/80 font-bold mt-3">Sem cartão • 3 gerações/dia grátis</p>
                    </div>
                </section>

                {/* Mobile Sticky CTA */}
                <div className="fixed bottom-0 left-0 right-0 z-40 sm:hidden bg-white border-t border-border shadow-lg p-3">
                    <Link
                        href="/app"
                        onClick={handleHeroCta}
                        className="group w-full bg-brand text-white py-3 rounded-sm font-bold text-center shadow-lg flex items-center justify-center gap-2"
                    >
                        Testar grátis agora
                        <ArrowRight className="h-5 w-5 cta-arrow-shift" />
                    </Link>
                </div>

                {/* Footer */}
                <footer className="bg-white border-t border-border py-12">
                    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                        <div className="flex flex-col md:flex-row justify-between items-center gap-8">
                            <div className="flex items-center">
                                <Logo
                                    className="h-10 w-[160px]"
                                    alt="Flashcards Generator Logo"
                                />
                            </div>

                            <div className="flex gap-8 text-sm font-medium text-foreground/60">
                                <Link href="/app" className="hover:text-brand transition-colors">App</Link>
                                <Link href="/guia" className="hover:text-brand transition-colors">Guia de Importação</Link>
                                <Link href="/terms" className="hover:text-brand transition-colors">Termos</Link>
                                <Link href="/privacy" className="hover:text-brand transition-colors">Privacidade</Link>
                            </div>

                            <div className="text-sm text-foreground/60 font-medium font-mono uppercase tracking-widest">
                                © 2026 Flashcards Generator.
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </LazyMotion>
    );
}

function PricingItem({ text, highlight, dark }: { text: string; highlight?: boolean; dark?: boolean }) {
    return (
        <li className="flex items-center gap-3">
            <div className={`shrink-0 w-5 h-5 rounded-full flex items-center justify-center ${dark ? 'bg-background/10' : 'bg-brand/10'}`}>
                <Check className={`h-3 w-3 ${dark ? 'text-background' : 'text-brand'}`} />
            </div>
            <span className={`text-sm font-medium ${highlight ? 'font-bold' : ''} ${dark ? 'text-background/80' : 'text-foreground/70'}`}>
                {text}
            </span>
        </li>
    );
}

function FaqItem({ question, answer, index }: { question: string; answer: string; index: number }) {
    return (
        <m.div
            initial={{ opacity: 0, y: 10 }}
            whileInView={{ opacity: 1, y: 0 }}
            viewport={{ once: true }}
            transition={{ delay: index * 0.05 }}
            className="border border-border rounded-sm bg-gray-50/50 overflow-hidden"
        >
            <details
                className="group"
                onToggle={(event) => {
                    if ((event.target as HTMLDetailsElement).open) {
                        trackEvent('faq_opened', { question });
                    }
                }}
            >
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
        </m.div>
    );
}
