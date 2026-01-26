/**
 * Obtém o ID do preço do Stripe de forma lazy (não durante o build)
 */
function getStripePriceId(envVar: string): string {
    return process.env[envVar] || '';
}

export const STRIPE_PRICES = {
    get pro() {
        return getStripePriceId('NEXT_PUBLIC_STRIPE_PRICE_ID_PRO');
    },
    get ultimate() {
        return getStripePriceId('NEXT_PUBLIC_STRIPE_PRICE_ID_ULTIMATE');
    },
};

/**
 * Verifica se os preços do Stripe estão configurados
 */
export function hasStripePricesConfigured(): boolean {
    return Boolean(STRIPE_PRICES.pro && STRIPE_PRICES.ultimate);
}

/**
 * Valida se os preços estão configurados (usar em runtime, não build)
 */
export function validateStripePrices(): void {
    if (!STRIPE_PRICES.pro) {
        console.warn('[Config] NEXT_PUBLIC_STRIPE_PRICE_ID_PRO não configurado - checkout Pro não funcionará');
    }
    if (!STRIPE_PRICES.ultimate) {
        console.warn('[Config] NEXT_PUBLIC_STRIPE_PRICE_ID_ULTIMATE não configurado - checkout Ultimate não funcionará');
    }
}
