'use client';

import { getMobilePreferences } from './mobile-preferences';

export type HapticPattern =
    | 'tap'        // Light tap - card flip, selection
    | 'success'    // Double pulse - correct answer, good review
    | 'warning'    // Strong pulse - wrong answer, again review
    | 'impact'     // Heavy impact - form submission, important action
    | 'selection'; // Very light - tab switch, minor interaction

// Vibration patterns in milliseconds
// Single number = duration, Array = [vibrate, pause, vibrate, ...]
const PATTERNS: Record<HapticPattern, Record<'light' | 'medium' | 'strong', number | number[]>> = {
    tap: {
        light: 5,
        medium: 10,
        strong: 20,
    },
    success: {
        light: [5, 30, 5],
        medium: [10, 50, 10],
        strong: [15, 60, 15],
    },
    warning: {
        light: [20, 20, 40],
        medium: [30, 30, 60],
        strong: [50, 40, 80],
    },
    impact: {
        light: 20,
        medium: 40,
        strong: 60,
    },
    selection: {
        light: 3,
        medium: 5,
        strong: 8,
    },
};

function canVibrate(): boolean {
    return typeof navigator !== 'undefined' && 'vibrate' in navigator;
}

export function haptic(pattern: HapticPattern): void {
    if (!canVibrate()) return;

    const prefs = getMobilePreferences();

    if (!prefs.hapticFeedbackEnabled) return;

    const intensity = prefs.hapticIntensity;
    const vibrationPattern = PATTERNS[pattern][intensity];

    try {
        navigator.vibrate(vibrationPattern);
    } catch (error) {
        // Silently fail - haptics are not critical
        console.debug('Haptic feedback failed:', error);
    }
}

export function useHaptic(): (pattern: HapticPattern) => void {
    return haptic;
}

// Convenience functions for common patterns
export const haptics = {
    tap: () => haptic('tap'),
    success: () => haptic('success'),
    warning: () => haptic('warning'),
    impact: () => haptic('impact'),
    selection: () => haptic('selection'),
};
