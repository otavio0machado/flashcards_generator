'use client';

import { motion } from 'framer-motion';
import { BookOpen, Briefcase, GraduationCap } from 'lucide-react';

export default function ForWhoSection() {
    const items = [
        {
            icon: BookOpen,
            title: 'ENEM',
            desc: 'Domine humanas e biológicas revisando rápido.',
            color: 'text-pink-500 bg-pink-500/10'
        },
        {
            icon: Briefcase,
            title: 'Concursos',
            desc: 'Memorize leis secas, prazos e exceções.',
            color: 'text-blue-500 bg-blue-500/10'
        },
        {
            icon: GraduationCap,
            title: 'Faculdade',
            desc: 'Transforme PDFs gigantes em cards digeríveis.',
            color: 'text-purple-500 bg-purple-500/10'
        }
    ];

    return (
        <section className="py-12 px-6 bg-secondary-system-background/50">
            <div className="mb-8 text-center">
                <span className="text-[10px] font-black uppercase tracking-widest text-brand mb-2 block">
                    Público
                </span>
                <h2 className="text-2xl font-bold text-foreground">
                    Para quem é?
                </h2>
            </div>

            <div className="grid grid-cols-1 gap-4">
                {items.map((item, index) => (
                    <motion.div
                        key={item.title}
                        initial={{ opacity: 0, scale: 0.95 }}
                        whileInView={{ opacity: 1, scale: 1 }}
                        viewport={{ once: true }}
                        transition={{ delay: index * 0.1 }}
                        className="bg-background border border-border/50 rounded-2xl p-5 flex items-center gap-4"
                    >
                        <div className={`w-12 h-12 rounded-xl flex items-center justify-center shrink-0 ${item.color}`}>
                            <item.icon className="w-6 h-6" />
                        </div>
                        <div>
                            <h3 className="text-lg font-bold mb-1">{item.title}</h3>
                            <p className="text-sm text-foreground/60 font-medium leading-tight">
                                {item.desc}
                            </p>
                        </div>
                    </motion.div>
                ))}
            </div>
        </section>
    );
}
