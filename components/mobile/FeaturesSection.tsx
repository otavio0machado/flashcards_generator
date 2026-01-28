'use client';

import { motion } from 'framer-motion';
import { Zap, Brain, FileType } from 'lucide-react';

export default function FeaturesSection() {
    const features = [
        {
            icon: Zap,
            title: 'Perguntas Automáticas',
            desc: 'Nossa IA identifica conceitos chave e transforma em Q&A.'
        },
        {
            icon: Brain,
            title: 'Memorização Rápida',
            desc: 'Flashcards são o método mais eficiente de estudo ativo.'
        },
        {
            icon: FileType,
            title: 'Suporte a PDFs',
            desc: 'Faça upload de apostilas inteiras no plano Ultimate.'
        }
    ];

    return (
        <section className="py-12 px-6">
            <div className="mb-8 text-center">
                <span className="text-[10px] font-black uppercase tracking-widest text-brand mb-2 block">
                    Vantagens
                </span>
                <h2 className="text-2xl font-bold text-foreground">
                    Estude melhor, não mais
                </h2>
            </div>

            <div className="grid grid-cols-1 gap-4">
                {features.map((feature, index) => (
                    <motion.div
                        key={index}
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        transition={{ delay: index * 0.1 }}
                        className="bg-secondary-system-background rounded-2xl p-6 text-center"
                    >
                        <div className="w-12 h-12 bg-brand/10 rounded-full flex items-center justify-center mx-auto mb-4 text-brand">
                            <feature.icon className="w-6 h-6" />
                        </div>
                        <h3 className="text-lg font-bold mb-2">{feature.title}</h3>
                        <p className="text-sm text-foreground/60 font-medium">
                            {feature.desc}
                        </p>
                    </motion.div>
                ))}
            </div>
        </section>
    );
}
