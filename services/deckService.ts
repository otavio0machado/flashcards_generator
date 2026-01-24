import { supabase } from '@/lib/supabase';
import { PLAN_LIMITS, PlanKey } from '@/constants/pricing';

export interface Card {
    front: string;
    back: string;
    order?: number;
}

interface PublicDeckCard {
    front: string;
    back: string;
    order?: number;
}

export const deckService = {
    /**
     * Salva um baralho e seus respectivos cards em batch.
     */
    async saveDeck(userId: string, title: string, cards: Card[], tags: string[] = []) {
        // 1. Criar o Deck
        const { data: deck, error: deckError } = await supabase
            .from('decks')
            .insert({ user_id: userId, title, tags })
            .select()
            .single();

        if (deckError) throw deckError;

        // 2. Criar os Cards em batch vinculados ao deck_id
        const cardsToInsert = cards.map((card, index) => ({
            deck_id: deck.id,
            front: card.front,
            back: card.back,
            order: card.order ?? index
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
        const { data: profile, error } = await supabase
            .from('profiles')
            .select('plan_tier, daily_generations, last_reset_date')
            .eq('id', userId)
            .single();

        if (error) throw error;

        const today = new Date().toISOString().split('T')[0];
        const plan = profile.plan_tier as PlanKey;
        let currentUsage = profile.daily_generations;

        // Lógica de reset diário se o acesso for em um novo dia
        if (profile.last_reset_date !== today) {
            currentUsage = 0;
            // Opcional: Atualizar no banco imediatamente ou esperar o incremento
        }

        const limit = PLAN_LIMITS[plan].dailyGens;

        return {
            canGenerate: currentUsage < limit,
            currentUsage,
            limit,
            planTier: plan,
            planName: PLAN_LIMITS[plan].name
        };
    },

    /**
     * Incrementa o uso diário usando a função RPC atômica criada no SQL.
     */
    async incrementUsage(userId: string) {
        const { error } = await supabase.rpc('increment_daily_usage', { p_user_id: userId });
        if (error) throw error;
    },

    /**
     * Clona um baralho pÃºblico para a biblioteca do usuÃ¡rio.
     */
    async clonePublicDeck(userId: string, deckId: string) {
        const { data: sourceDeck, error: sourceError } = await supabase
            .from('decks')
            .select('title, tags, cards(front, back, "order")')
            .eq('id', deckId)
            .eq('is_public', true)
            .single();

        if (sourceError) throw sourceError;

        const { data: newDeck, error: deckError } = await supabase
            .from('decks')
            .insert({
                user_id: userId,
                title: `${sourceDeck.title} (Clone)`,
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
            order: card.order ?? index
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
