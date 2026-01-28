'use client';

import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';
import {
    Download,
    Monitor,
    Smartphone,
    Check,
    Zap,
    Shield,
    Cloud,
    CheckCircle2
} from 'lucide-react';
import Link from 'next/link';
import { isTauriApp } from '@/lib/tauri';

const GITHUB_RELEASES_BASE = 'https://github.com/otavio0machado/flashcards_generator/releases/latest/download';

interface Platform {
    name: string;
    icon: typeof Monitor;
    description: string;
    downloadUrl: string;
    available: boolean;
    fileType?: string;
    size?: string;
    comingSoon?: boolean;
    store?: string;
    osKey?: string;
}

const platforms: Platform[] = [
    {
        name: 'Windows',
        icon: Monitor,
        description: 'Windows 10 ou superior',
        downloadUrl: `${GITHUB_RELEASES_BASE}/Flashcards.Generator_1.0.3_x64-setup.exe`,
        available: true,
        fileType: '.exe',
        size: '~80 MB',
        osKey: 'windows',
    },
    {
        name: 'macOS',
        icon: Monitor,
        description: 'macOS 11 Big Sur ou superior',
        downloadUrl: '#',
        available: false,
        comingSoon: true,
    },
    {
        name: 'Linux',
        icon: Monitor,
        description: 'Ubuntu 20.04+, Fedora 36+',
        downloadUrl: '#',
        available: false,
        comingSoon: true,
    },
    {
        name: 'iOS',
        icon: Smartphone,
        description: 'iPhone e iPad',
        downloadUrl: '#',
        available: false,
        comingSoon: true,
        store: 'App Store',
    },
    {
        name: 'Android',
        icon: Smartphone,
        description: 'Android 8.0 ou superior',
        downloadUrl: '#',
        available: false,
        comingSoon: true,
        store: 'Google Play',
    },
];

const benefits = [
    'Performance nativa otimizada',
    'Modo offline disponível',
    'Sincronização automática',
    'Notificações de estudo',
    'Atalhos de teclado',
];

function detectOS(): string | null {
    if (typeof navigator === 'undefined') return null;
    const ua = navigator.userAgent.toLowerCase();
    if (ua.includes('win')) return 'windows';
    if (ua.includes('mac')) return 'macos';
    if (ua.includes('linux')) return 'linux';
    if (ua.includes('android')) return 'android';
    if (ua.includes('iphone') || ua.includes('ipad')) return 'ios';
    return null;
}

