'use client';

import { useState, useCallback } from 'react';
import { isTauriApp } from '@/lib/tauri';

// Google Play Billing types
export interface GooglePlayProduct {
    productId: string;
    title: string;
    description: string;
    price: string;
    priceCurrencyCode: string;
}

export interface GooglePlayPurchase {
    purchaseToken: string;
    productId: string;
    orderId: string;
    purchaseState: number; // 0 = purchased, 1 = canceled, 2 = pending
    acknowledged: boolean;
}

interface BillingState {
    isAvailable: boolean;
    products: GooglePlayProduct[];
    activeSubscription: GooglePlayPurchase | null;
    loading: boolean;
    error: string | null;
}

// Product IDs — must match what's configured in Google Play Console
export const GOOGLE_PLAY_PRODUCTS = {
    PRO_MONTHLY: 'pro_monthly_subscription',
} as const;

/**
 * Hook for Google Play Billing integration.
 *
 * This communicates with a Kotlin plugin that will be created in
 * src-tauri/gen/android/app/src/main/java/.../BillingPlugin.kt
 *
 * The plugin exposes Tauri commands:
 * - `billing_query_products` → returns available products
 * - `billing_start_purchase` → initiates a purchase flow
 * - `billing_check_subscription` → checks active subscription status
 * - `billing_restore_purchases` → restores past purchases
 */
export function useGooglePlayBilling() {
    const [state, setState] = useState<BillingState>({
        isAvailable: false,
        products: [],
        activeSubscription: null,
        loading: false,
        error: null,
    });

    const invoke = useCallback(async (cmd: string, args?: Record<string, unknown>) => {
        if (!isTauriApp()) return null;
        try {
            const { invoke: tauriInvoke } = await import('@tauri-apps/api/core');
            return await tauriInvoke(cmd, args);
        } catch (err) {
            console.error(`[google-play-billing] ${cmd} failed:`, err);
            throw err;
        }
    }, []);

    const queryProducts = useCallback(async () => {
        setState(prev => ({ ...prev, loading: true, error: null }));
        try {
            const products = await invoke('billing_query_products', {
                productIds: [GOOGLE_PLAY_PRODUCTS.PRO_MONTHLY],
            }) as GooglePlayProduct[] | null;

            setState(prev => ({
                ...prev,
                isAvailable: true,
                products: products || [],
                loading: false,
            }));
            return products;
        } catch {
            setState(prev => ({
                ...prev,
                isAvailable: false,
                loading: false,
                error: 'Google Play Billing não disponível',
            }));
            return null;
        }
    }, [invoke]);

    const startPurchase = useCallback(async (productId: string) => {
        setState(prev => ({ ...prev, loading: true, error: null }));
        try {
            const purchase = await invoke('billing_start_purchase', { productId }) as GooglePlayPurchase | null;

            if (purchase) {
                // Verify purchase on server
                await verifyPurchaseOnServer(purchase);

                setState(prev => ({
                    ...prev,
                    activeSubscription: purchase,
                    loading: false,
                }));
            }
            return purchase;
        } catch (err) {
            const message = err instanceof Error ? err.message : 'Erro ao processar compra';
            setState(prev => ({ ...prev, loading: false, error: message }));
            return null;
        }
    }, [invoke]);

    const checkSubscription = useCallback(async () => {
        setState(prev => ({ ...prev, loading: true, error: null }));
        try {
            const subscription = await invoke('billing_check_subscription') as GooglePlayPurchase | null;

            setState(prev => ({
                ...prev,
                activeSubscription: subscription,
                loading: false,
            }));
            return subscription;
        } catch {
            setState(prev => ({ ...prev, loading: false }));
            return null;
        }
    }, [invoke]);

    const restorePurchases = useCallback(async () => {
        setState(prev => ({ ...prev, loading: true, error: null }));
        try {
            const purchases = await invoke('billing_restore_purchases') as GooglePlayPurchase[] | null;
            const activeSub = purchases?.find(p => p.purchaseState === 0) || null;

            if (activeSub) {
                await verifyPurchaseOnServer(activeSub);
            }

            setState(prev => ({
                ...prev,
                activeSubscription: activeSub,
                loading: false,
            }));
            return purchases;
        } catch {
            setState(prev => ({ ...prev, loading: false, error: 'Erro ao restaurar compras' }));
            return null;
        }
    }, [invoke]);

    return {
        ...state,
        queryProducts,
        startPurchase,
        checkSubscription,
        restorePurchases,
    };
}

/**
 * Verify a Google Play purchase on the server.
 * This calls our API route which validates the receipt with Google's API.
 */
async function verifyPurchaseOnServer(purchase: GooglePlayPurchase): Promise<boolean> {
    try {
        const response = await fetch('/api/google-play/verify', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                purchaseToken: purchase.purchaseToken,
                productId: purchase.productId,
                orderId: purchase.orderId,
            }),
        });

        if (!response.ok) {
            console.error('[google-play-billing] Server verification failed');
            return false;
        }

        return true;
    } catch (err) {
        console.error('[google-play-billing] Server verification error:', err);
        return false;
    }
}
