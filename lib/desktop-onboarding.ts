'use client';

import { useEffect, useState, useRef, useCallback } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { isTauriApp } from '@/lib/tauri';
import { supabase } from '@/lib/supabase';

// --- Step tracking ---

export type OnboardingStep = 'welcome' | 'features' | 'plans' | 'login' | 'complete';

const ONBOARDING_COMPLETE_KEY = 'desktop_onboarding_complete';
const ONBOARDING_STEP_KEY = 'desktop_onboarding_step';

export function getOnboardingStep(): OnboardingStep {
    if (typeof window === 'undefined') return 'welcome';
    return (localStorage.getItem(ONBOARDING_STEP_KEY) as OnboardingStep) || 'welcome';
}

export function setOnboardingStep(step: OnboardingStep) {
    if (typeof window !== 'undefined') {
        localStorage.setItem(ONBOARDING_STEP_KEY, step);
    }
}

export function isOnboardingComplete(): boolean {
    if (typeof window === 'undefined') return false;
    return localStorage.getItem(ONBOARDING_COMPLETE_KEY) === 'true';
}

export function completeOnboarding() {
    if (typeof window !== 'undefined') {
        localStorage.setItem(ONBOARDING_COMPLETE_KEY, 'true');
        localStorage.setItem(ONBOARDING_STEP_KEY, 'complete');
    }
}

export function resetOnboarding() {
    if (typeof window !== 'undefined') {
        localStorage.removeItem(ONBOARDING_COMPLETE_KEY);
        localStorage.removeItem(ONBOARDING_STEP_KEY);
    }
}

export function skipOnboarding() {
    completeOnboarding();
}

// --- Main hook ---

export function useDesktopOnboarding() {
    const [needsOnboarding, setNeedsOnboarding] = useState<boolean | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const router = useRouter();
    const pathname = usePathname();
    const pathnameRef = useRef(pathname);
    const routerRef = useRef(router);
    const hasCheckedRef = useRef(false);

    // Keep refs current without triggering effect re-runs
    pathnameRef.current = pathname;
    routerRef.current = router;

    const checkOnboardingStatus = useCallback(async () => {
        // Only runs in Tauri environment
        if (!isTauriApp()) {
            setNeedsOnboarding(false);
            setIsLoading(false);
            return;
        }

        try {
            const onboardingComplete = isOnboardingComplete();
            const { data: { session }, error } = await supabase.auth.getSession();

            if (error) {
                console.warn('[desktop-onboarding] Session check failed:', error.message);
            }

            const currentPath = pathnameRef.current;
            const nav = routerRef.current;

            if (onboardingComplete && session) {
                // Onboarding done + logged in → go to app
                setNeedsOnboarding(false);

                if (currentPath?.startsWith('/desktop/')) {
                    nav.replace('/app');
                }
            } else if (!onboardingComplete) {
                // First launch — needs onboarding
                setNeedsOnboarding(true);

                if (!currentPath?.startsWith('/desktop/')) {
                    const savedStep = getOnboardingStep();
                    const stepRoutes: Record<OnboardingStep, string> = {
                        welcome: '/desktop/welcome',
                        features: '/desktop/features',
                        plans: '/desktop/plans',
                        login: '/desktop/login',
                        complete: '/app',
                    };
                    nav.replace(stepRoutes[savedStep] || '/desktop/welcome');
                }
            } else {
                // Onboarding complete but not logged in
                setNeedsOnboarding(false);
            }
        } catch (err) {
            console.error('[desktop-onboarding] Error checking status:', err);
            setNeedsOnboarding(false);
        } finally {
            setIsLoading(false);
        }
    }, []);

    useEffect(() => {
        if (hasCheckedRef.current) return;
        hasCheckedRef.current = true;
        checkOnboardingStatus();
    }, [checkOnboardingStatus]);

    return { needsOnboarding, isLoading };
}
