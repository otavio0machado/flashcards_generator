'use client';

import { motion } from 'framer-motion';
import { Timer, Layers, Shield, Activity } from 'lucide-react';

export default function MetricsSection() {
    const metrics = [
        { icon: Timer, value: '10s', label: 'Geração média' },
        { icon: Layers, value: '3', label: 'Formatos export.' },
        { icon: Shield, value: '100%', label: 'Segurança' },
        { icon: Activity, value: '24/7', label: 'Online' },
    ];

    return (
        <section className="py-12 px-6 border-y border-border/50">
            <div className="grid grid-cols-2 gap-4">
                {metrics.map((metric, index) => (
                    <motion.div
                        key={metric.label}
                        initial={{ opacity: 0, y: 10 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        transition={{ delay: index * 0.1 }}
                        className="bg-secondary-system-background rounded-2xl p-4 text-center"
                    >
                        <metric.icon className="w-6 h-6 text-brand mx-auto mb-2" />
                        <div className="text-2xl font-black text-foreground mb-1">
                            {metric.value}
                        </div>
                        <div className="text-[10px] font-bold uppercase tracking-wide text-foreground/40">
                            {metric.label}
                        </div>
                    </motion.div>
                ))}
            </div>
        </section>
    );
}
