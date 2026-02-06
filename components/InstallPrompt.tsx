'use client';

import React, { useEffect, useState } from 'react';
import { LazyMotion, domAnimation, m, AnimatePresence } from 'framer-motion';
import { Download, X, Smartphone } from 'lucide-react';
import { trackEvent } from '@/lib/analytics';
import { usePWA } from '@/lib/pwa';

export default function InstallPrompt() {
    const { isStandalone, isInstallable, isIOS, promptInstall } = usePWA();
    const [showPrompt, setShowPrompt] = useState(false);
    const [isWindows, setIsWindows] = useState(false);

    useEffect(() => {
        if (isStandalone) return;

        const ua = navigator.userAgent.toLowerCase();
        const windows = ua.includes('windows');
        setIsWindows(windows);

        // Check if user dismissed the prompt before
        const dismissed = localStorage.getItem('pwa-prompt-dismissed');
        const dismissedAt = dismissed ? parseInt(dismissed, 10) : 0;
        const daysSinceDismissed = (Date.now() - dismissedAt) / (1000 * 60 * 60 * 24);

        if (dismissed && daysSinceDismissed < 7) return;

        // Determine delay based on platform
        let delay: number;
        let eventName: string;
        let platform: string;

        if (windows) {
            delay = 15000;
            eventName = 'desktop_install_prompt_shown';
            platform = 'windows';
        } else if (isIOS) {
            delay = 60000;
            eventName = 'pwa_install_prompt_shown';
            platform = 'ios';
        } else {
            delay = 30000;
            eventName = 'pwa_install_prompt_shown';
            platform = 'android';
        }

        const timer = setTimeout(() => {
            setShowPrompt(true);
            trackEvent(eventName, { platform });
        }, delay);

        return () => clearTimeout(timer);
    }, [isStandalone, isIOS]);

    const handleInstall = async () => {
        if (isWindows) {
            trackEvent('desktop_install_clicked', { platform: 'windows' });
            window.location.href = 'https://github.com/otavio0machado/flashcards_generator/releases/download/v1.0.4/Flashcards.Generator_1.0.4_x64-setup.exe';
            handleDismiss();
            return;
        }

        trackEvent('pwa_install_clicked', { platform: 'android' });
        const outcome = await promptInstall();

        if (outcome === 'accepted') {
            trackEvent('pwa_installed', { platform: 'android' });
        } else {
            trackEvent('pwa_install_dismissed', { platform: 'android' });
        }

        setShowPrompt(false);
    };

    const handleDismiss = () => {
        localStorage.setItem('pwa-prompt-dismissed', Date.now().toString());
        setShowPrompt(false);
        trackEvent('pwa_prompt_dismissed', { platform: isIOS ? 'ios' : isWindows ? 'windows' : 'android' });
    };

    if (isStandalone) return null;

    return (
        <LazyMotion features={domAnimation}>
            <AnimatePresence>
                {showPrompt && (
                    <m.div
                        initial={{ opacity: 0, y: 100 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: 100 }}
                        transition={{ type: 'spring', damping: 25, stiffness: 300 }}
                        className="fixed bottom-4 left-4 right-4 z-[200] md:left-auto md:right-4 md:w-[380px]"
                    >
                        <div className="bg-white border border-border rounded-sm shadow-2xl overflow-hidden">
                            {/* Header */}
                            <div className="bg-brand/5 border-b border-border p-4 flex items-center justify-between">
                                <div className="flex items-center gap-3">
                                    <div className="bg-brand/10 p-2 rounded-sm">
                                        <Smartphone className="h-5 w-5 text-brand" />
                                    </div>
                                    <div>
                                        <h3 className="font-bold text-sm">Instalar Flashcards</h3>
                                        <p className="text-[10px] font-medium text-foreground/50">
                                            {isWindows ? 'Versao Desktop Oficial' : 'Acesse mais rapido'}
                                        </p>
                                    </div>
                                </div>
                                <button
                                    onClick={handleDismiss}
                                    className="text-foreground/30 hover:text-foreground/60 transition-colors p-1"
                                    aria-label="Fechar"
                                >
                                    <X className="h-5 w-5" />
                                </button>
                            </div>

                            {/* Content */}
                            <div className="p-4">
                                {isIOS ? (
                                    <div className="space-y-3">
                                        <p className="text-sm text-foreground/70 font-medium">
                                            Adicione a tela inicial para acesso rapido:
                                        </p>
                                        <ol className="text-xs text-foreground/60 space-y-2">
                                            <li className="flex items-center gap-2">
                                                <span className="bg-gray-100 w-5 h-5 rounded-sm flex items-center justify-center text-[10px] font-bold">1</span>
                                                Toque no icone de <strong>compartilhar</strong>
                                            </li>
                                            <li className="flex items-center gap-2">
                                                <span className="bg-gray-100 w-5 h-5 rounded-sm flex items-center justify-center text-[10px] font-bold">2</span>
                                                Role e toque em <strong>&quot;Adicionar a Tela de Inicio&quot;</strong>
                                            </li>
                                            <li className="flex items-center gap-2">
                                                <span className="bg-gray-100 w-5 h-5 rounded-sm flex items-center justify-center text-[10px] font-bold">3</span>
                                                Toque em <strong>&quot;Adicionar&quot;</strong>
                                            </li>
                                        </ol>
                                        <button
                                            onClick={handleDismiss}
                                            className="w-full bg-gray-100 text-foreground/70 py-2 rounded-sm text-xs font-bold hover:bg-gray-200 transition-all"
                                        >
                                            Entendi
                                        </button>
                                    </div>
                                ) : (
                                    <div className="space-y-3">
                                        <p className="text-sm text-foreground/70 font-medium">
                                            {isWindows
                                                ? 'Baixe o app oficial para Windows para melhor performance.'
                                                : 'Instale o app para estudar offline e receber lembretes!'}
                                        </p>
                                        <div className="flex gap-2">
                                            <button
                                                onClick={handleDismiss}
                                                className="flex-1 bg-gray-100 text-foreground/60 py-2.5 rounded-sm text-xs font-bold hover:bg-gray-200 transition-all"
                                            >
                                                Agora nao
                                            </button>
                                            <button
                                                onClick={handleInstall}
                                                className="flex-1 bg-brand text-white py-2.5 rounded-sm text-xs font-bold hover:bg-brand/90 transition-all flex items-center justify-center gap-2 shadow-lg shadow-brand/20"
                                            >
                                                <Download className="h-3.5 w-3.5" />
                                                {isWindows ? 'Baixar .EXE' : 'Instalar'}
                                            </button>
                                        </div>
                                    </div>
                                )}
                            </div>

                            {/* Benefits */}
                            <div className="bg-gray-50 border-t border-border px-4 py-3">
                                <div className="flex items-center justify-between text-[10px] font-medium text-foreground/40">
                                    <span>Acesso offline</span>
                                    <span>Carregamento rapido</span>
                                    <span>Sem anuncios</span>
                                </div>
                            </div>
                        </div>
                    </m.div>
                )}
            </AnimatePresence>
        </LazyMotion>
    );
}
