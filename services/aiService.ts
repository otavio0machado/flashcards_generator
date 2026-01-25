
import { sleep } from '@/lib/utils';
import { promptService } from './promptService';

export interface GeneratedCard {
    question: string;
    answer: string;
    image_url?: string | null;
    user_image_index?: number;
    user_image_section?: 'question' | 'answer';
}

export interface Attachment {
    inline_data: {
        mime_type: string;
        data: string;
    };
}

export interface GenerationRequest {
    userText: string;
    attachments: Attachment[];
    config: {
        cardCount: number;
        language: string;
        difficulty: string;
        studyLevel: string;
        studyGoal: string;
        templateType: string;
        aiOptimized: boolean;
    };
}

export const aiService = {
    async fetchWithRetry(url: string, init: RequestInit, attempts = 5): Promise<Response | null> {
        let lastError: unknown;
        let lastStatus: number | null = null;

        for (let attempt = 0; attempt < attempts; attempt += 1) {
            try {
                const response = await fetch(url, init);
                lastStatus = response.status;

                if (response.status === 429 || response.status === 503) {
                    const retryAfterHeader = response.headers.get('retry-after');
                    const retryAfterMs = retryAfterHeader ? parseInt(retryAfterHeader, 10) * 1000 : 0;
                    const backoff = retryAfterMs || (2000 * Math.pow(2, attempt)); // Exponential backoff

                    console.log(`[AI-Service] Rate limit hit (Status ${response.status}). Waiting ${backoff}ms...`);
                    await sleep(backoff + Math.floor(Math.random() * 500));
                    continue;
                }

                return response;
            } catch (error) {
                lastError = error;
                console.warn(`[AI-Service] Network error (Attempt ${attempt + 1}/${attempts}):`, error);
                await sleep(1000 * (attempt + 1));
            }
        }

        console.error(`[AI-Service] All retry attempts failed. Last status: ${lastStatus}`, lastError);
        return null;
    },

    async generateFlashcards(req: GenerationRequest): Promise<GeneratedCard[]> {
        const prompt = promptService.constructSystemPrompt({
            userText: req.userText,
            attachmentCount: req.attachments.length,
            requestedCardCount: req.config.cardCount,
            language: req.config.language,
            difficulty: req.config.difficulty,
            studyLevel: req.config.studyLevel,
            studyGoal: req.config.studyGoal,
            templateType: req.config.templateType,
            aiOptimized: req.config.aiOptimized
        });

        const apiKey = process.env.GEMINI_API_KEY;
        if (!apiKey) {
            throw new Error('GEMINI_API_KEY is not configured');
        }

        const response = await this.fetchWithRetry(
            `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`,
            {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    contents: [{ parts: [{ text: prompt }, ...req.attachments] }],
                    generationConfig: {
                        temperature: 0.7,
                        responseMimeType: "application/json"
                    }
                })
            }
        );

        if (!response) {
            throw new Error('Failed to connect to AI Service after multiple attempts');
        }

        if (!response.ok) {
            const errorData = await response.json().catch(() => ({}));
            console.error('Gemini API Error:', errorData);
            throw new Error(`AI Service returned error: ${response.status}`);
        }

        const data = await response.json();

        try {
            const rawContent = data.candidates?.[0]?.content?.parts?.[0]?.text;
            const parsedCards = JSON.parse(rawContent || '[]');

            if (!Array.isArray(parsedCards)) {
                console.warn('AI returned non-array response');
                return [];
            }

            return parsedCards
                .map((card: any) => ({
                    question: typeof card?.question === 'string' ? card.question : '',
                    answer: typeof card?.answer === 'string' ? card.answer : '',
                    user_image_index: typeof card?.user_image_index === 'number' ? card.user_image_index : undefined,
                    user_image_section: ['question', 'answer'].includes(card?.user_image_section) ? card.user_image_section : undefined
                }))
                .filter(card => card.question || card.answer);

        } catch (parseError) {
            console.error('Failed to parse AI response:', parseError);
            throw new Error('Failed to process AI response format');
        }
    }
};
