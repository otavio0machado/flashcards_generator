/**
 * SM-2 Spaced Repetition Algorithm
 *
 * Implementation of the SuperMemo SM-2 algorithm for scheduling flashcard reviews.
 * This mirrors the server-side logic in the `update_card_progress` Supabase RPC
 * so the client can compute expected intervals for UI display (e.g. "next review in 6 days").
 *
 * Reference: https://www.supermemo.com/en/archives1990-2015/english/ol/sm2
 */

export interface SRSCardData {
    easeFactor: number;   // EF >= 1.3, default 2.5
    interval: number;     // days, default 0
    repetitions: number;  // successful reps in a row, default 0
}

export interface SRSResult {
    nextReview: Date;
    easeFactor: number;
    interval: number;
    repetitions: number;
}

const DEFAULT_EASE_FACTOR = 2.5;
const MIN_EASE_FACTOR = 1.3;

/**
 * Compute the next review schedule using the SM-2 algorithm.
 *
 * @param card - Current SRS state of the card (easeFactor, interval, repetitions).
 *               If undefined/partial, defaults are used (new card).
 * @param quality - Review quality rating from 0 to 5.
 *                  0 = complete blackout, 3 = hard, 4 = good, 5 = easy.
 * @returns The new SRS state including the computed next review date.
 */
export function computeSRS(
    card: Partial<SRSCardData> | undefined,
    quality: number
): SRSResult {
    const q = Math.min(Math.max(Math.round(quality), 0), 5);

    const oldEF = card?.easeFactor ?? DEFAULT_EASE_FACTOR;
    const oldInterval = card?.interval ?? 0;
    const oldReps = card?.repetitions ?? 0;

    let newReps: number;
    let newInterval: number;

    if (q < 3) {
        // Failed review: reset repetition count, review again tomorrow
        newReps = 0;
        newInterval = 1;
    } else {
        // Successful review
        if (oldReps === 0) {
            newInterval = 1;
        } else if (oldReps === 1) {
            newInterval = 6;
        } else {
            newInterval = Math.round(oldInterval * oldEF);
        }
        newReps = oldReps + 1;
    }

    // Update ease factor regardless of pass/fail
    let newEF = oldEF + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02));
    if (newEF < MIN_EASE_FACTOR) {
        newEF = MIN_EASE_FACTOR;
    }

    const nextReview = new Date();
    nextReview.setDate(nextReview.getDate() + newInterval);

    return {
        nextReview,
        easeFactor: newEF,
        interval: newInterval,
        repetitions: newReps,
    };
}

/**
 * Preview the interval (in days) for each quality option without mutating state.
 * Useful for showing "1d / 6d / 15d / 15d" labels on review buttons.
 */
export function previewIntervals(
    card: Partial<SRSCardData> | undefined
): Record<number, number> {
    const qualities = [0, 3, 4, 5];
    const result: Record<number, number> = {};
    for (const q of qualities) {
        result[q] = computeSRS(card, q).interval;
    }
    return result;
}

/**
 * Format an interval in days into a human-readable label.
 */
export function formatInterval(days: number): string {
    if (days <= 0) return '<1d';
    if (days === 1) return '1d';
    if (days < 30) return `${days}d`;
    if (days < 365) {
        const months = Math.round(days / 30);
        return months <= 1 ? '1m' : `${months}m`;
    }
    const years = (days / 365).toFixed(1).replace(/\.0$/, '');
    return `${years}a`;
}
