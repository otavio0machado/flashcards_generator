export type PlanKey = 'free' | 'pro' | 'ultimate';

export interface PlanLimit {
    maxChars: number;
    dailyGens: number;
    maxCardsPerGen: number;
    maxImageCardsPerGen: number;
    allowFile: boolean;
    allowOCR: boolean;
    allowImageGeneration: boolean;
    name: string;
    price: string;
    description: string;
    popular?: boolean;
    historySaved: boolean;
    aiOptimized: boolean;
    prioritySupport: boolean;
    customCardCount: boolean;
}

export const PLAN_LIMITS: Record<PlanKey, PlanLimit> = {
    free: {
        maxChars: 2000,
        dailyGens: 3,
        maxCardsPerGen: 5,
        maxImageCardsPerGen: 0,
        allowFile: false,
        allowOCR: false,
        allowImageGeneration: false,
        name: 'Básico',
        price: 'Grátis',
        description: 'Para estudantes ocasionais.',
        historySaved: false,
        aiOptimized: false,
        prioritySupport: false,
        customCardCount: false
    },
    pro: {
        maxChars: 20000,
        dailyGens: 10,
        maxCardsPerGen: 15,
        maxImageCardsPerGen: 0,
        allowFile: true,
        allowOCR: false,
        allowImageGeneration: false,
        name: 'Pro',
        price: 'R$ 9,90',
        description: 'Para vestibulandos e concurseiros.',
        popular: true,
        historySaved: true,
        aiOptimized: true,
        prioritySupport: false,
        customCardCount: false
    },
    ultimate: {
        maxChars: 100000,
        dailyGens: 20,
        maxCardsPerGen: 30,
        maxImageCardsPerGen: 3,
        allowFile: true,
        allowOCR: true,
        allowImageGeneration: true,
        name: 'Ultimate',
        price: 'R$ 19,90',
        description: 'Para heavy users e pesquisadores.',
        historySaved: true,
        aiOptimized: true,
        prioritySupport: true,
        customCardCount: true
    }
};
