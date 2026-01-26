/**
 * Tipos unificados para Cards/Flashcards
 *
 * Este arquivo centraliza as definições de tipos para cards,
 * garantindo consistência em todo o codebase.
 */

/**
 * Card gerado pela IA - usado internamente
 */
export interface GeneratedCard {
    question: string;
    answer: string;
    tags?: string[];
    user_image_index?: number;
    user_image_section?: 'question' | 'answer';
}

/**
 * Card completo salvo no banco de dados
 */
export interface Card extends GeneratedCard {
    id: string;
    deck_id: string;
    created_at?: string;
    updated_at?: string;
}

/**
 * Card para exportação (compatível com Anki)
 * Usa front/back para compatibilidade com formato Anki
 */
export interface ExportCard {
    front: string;
    back: string;
    tags?: string[];
    imageUrl?: string;
}

/**
 * Card com imagem gerada
 */
export interface CardWithImage extends GeneratedCard {
    imageUrl?: string;
    imageBase64?: string;
}

/**
 * Converte um GeneratedCard para ExportCard
 */
export function toExportCard(card: GeneratedCard | { front?: string; back?: string; question?: string; answer?: string; tags?: string[] }): ExportCard {
    const front = 'front' in card && typeof card.front === 'string'
        ? card.front
        : 'question' in card && typeof card.question === 'string'
            ? card.question
            : '';

    const back = 'back' in card && typeof card.back === 'string'
        ? card.back
        : 'answer' in card && typeof card.answer === 'string'
            ? card.answer
            : '';

    return {
        front,
        back,
        tags: card.tags,
    };
}

/**
 * Verifica se um objeto é um card válido
 */
export function isValidCard(obj: unknown): obj is GeneratedCard {
    if (!obj || typeof obj !== 'object') return false;

    const card = obj as Record<string, unknown>;

    // Aceita tanto question/answer quanto front/back
    const hasQuestion = typeof card.question === 'string' && card.question.trim().length > 0;
    const hasAnswer = typeof card.answer === 'string' && card.answer.trim().length > 0;
    const hasFront = typeof card.front === 'string' && (card.front as string).trim().length > 0;
    const hasBack = typeof card.back === 'string' && (card.back as string).trim().length > 0;

    return (hasQuestion && hasAnswer) || (hasFront && hasBack);
}
