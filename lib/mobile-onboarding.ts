'use client';

import { useEffect, useState, useRef, useCallback } from 'react';
import { useRouter, usePathname } from 'next/navigation';
import { isTauriApp } from '@/lib/tauri';
import { supabase } from '@/lib/supabase';

// --- Step tracking ---

export type MobileOnboardingStep = 'welcome' | 'features' | 'plans' | 'login' | 'complete';

const MOBILE_ONBOARDING_COMPLETE_KEY = 'mobile_onboarding_complete';
const MOBILE_ONBOARDING_STEP_KEY = 'mobile_onboarding_step';

export function getMobileOnboardingStep(): MobileOnboardingStep {
    if (typeof window === 'undefined') return 'welcome';
    return (localStorage.getItem(MOBILE_ONBOARDING_STEP_KEY) as MobileOnboardingStep) || 'welcome';
}

export function setMobileOnboardingStep(step: MobileOnboardingStep) {
    if (typeof window !== 'undefined') {
        localStorage.setItem(MOBILE_ONBOARDING_STEP_KEY, step);
    }
}

export function isMobileOnboardingComplete(): boolean {
    if (typeof window === 'undefined') return false;
    return localStorage.getItem(MOBILE_ONBOARDING_COMPLETE_KEY) === 'true';
}

export function completeMobileOnboarding() {
    if (typeof window !== 'undefined') {
        localStorage.setItem(MOBILE_ONBOARDING_COMPLETE_KEY, 'true');
        localStorage.setItem(MOBILE_ONBOARDING_STEP_KEY, 'complete');
    }
}

export function resetMobileOnboarding() {
    if (typeof window !== 'undefined') {
        localStorage.removeItem(MOBILE_ONBOARDING_COMPLETE_KEY);
        localStorage.removeItem(MOBILE_ONBOARDING_STEP_KEY);
    }
}

export function skipMobileOnboarding() {
    completeMobileOnboarding();
}

// --- Main hook ---

export function useMobileOnboarding() {
    const [needsOnboarding, setNeedsOnboarding] = useState<boolean | null>(null);
    const [isLoading, setIsLoading] = useState(true);
    const router = useRouter();
    const pathname = usePathname();
    const pathnameRef = useRef(pathname);
    const routerRef = useRef(router);
    const hasCheckedRef = useRef(false);

    pathnameRef.current = pathname;
    routerRef.current = router;

    const checkOnboardingStatus = useCallback(async () => {
        if (!isTauriApp()) {
            setNeedsOnboarding(false);
            setIsLoading(false);
            return;
        }

        try {
            const onboardingComplete = isMobileOnboardingComplete();
            const { data: { session }, error } = await supabase.auth.getSession();

            if (error) {
                console.warn('[mobile-onboarding] Session check failed:', error.message);
            }

            const currentPath = pathnameRef.current;
            const nav = routerRef.current;

            if (onboardingComplete && session) {
                setNeedsOnboarding(false);

                if (currentPath?.startsWith('/mobile/')) {
                    nav.replace('/app');
                }
            } else if (!onboardingComplete) {
                setNeedsOnboarding(true);

                if (!currentPath?.startsWith('/mobile/')) {
                    const savedStep = getMobileOnboardingStep();
                    const stepRoutes: Record<MobileOnboardingStep, string> = {
                        welcome: '/mobile/welcome',
                        features: '/mobile/features',
                        plans: '/mobile/plans',
                        login: '/mobile/login',
                        complete: '/app',
                    };
                    nav.replace(stepRoutes[savedStep] || '/mobile/welcome');
                }
            } else {
                setNeedsOnboarding(false);
            }
        } catch (err) {
            console.error('[mobile-onboarding] Error checking status:', err);
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
