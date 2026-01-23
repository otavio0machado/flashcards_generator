export type PlanKey = 'free' | 'pro' | 'ultimate';

export interface PlanLimit {
    maxChars: number;
    dailyGens: number;
    allowFile: boolean;
    allowOCR: boolean;
    name: string;
    price: string;
    description: string;
    popular?: boolean;
}

export const PLAN_LIMITS: Record<PlanKey, PlanLimit> = {
    free: {
        maxChars: 2000,
        dailyGens: 3,
        allowFile: false,
        allowOCR: false,
        name: 'Básico',
        price: 'Grátis',
        description: 'Para estudantes ocasionais.'
    },
    pro: {
        maxChars: 20000,
        dailyGens: 50,
        allowFile: true,
        allowOCR: false,
        name: 'Pro',
        price: 'R$ 29',
        description: 'Para vestibulandos e concurseiros.',
        popular: true
    },
    ultimate: {
        maxChars: 100000,
        dailyGens: 9999,
        allowFile: true,
        allowOCR: true,
        name: 'Ultimate',
        price: 'R$ 59',
        description: 'Para heavy users e pesquisadores.'
    }
};
