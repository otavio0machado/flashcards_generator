'use client';

import { motion } from 'framer-motion';
import { Check, Star } from 'lucide-react';
import Link from 'next/link';
import { trackEvent } from '@/lib/analytics';
import { STRIPE_PRICES } from '@/constants/config';
import CheckoutButton from '@/components/CheckoutButton';

export default function MobilePricingSection() {
    const handlePricingCta = (plan: 'free' | 'pro' | 'ultimate') => {
        if (plan === 'free') {
            trackEvent('signup_started', { plan, location: 'mobile_pricing' });
        } else {
            trackEvent('checkout_started', { plan, location: 'mobile_pricing' });
        }
    };

    return (
        <section id="pricing" className="py-16 px-6">
            <div className="text-center mb-10">
                <span className="text-[10px] font-black uppercase tracking-widest text-brand mb-2 block">
                    Planos
                </span>
                <h2 className="text-2xl font-bold text-foreground mb-3">
                    Comece grátis
                </h2>
                <p className="text-sm text-foreground/60 font-medium px-4">
                    Teste à vontade. Faça upgrade apenas se precisar de mais poder.
                </p>
            </div>

            <div className="flex overflow-x-auto pb-8 gap-4 snap-x snap-mandatory -mx-6 px-6 scrollbar-hide">
                {/* Free Plan */}
                <div className="snap-center min-w-[85vw] bg-white border border-border rounded-2xl p-6 flex flex-col items-start shadow-sm">
                    <div className="mb-4">
                        <div className="text-sm font-bold text-foreground/60 uppercase tracking-widest mb-1">Básico</div>
                        <div className="text-3xl font-black">Grátis</div>
                    </div>
                    <ul className="space-y-3 mb-8 w-full flex-1">
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-green-500 shrink-0" /> 3 gerações por dia
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-green-500 shrink-0" /> 5 cards por geração
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-green-500 shrink-0" /> Exportação Anki
                        </li>
                    </ul>
                    <Link
                        href="/app/generate"
                        onClick={() => handlePricingCta('free')}
                        className="w-full py-3.5 border-2 border-border text-foreground rounded-xl font-bold text-center active:bg-gray-50 transition-colors"
                    >
                        Testar Agora
                    </Link>
                </div>

                {/* Pro Plan */}
                <div className="snap-center min-w-[85vw] bg-zinc-900 border-2 border-brand rounded-2xl p-6 flex flex-col items-start shadow-xl relative overflow-hidden">
                    <div className="absolute top-4 right-4 bg-brand text-white text-[10px] font-black uppercase tracking-widest px-2 py-1 rounded">
                        Popular
                    </div>
                    <div className="mb-4 relative z-10">
                        <div className="text-sm font-bold text-zinc-400 uppercase tracking-widest mb-1">Pro</div>
                        <div className="flex items-baseline gap-1 text-white">
                            <span className="text-3xl font-black">R$ 9,90</span>
                            <span className="text-sm text-zinc-500 font-bold">/mês</span>
                        </div>
                    </div>
                    <ul className="space-y-3 mb-8 w-full flex-1 relative z-10">
                        <li className="flex items-center gap-3 text-sm font-medium text-zinc-300">
                            <Check className="w-4 h-4 text-brand shrink-0" /> 10 gerações por dia
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-zinc-300">
                            <Check className="w-4 h-4 text-brand shrink-0" /> 20.000 caracteres
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-zinc-300">
                            <Check className="w-4 h-4 text-brand shrink-0" /> Histórico Salvo
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-white bg-brand/10 p-2 rounded-lg -mx-2">
                            <Star className="w-4 h-4 text-brand fill-brand shrink-0" /> IA Otimizada
                        </li>
                    </ul>
                    <CheckoutButton
                        priceId={STRIPE_PRICES.pro}
                        planName="pro"
                        onClick={() => handlePricingCta('pro')}
                        className="w-full py-3.5 bg-brand text-white rounded-xl font-bold text-center shadow-lg shadow-brand/20 relative z-10 active:scale-95 transition-transform"
                    >
                        Assinar Pro
                    </CheckoutButton>

                    {/* Background acccent */}
                    <div className="absolute -bottom-10 -right-10 w-40 h-40 bg-brand/20 rounded-full blur-3xl" />
                </div>

                {/* Ultimate Plan */}
                <div className="snap-center min-w-[85vw] bg-white border border-border rounded-2xl p-6 flex flex-col items-start shadow-sm">
                    <div className="mb-4">
                        <div className="text-sm font-bold text-foreground/60 uppercase tracking-widest mb-1">Ultimate</div>
                        <div className="flex items-baseline gap-1">
                            <span className="text-3xl font-black">R$ 19,90</span>
                            <span className="text-sm text-foreground/40 font-bold">/mês</span>
                        </div>
                    </div>
                    <ul className="space-y-3 mb-8 w-full flex-1">
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-brand shrink-0" /> 20 gerações/dia
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-brand shrink-0" /> Upload de PDF
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-brand shrink-0" /> IA de Imagens
                        </li>
                        <li className="flex items-center gap-3 text-sm font-medium text-foreground/80">
                            <Check className="w-4 h-4 text-brand shrink-0" /> Suporte Prioritário
                        </li>
                    </ul>
                    <CheckoutButton
                        priceId={STRIPE_PRICES.ultimate}
                        planName="ultimate"
                        onClick={() => handlePricingCta('ultimate')}
                        className="w-full py-3.5 bg-foreground text-background rounded-xl font-bold text-center active:scale-95 transition-transform"
                    >
                        Assinar Ultimate
                    </CheckoutButton>
                </div>
            </div>
        </section>
    );
}
