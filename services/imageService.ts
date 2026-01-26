
import { GeneratedCard } from './aiService';

const MAX_IMAGE_TOPIC_CHARS = 300;
const IMAGE_STYLE_SUFFIX = ', educational flat vector illustration, clean white background, high resolution, minimalist scientific style';

// Configurações de otimização
const MAX_CONCURRENT_REQUESTS = 3; // Limita requisições paralelas
const REQUEST_TIMEOUT_MS = 30000; // 30 segundos de timeout
const BATCH_DELAY_MS = 100; // Delay entre batches para evitar rate limiting

interface ImageGenerationResult {
    mimeType: string;
    data: string;
}

/**
 * Helper para executar fetch com timeout
 */
async function fetchWithTimeout(url: string, options: RequestInit, timeoutMs: number = REQUEST_TIMEOUT_MS): Promise<Response> {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), timeoutMs);

    try {
        const response = await fetch(url, {
            ...options,
            signal: controller.signal
        });
        return response;
    } finally {
        clearTimeout(timeoutId);
    }
}

/**
 * Processa items em batches com limite de concorrência
 */
async function processBatched<T, R>(
    items: T[],
    processor: (item: T) => Promise<R>,
    concurrency: number = MAX_CONCURRENT_REQUESTS
): Promise<R[]> {
    const results: R[] = [];

    for (let i = 0; i < items.length; i += concurrency) {
        const batch = items.slice(i, i + concurrency);
        const batchResults = await Promise.all(batch.map(processor));
        results.push(...batchResults);

        // Delay entre batches para evitar rate limiting
        if (i + concurrency < items.length) {
            await new Promise(resolve => setTimeout(resolve, BATCH_DELAY_MS));
        }
    }

    return results;
}

export const imageService = {
    async generateCardsImages(cards: GeneratedCard[], limit: number): Promise<{ updatedCards: GeneratedCard[], stats: { requested: number, generated: number, failed: number } }> {
        // Filter cards that don't have user images and need generation
        // Taking the limit into account
        const cardsToProcess = cards
            .map((card, index) => ({ card, index }))
            .filter(({ card }) => card.user_image_index === undefined)
            .slice(0, limit);

        const stats = { requested: cardsToProcess.length, generated: 0, failed: 0 };
        const updatedCards = [...cards];

        console.log(`[ImageService] Starting batched generation for ${stats.requested} images (max ${MAX_CONCURRENT_REQUESTS} concurrent)...`);

        // Execute em batches com limite de concorrência
        await processBatched(cardsToProcess, async ({ card, index }) => {
            try {
                const visualPrompt = await this.convertToVisualPrompt(card.question, card.answer);

                if (!visualPrompt) {
                    console.warn(`[ImageService] Skipping card ${index}: Could not create visual prompt`);
                    stats.failed++;
                    return;
                }

                const imageResult = await this.generateImage(visualPrompt);

                if (imageResult) {
                    const base64 = this.normalizeBase64Data(imageResult.data);
                    updatedCards[index] = {
                        ...updatedCards[index],
                        image_url: `data:${imageResult.mimeType};base64,${base64}`
                    };
                    stats.generated++;
                } else {
                    stats.failed++;
                }
            } catch (error) {
                console.error(`[ImageService] Error processing card ${index}:`, error);
                stats.failed++;
            }
        }, MAX_CONCURRENT_REQUESTS);

        return { updatedCards, stats };
    },

    async convertToVisualPrompt(question: string, answer: string): Promise<string | null> {
        const topic = (answer || question).slice(0, MAX_IMAGE_TOPIC_CHARS);

        try {
            const systemPrompt = `You are an expert in Prompt Engineering for Stable Diffusion. Convert flashcards into VISUAL image prompts.
RULES:
1. REMOVE QUESTIONS: "Who was Napoleon?" -> "Portrait of Napoleon Bonaparte in military uniform"
2. AVOID ABSTRACTIONS: "Democracy" -> "Voters casting ballots in a ballot box"
3. ENGLISH ONLY
4. PHYSICAL OBJECTS ONLY: things that can be SEEN and DRAWN
5. Keep it under 60 words, direct and descriptive
6. Return ONLY the visual prompt, no quotes, no explanations`;

            const userMessage = `Flashcard Question: ${question}\nFlashcard Answer: ${topic}`;

            // Using Pollinations for prompt enhancement (free text generation)
            const response = await fetchWithTimeout(`https://text.pollinations.ai/`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    messages: [
                        { role: 'system', content: systemPrompt },
                        { role: 'user', content: userMessage }
                    ],
                    model: 'openai',
                    seed: Math.floor(Math.random() * 10000)
                })
            }, REQUEST_TIMEOUT_MS);

            if (!response.ok) return null;

            let visualPrompt = await response.text();
            if (!visualPrompt) return null;

            visualPrompt = visualPrompt.replace(/^["']|["']$/g, '').trim();
            return `${visualPrompt}${IMAGE_STYLE_SUFFIX}`;
        } catch (error) {
            console.error('[ImageService] Error converting to visual prompt:', error);
            return null;
        }
    },

    async generateImage(visualPrompt: string): Promise<ImageGenerationResult | null> {
        const apiKey = process.env.OPENAI_API_KEY;
        if (!apiKey) {
            console.warn('[ImageService] OPENAI_API_KEY não configurada - geração de imagem desabilitada');
            return null;
        }

        try {
            const response = await fetchWithTimeout('https://api.openai.com/v1/images/generations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${apiKey}`
                },
                body: JSON.stringify({
                    model: 'dall-e-3',
                    prompt: visualPrompt,
                    n: 1,
                    size: '1024x1024',
                    response_format: 'b64_json',
                    quality: 'standard'
                })
            }, REQUEST_TIMEOUT_MS);

            if (!response.ok) {
                console.error('[ImageService] OpenAI DALL-E error:', response.status);
                return null;
            }

            const data = await response.json();
            const base64 = data.data?.[0]?.b64_json;

            if (base64) {
                return { mimeType: 'image/png', data: base64 };
            }
            return null;
        } catch (error) {
            console.error('[ImageService] Generation error:', error);
            return null;
        }
    },

    normalizeBase64Data(data: string): string {
        const trimmed = data.trim();
        if (trimmed.startsWith('data:')) {
            const commaIndex = trimmed.indexOf(',');
            if (commaIndex !== -1) {
                return trimmed.slice(commaIndex + 1);
            }
        }
        return trimmed;
    }
};
