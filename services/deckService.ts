import { supabase } from '@/lib/supabase';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';

export interface Card {
    front: string;
    back: string;
    order?: number;
    image_url?: string | null;
    question_image_url?: string | null;
    answer_image_url?: string | null;
}

interface DeckMetadata {
    tags?: string[];
    description?: string;
    categoryId?: string | null;
}

interface PublicDeckCard {
    front: string;
    back: string;
    order?: number;
    image_url?: string | null;
    question_image_url?: string | null;
    answer_image_url?: string | null;
}

export const deckService = {
    /**
     * Salva um baralho e seus respectivos cards em batch.
     */
    async saveDeck(userId: string, title: string, cards: Card[], metadata: DeckMetadata = {}) {
        const tags = metadata.tags ?? [];
        const deckPayload: Record<string, unknown> = {
            user_id: userId,
            title,
            tags,
        };

        if (metadata.description) {
            deckPayload.description = metadata.description;
        }

        if (metadata.categoryId) {
            deckPayload.category_id = metadata.categoryId;
        }

        // 1. Criar o Deck
        const { data: deck, error: deckError } = await supabase
            .from('decks')
            .insert(deckPayload)
            .select()
            .single();

        if (deckError) throw deckError;

        // 2. Criar os Cards em batch vinculados ao deck_id
        const cardsToInsert = cards.map((card, index) => ({
            deck_id: deck.id,
            front: card.front,
            back: card.back,
            order: card.order ?? index,
            image_url: card.image_url ?? null,
            question_image_url: card.question_image_url ?? null,
            answer_image_url: card.answer_image_url ?? null
        }));

        const { error: cardsError } = await supabase
            .from('cards')
            .insert(cardsToInsert);

        if (cardsError) throw cardsError;

        return deck;
    },

    /**
     * Verifica o limite do usuário baseado no plano e uso diário.
     * Auto-reseta o contador se for um novo dia.
     */
    async checkUserLimit(userId: string) {
        const { profile, plan, limits } = await this.getUserProfileAndPlan(userId);

        const today = new Date().toISOString().split('T')[0];
        let currentUsage = profile.daily_generations;

        if (profile.last_reset_date !== today) {
            currentUsage = 0;
        }

        return {
            canGenerate: currentUsage < limits.dailyGens,
            currentUsage,
            limit: limits.dailyGens,
            planTier: plan,
            planName: limits.name,
            limits
        };
    },

    /**
     * Helper to get user profile and plan limits
     */
    async getUserProfileAndPlan(userId: string) {
        const { data: profile, error } = await supabase
            .from('profiles')
            .select('plan_tier, daily_generations, last_reset_date')
            .eq('id', userId)
            .single();

        if (error || !profile) {
            throw new Error('Erro ao buscar perfil do usuário');
        }

        const plan = (profile.plan_tier || 'free') as PlanKey;
        const limits = PLAN_LIMITS[plan];

        return { profile, plan, limits };
    },

    /**
     * Asserts that the user has not exceeded their daily generation limit
     */
    async assertUserCanGenerate(userId: string) {
        const { currentUsage, limit, planName } = await this.checkUserLimit(userId);

        if (currentUsage >= limit) {
            throw new Error(`Você atingiu o limite de ${limit} gerações diárias do plano ${planName}.`);
        }

        return currentUsage;
    },

    /**
     * Incrementa o uso diário usando a função RPC atômica criada no SQL.
     */
    async incrementUsage(userId: string) {
        const { error } = await supabase.rpc('increment_daily_usage', { p_user_id: userId });
        if (error) {
            console.error('[DeckService] Failed to increment usage:', error);
            // Non-blocking error for the user flow, but strictly should be logged
        }
    },

    /**
     * Clona um baralho público para a biblioteca do usuário.
     */
    async clonePublicDeck(userId: string, deckId: string) {
        const { data: sourceDeck, error: sourceError } = await supabase
            .from('decks')
            .select('title, description, category_id, tags, cards(front, back, image_url, "order")')
            .eq('id', deckId)
            .eq('is_public', true)
            .single();

        if (sourceError) throw sourceError;

        const { data: newDeck, error: deckError } = await supabase
            .from('decks')
            .insert({
                user_id: userId,
                title: `${sourceDeck.title} (Clone)`,
                description: sourceDeck.description || null,
                category_id: sourceDeck.category_id || null,
                tags: sourceDeck.tags || [],
                is_public: false,
                published_at: null
            })
            .select()
            .single();

        if (deckError) throw deckError;

        const sourceCards = (sourceDeck.cards || []) as PublicDeckCard[];
        const cardsToInsert = sourceCards.map((card, index) => ({
            deck_id: newDeck.id,
            front: card.front,
            back: card.back,
            order: card.order ?? index,
            image_url: card.image_url ?? null
        }));

        if (cardsToInsert.length > 0) {
            const { error: cardsError } = await supabase
                .from('cards')
                .insert(cardsToInsert);

            if (cardsError) throw cardsError;
        }

        return newDeck;
    }
};
