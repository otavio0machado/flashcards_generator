'use client';

import { motion } from 'framer-motion';
import { FileText, Cpu, Download, ArrowRight } from 'lucide-react';

export default function HowItWorksSection() {
    const steps = [
        {
            icon: FileText,
            title: '1. Cole o texto',
            desc: 'Pode ser resumo, apostila ou foto de caderno.',
            color: 'bg-blue-500/10 text-blue-600'
        },
        {
            icon: Cpu,
            title: '2. IA Gera',
            desc: 'Detectamos o que é importante e criamos perguntas.',
            color: 'bg-brand/10 text-brand'
        },
        {
            icon: Download,
            title: '3. Exporte',
            desc: 'Mande direto para o Anki ou baixe em PDF.',
            color: 'bg-green-500/10 text-green-600'
        }
    ];

    return (
        <section id="how-it-works" className="py-12 px-6 bg-secondary-system-background/50">
            <div className="mb-8 text-center">
                <span className="text-[10px] font-black uppercase tracking-widest text-brand mb-2 block">
                    Fluxo Simples
                </span>
                <h2 className="text-2xl font-bold text-foreground">
                    Do texto ao estudo em segundos
                </h2>
            </div>

            <div className="space-y-4">
                {steps.map((step, index) => (
                    <motion.div
                        key={index}
                        initial={{ opacity: 0, x: -20 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                        transition={{ delay: index * 0.15 }}
                        className="bg-background rounded-2xl p-5 border border-border/50 shadow-sm relative overflow-hidden"
                    >
                        {index < steps.length - 1 && (
                            <div className="absolute left-[38px] top-[60px] bottom-[-20px] w-0.5 border-l-2 border-dashed border-border/60 -z-10 opacity-50" />
                        )}

                        <div className="flex items-start gap-4">
                            <div className={`w-12 h-12 rounded-xl flex items-center justify-center shrink-0 ${step.color}`}>
                                <step.icon className="w-6 h-6" />
                            </div>
                            <div>
                                <h3 className="text-base font-bold text-foreground mb-1">
                                    {step.title}
                                </h3>
                                <p className="text-sm text-foreground/60 leading-relaxed font-medium">
                                    {step.desc}
                                </p>
                            </div>
                        </div>
                    </motion.div>
                ))}
            </div>
        </section>
    );
}
