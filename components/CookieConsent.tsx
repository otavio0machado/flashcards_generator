'use client';

import React, { useState, useEffect } from 'react';
import { Cookie, X } from 'lucide-react';

const COOKIE_CONSENT_KEY = 'cookie-consent';

type ConsentStatus = 'pending' | 'accepted' | 'rejected';

interface CookiePreferences {
    necessary: boolean;
    analytics: boolean;
    marketing: boolean;
}

export default function CookieConsent() {
    const [isVisible, setIsVisible] = useState(false);
    const [showDetails, setShowDetails] = useState(false);
    const [preferences, setPreferences] = useState<CookiePreferences>({
        necessary: true,
        analytics: true,
        marketing: false,
    });

    useEffect(() => {
        const consent = localStorage.getItem(COOKIE_CONSENT_KEY);
        if (!consent) {
            // Delay para não aparecer imediatamente
            const timer = setTimeout(() => setIsVisible(true), 1500);
            return () => clearTimeout(timer);
        }
    }, []);

    const saveConsent = (status: ConsentStatus, prefs?: CookiePreferences) => {
        const consentData = {
            status,
            preferences: prefs || preferences,
            timestamp: new Date().toISOString(),
        };
        localStorage.setItem(COOKIE_CONSENT_KEY, JSON.stringify(consentData));
        setIsVisible(false);

        // Disparar evento para que outros componentes possam reagir
        window.dispatchEvent(new CustomEvent('cookie-consent-updated', { detail: consentData }));
    };

    const handleAcceptAll = () => {
        const allAccepted = { necessary: true, analytics: true, marketing: true };
        setPreferences(allAccepted);
        saveConsent('accepted', allAccepted);
    };

    const handleRejectAll = () => {
        const onlyNecessary = { necessary: true, analytics: false, marketing: false };
        setPreferences(onlyNecessary);
        saveConsent('rejected', onlyNecessary);
    };

    const handleSavePreferences = () => {
        saveConsent('accepted', preferences);
    };

    if (!isVisible) return null;

    return (
        <div
            className="fixed bottom-0 left-0 right-0 z-[9999] p-4 animate-in slide-in-from-bottom duration-300"
            role="dialog"
            aria-modal="true"
            aria-labelledby="cookie-consent-title"
        >
            <div className="max-w-4xl mx-auto bg-white border border-border rounded-lg shadow-2xl overflow-hidden">
                <div className="p-6">
                    <div className="flex items-start gap-4">
                        <div className="hidden sm:flex h-12 w-12 bg-brand/10 rounded-full items-center justify-center flex-shrink-0">
                            <Cookie className="h-6 w-6 text-brand" aria-hidden="true" />
                        </div>

                        <div className="flex-1">
                            <h2 id="cookie-consent-title" className="text-lg font-bold text-foreground mb-2">
                                Cookies e Privacidade
                            </h2>
                            <p className="text-sm text-foreground/70 mb-4">
                                Usamos cookies para melhorar sua experiencia e analisar o uso do site.
                                Voce pode escolher quais cookies aceitar.
                            </p>

                            {showDetails && (
                                <div className="space-y-3 mb-4 p-4 bg-gray-50 rounded-lg">
                                    <label className="flex items-center gap-3 cursor-not-allowed">
                                        <input
                                            type="checkbox"
                                            checked={preferences.necessary}
                                            disabled
                                            className="h-4 w-4 rounded border-gray-300"
                                        />
                                        <div>
                                            <span className="font-medium text-foreground">Necessarios</span>
                                            <p className="text-xs text-foreground/60">Essenciais para o funcionamento do site</p>
                                        </div>
                                    </label>

                                    <label className="flex items-center gap-3 cursor-pointer">
                                        <input
                                            type="checkbox"
                                            checked={preferences.analytics}
                                            onChange={(e) => setPreferences(p => ({ ...p, analytics: e.target.checked }))}
                                            className="h-4 w-4 rounded border-gray-300 text-brand focus:ring-brand"
                                        />
                                        <div>
                                            <span className="font-medium text-foreground">Analytics</span>
                                            <p className="text-xs text-foreground/60">Nos ajudam a entender como voce usa o site</p>
                                        </div>
                                    </label>

                                    <label className="flex items-center gap-3 cursor-pointer">
                                        <input
                                            type="checkbox"
                                            checked={preferences.marketing}
                                            onChange={(e) => setPreferences(p => ({ ...p, marketing: e.target.checked }))}
                                            className="h-4 w-4 rounded border-gray-300 text-brand focus:ring-brand"
                                        />
                                        <div>
                                            <span className="font-medium text-foreground">Marketing</span>
                                            <p className="text-xs text-foreground/60">Permitem publicidade personalizada</p>
                                        </div>
                                    </label>
                                </div>
                            )}

                            <div className="flex flex-wrap gap-3">
                                {showDetails ? (
                                    <>
                                        <button
                                            onClick={handleSavePreferences}
                                            className="px-4 py-2 bg-brand text-white font-medium rounded-md hover:bg-brand/90 transition-colors"
                                        >
                                            Salvar preferencias
                                        </button>
                                        <button
                                            onClick={() => setShowDetails(false)}
                                            className="px-4 py-2 text-foreground/60 font-medium hover:text-foreground transition-colors"
                                        >
                                            Voltar
                                        </button>
                                    </>
                                ) : (
                                    <>
                                        <button
                                            onClick={handleAcceptAll}
                                            className="px-4 py-2 bg-brand text-white font-medium rounded-md hover:bg-brand/90 transition-colors"
                                        >
                                            Aceitar todos
                                        </button>
                                        <button
                                            onClick={handleRejectAll}
                                            className="px-4 py-2 border border-border text-foreground font-medium rounded-md hover:bg-gray-50 transition-colors"
                                        >
                                            Apenas necessarios
                                        </button>
                                        <button
                                            onClick={() => setShowDetails(true)}
                                            className="px-4 py-2 text-foreground/60 font-medium hover:text-foreground transition-colors"
                                        >
                                            Personalizar
                                        </button>
                                    </>
                                )}
                            </div>
                        </div>

                        <button
                            onClick={handleRejectAll}
                            className="text-foreground/40 hover:text-foreground transition-colors flex-shrink-0"
                            aria-label="Fechar e usar apenas cookies necessarios"
                        >
                            <X className="h-5 w-5" aria-hidden="true" />
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}

/**
 * Hook para verificar se o usuario aceitou analytics
 */
export function useAnalyticsConsent(): boolean {
    const [hasConsent, setHasConsent] = useState(false);

    useEffect(() => {
        const checkConsent = () => {
            const consent = localStorage.getItem(COOKIE_CONSENT_KEY);
            if (consent) {
                try {
                    const data = JSON.parse(consent);
                    setHasConsent(data.preferences?.analytics === true);
                } catch {
                    setHasConsent(false);
                }
            }
        };

        checkConsent();

        const handleConsentUpdate = () => checkConsent();
        window.addEventListener('cookie-consent-updated', handleConsentUpdate);

        return () => {
            window.removeEventListener('cookie-consent-updated', handleConsentUpdate);
        };
    }, []);

    return hasConsent;
}
