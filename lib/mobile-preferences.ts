'use client';

import { useState, useEffect, useCallback } from 'react';

export interface MobilePreferences {
    swipeGesturesEnabled: boolean;
    swipeToFlipEnabled: boolean;
    swipeToReviewEnabled: boolean;
    hapticFeedbackEnabled: boolean;
    hapticIntensity: 'light' | 'medium' | 'strong';
    reducedMotion: boolean;
}

const STORAGE_KEY = 'flashcards_mobile_preferences';

const DEFAULT_PREFERENCES: MobilePreferences = {
    swipeGesturesEnabled: true,
    swipeToFlipEnabled: true,
    swipeToReviewEnabled: true,
    hapticFeedbackEnabled: true,
    hapticIntensity: 'medium',
    reducedMotion: false,
};

function getSystemReducedMotion(): boolean {
    if (typeof window === 'undefined') return false;
    return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
}

export function getMobilePreferences(): MobilePreferences {
    if (typeof window === 'undefined') {
        return DEFAULT_PREFERENCES;
    }

    try {
        const stored = localStorage.getItem(STORAGE_KEY);
        if (stored) {
            const parsed = JSON.parse(stored) as Partial<MobilePreferences>;
            return {
                ...DEFAULT_PREFERENCES,
                ...parsed,
                // Always check system preference for reduced motion
                reducedMotion: parsed.reducedMotion ?? getSystemReducedMotion(),
            };
        }
    } catch (error) {
        console.warn('Failed to load mobile preferences:', error);
    }

    return {
        ...DEFAULT_PREFERENCES,
        reducedMotion: getSystemReducedMotion(),
    };
}

export function setMobilePreferences(prefs: Partial<MobilePreferences>): MobilePreferences {
    const current = getMobilePreferences();
    const updated = { ...current, ...prefs };

    try {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
    } catch (error) {
        console.warn('Failed to save mobile preferences:', error);
    }

    // Dispatch event for other components to react
    if (typeof window !== 'undefined') {
        window.dispatchEvent(new CustomEvent('mobile-preferences-changed', { detail: updated }));
    }

    return updated;
}

export function useMobilePreferences(): [MobilePreferences, (prefs: Partial<MobilePreferences>) => void] {
    const [preferences, setPreferences] = useState<MobilePreferences>(DEFAULT_PREFERENCES);

    useEffect(() => {
        // Load initial preferences
        setPreferences(getMobilePreferences());

        // Listen for system reduced motion changes
        const mediaQuery = window.matchMedia('(prefers-reduced-motion: reduce)');
        const handleMotionChange = (e: MediaQueryListEvent) => {
            setPreferences(prev => ({ ...prev, reducedMotion: e.matches }));
        };

        mediaQuery.addEventListener('change', handleMotionChange);

        // Listen for preference changes from other components
        const handlePrefsChange = (e: CustomEvent<MobilePreferences>) => {
            setPreferences(e.detail);
        };

        window.addEventListener('mobile-preferences-changed', handlePrefsChange as EventListener);

        return () => {
            mediaQuery.removeEventListener('change', handleMotionChange);
            window.removeEventListener('mobile-preferences-changed', handlePrefsChange as EventListener);
        };
    }, []);

    const updatePreferences = useCallback((prefs: Partial<MobilePreferences>) => {
        const updated = setMobilePreferences(prefs);
        setPreferences(updated);
    }, []);

    return [preferences, updatePreferences];
}