export default function DownloadPage() {
    const [detectedOS, setDetectedOS] = useState<string | null>(null);
    const [isDesktopApp, setIsDesktopApp] = useState(false);

    useEffect(() => {
        setDetectedOS(detectOS());
        setIsDesktopApp(isTauriApp());
    }, []);

    // Sort platforms: detected OS first, then available, then coming soon
    const sortedPlatforms = [...platforms].sort((a, b) => {
        if (a.osKey === detectedOS && b.osKey !== detectedOS) return -1;
        if (b.osKey === detectedOS && a.osKey !== detectedOS) return 1;
        if (a.available && !b.available) return -1;
        if (!a.available && b.available) return 1;
        return 0;
    });

    // If inside Tauri, show a different view
    if (isDesktopApp) {
        return (
            <div className="min-h-screen bg-[var(--background)] flex items-center justify-center p-6">
                <div className="text-center max-w-md">
                    <div className="mx-auto mb-6 w-16 h-16 bg-green-100 dark:bg-green-900/30 rounded-2xl flex items-center justify-center">
                        <CheckCircle2 className="w-8 h-8 text-green-600 dark:text-green-400" />
                    </div>
                    <h1 className="text-2xl font-bold text-[var(--foreground)] mb-3">
                        Você já está usando o app desktop!
                    </h1>
                    <p className="text-[var(--color-text-secondary)] mb-6">
                        Aproveite todos os recursos nativos do Flashcards Generator.
                    </p>
                    <Link
                        href="/app"
                        className="inline-flex items-center gap-2 px-6 py-3 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 focus:ring-2 focus:ring-brand focus:ring-offset-2 transition-colors"
                    >
                        Ir para o App
                    </Link>
                </div>
            </div>
        );
    }

    return (
        <div className="min-h-screen bg-background">
            {/* Hero Section */}
            <section className="pt-32 pb-16 px-4">
                <div className="max-w-4xl mx-auto text-center">
                    <motion.h1
                        initial={{ opacity: 0, y: 16 }}
                        animate={{ opacity: 1, y: 0 }}
                        className="text-4xl md:text-5xl font-bold text-foreground mb-4 tracking-tight"
                    >
                        Download
                    </motion.h1>

                    <motion.p
                        initial={{ opacity: 0, y: 16 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ delay: 0.1 }}
                        className="text-lg text-[var(--color-text-secondary)] max-w-xl mx-auto mb-12"
                    >
                        Baixe o aplicativo nativo para desktop ou mobile.
                    </motion.p>

                    {/* Benefits List */}
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        transition={{ delay: 0.2 }}
                        className="flex flex-wrap justify-center gap-x-6 gap-y-2 mb-16"
                    >
                        {benefits.map((benefit, index) => (
                            <div key={index} className="flex items-center gap-2 text-sm text-[var(--color-text-secondary)]">
                                <Check className="w-4 h-4 text-brand" />
                                <span>{benefit}</span>
                            </div>
                        ))}
                    </motion.div>
                </div>
            </section>

            {/* Download Cards */}
            <section className="pb-24 px-4">
                <div className="max-w-4xl mx-auto">
                    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
                        {sortedPlatforms.map((platform, index) => {
                            const isRecommended = platform.osKey === detectedOS;

                            return (
                                <motion.div
                                    key={platform.name}
                                    initial={{ opacity: 0, y: 12 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.1 * index }}
                                    className={`relative p-6 rounded-xl border transition-colors ${isRecommended
                                        ? 'bg-surface border-brand shadow-lg shadow-brand/10'
                                        : platform.available
                                            ? 'bg-surface border-border hover:border-brand/50'
                                            : 'bg-surface-muted border-border opacity-60'
                                        }`}
                                >
                                    {isRecommended && (
                                        <div className="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-1 bg-brand text-white text-xs font-semibold rounded-full whitespace-nowrap">
                                            Recomendado para você
                                        </div>
                                    )}
                                    {platform.comingSoon && (
                                        <div className="absolute top-4 right-4 px-2.5 py-1 bg-amber-100 dark:bg-amber-900/30 text-amber-700 dark:text-amber-400 text-xs font-medium rounded">
                                            Em breve
                                        </div>
                                    )}

                                    <div className="flex flex-col items-center text-center">
                                        <div className={`w-12 h-12 rounded-lg flex items-center justify-center mb-3 ${platform.available
                                            ? 'bg-brand text-white'
                                            : 'bg-border text-[var(--color-text-secondary)]'
                                            }`}>
                                            <platform.icon className="w-6 h-6" />
                                        </div>

                                        <h3 className="text-lg font-bold text-foreground mb-0.5">
                                            {platform.name}
                                        </h3>
                                        <p className="text-sm text-[var(--color-text-secondary)] mb-3">
                                            {platform.description}
                                        </p>

                                        {platform.available ? (
                                            <>
                                                <div className="flex items-center gap-3 text-xs text-[var(--color-text-secondary)] mb-3">
                                                    <span>{platform.fileType}</span>
                                                    <span>&middot;</span>
                                                    <span>{platform.size}</span>
                                                </div>
                                                <a
                                                    href={platform.downloadUrl}
                                                    className="inline-flex items-center gap-2 px-5 py-2.5 bg-brand text-white font-semibold rounded-lg hover:bg-brand/90 transition-colors text-sm"
                                                >
                                                    <Download className="w-4 h-4" />
                                                    <span>Download para {platform.name}</span>
                                                </a>
                                            </>
                                        ) : (
                                            <p className="text-sm text-[var(--color-text-secondary)]">
                                                Disponível em breve na {platform.store}
                                            </p>
                                        )}
                                    </div>
                                </motion.div>
                            );
                        })}
                    </div>

                    {/* Installation Help (SmartScreen) */}
                    <div className="mt-12 bg-amber-50 dark:bg-amber-950/20 border border-amber-200 dark:border-amber-900/50 rounded-xl p-6">
                        <div className="flex items-start gap-4">
                            <div className="p-2 bg-amber-100 dark:bg-amber-900/40 rounded-lg shrink-0">
                                <Shield className="w-6 h-6 text-amber-700 dark:text-amber-400" />
                            </div>
                            <div>
                                <h3 className="text-lg font-semibold text-amber-900 dark:text-amber-200 mb-2">
                                    Apareceu um aviso do Windows ("SmartScreen")?
                                </h3>
                                <p className="text-amber-800 dark:text-amber-300/90 text-sm mb-4">
                                    Isso é comum em aplicativos novos que ainda não possuem milhares de downloads. O app é 100% seguro e livre de vírus.
                                </p>
                                <ol className="list-decimal list-inside space-y-2 text-sm text-amber-800 dark:text-amber-300/80 font-medium">
                                    <li>Clique no link <span className="font-bold underline">Mais informações</span> (no pop-up azul)</li>
                                    <li>Depois clique no botão <span className="font-bold">Executar assim mesmo</span></li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            {/* Features Section */}
            <section className="py-16 px-4 bg-surface-muted dark:bg-[#151A1E]">
                <div className="max-w-4xl mx-auto">
                    <h2 className="text-2xl font-bold text-foreground mb-8 text-center tracking-tight">
                        Por que usar o aplicativo?
                    </h2>

                    <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
                        {[
                            { icon: Zap, title: 'Rápido', description: 'Acesso instantâneo sem abrir navegador' },
                            { icon: Shield, title: 'Offline', description: 'Estude sem conexão com internet' },
                            { icon: Cloud, title: 'Sincronizado', description: 'Seus dados em todos os dispositivos' },
                        ].map((item, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, y: 12 }}
                                whileInView={{ opacity: 1, y: 0 }}
                                viewport={{ once: true }}
                                transition={{ delay: index * 0.1 }}
                                className="p-5 bg-surface rounded-xl border border-border text-center"
                            >
                                <div className="w-10 h-10 bg-brand/10 rounded-lg flex items-center justify-center mb-3 mx-auto">
                                    <item.icon className="w-5 h-5 text-brand" />
                                </div>
                                <h3 className="font-semibold text-foreground mb-1">
                                    {item.title}
                                </h3>
                                <p className="text-sm text-[var(--color-text-secondary)]">
                                    {item.description}
                                </p>
                            </motion.div>
                        ))}
                    </div>
                </div>
            </section>

            {/* CTA Section */}
            <section className="py-16 px-4">
                <div className="max-w-2xl mx-auto text-center">
                    <h2 className="text-xl font-bold text-foreground mb-3 tracking-tight">
                        Prefere usar no navegador?
                    </h2>
                    <p className="text-[var(--color-text-secondary)] mb-6 text-sm">
                        Use o Flashcards Generator diretamente no navegador, sem precisar baixar nada.
                    </p>
                    <Link
                        href="/app"
                        className="inline-flex items-center gap-2 px-5 py-2.5 bg-foreground text-background font-semibold rounded-lg hover:opacity-90 transition-opacity text-sm"
                    >
                        <span>Usar no Navegador</span>
                    </Link>
                </div>
            </section>
        </div>
    );
}
