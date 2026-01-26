
import { NextResponse } from 'next/server';
import { createServerClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';

// Domain Services
import { deckService } from '@/services/deckService';
import { aiService } from '@/services/aiService';
import { imageService } from '@/services/imageService';
import { GenerateOptionsSchema } from '@/lib/validators';
import { sanitizeInput } from '@/lib/utils';
import { PLAN_LIMITS } from '@/constants/pricing';

export const dynamic = 'force-dynamic';

const MAX_UPLOAD_FILES = 4;
const MAX_UPLOAD_BYTES = 20 * 1024 * 1024;
const IMAGE_MIME_TYPES = new Set(['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/heic', 'image/heif']);
const PDF_MIME_TYPE = 'application/pdf';

// Rate limiter
const ratelimit = process.env.UPSTASH_REDIS_REST_URL ? new Ratelimit({
    redis: Redis.fromEnv(),
    limiter: Ratelimit.slidingWindow(10, '1 m'),
    analytics: true,
}) : null;

// Helpers
const isImageMimeType = (mimeType: string) => IMAGE_MIME_TYPES.has(mimeType.toLowerCase());
const isPdfMimeType = (mimeType: string) => mimeType.toLowerCase() === PDF_MIME_TYPE;

export async function POST(req: Request) {
    try {
        const cookieStore = await cookies();
        const supabase = createServerClient(
            process.env.NEXT_PUBLIC_SUPABASE_URL!,
            process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
            {
                cookies: {
                    get(name) { return cookieStore.get(name)?.value; },
                    set(name, value, options) { cookieStore.set({ name, value, ...options }); },
                    remove(name, options) { cookieStore.set({ name, value: '', ...options }); },
                },
            }
        );

        // 1. Auth Check
        const { data: { user }, error: authError } = await supabase.auth.getUser();
        if (authError || !user) {
            return NextResponse.json({ error: 'Não autorizado. Por favor, faça login.' }, { status: 401 });
        }

        // 2. Rate Limiting
        if (ratelimit) {
            const { success, limit, reset, remaining } = await ratelimit.limit(user.id);
            if (!success) {
                return NextResponse.json({ error: 'Muitas requisições. Aguarde um momento.' }, {
                    status: 429, headers: {
                        'X-RateLimit-Limit': limit.toString(),
                        'X-RateLimit-Remaining': remaining.toString(),
                        'X-RateLimit-Reset': reset.toString(),
                    }
                });
            }
        }

        // 3. Parse Request
        let rawBody: any = {};
        let files: File[] = [];

        const contentType = req.headers.get('content-type') || '';
        if (contentType.includes('multipart/form-data')) {
            const formData = await req.formData();
            rawBody = {
                text: formData.get('text'),
                language: formData.get('language'),
                difficulty: formData.get('difficulty'),
                studyLevel: formData.get('studyLevel'),
                studyGoal: formData.get('studyGoal'),
                templateType: formData.get('templateType'),
                cardCount: formData.get('cardCount'),
                imageCount: formData.get('imageCount'),
                generateImages: formData.get('generateImages'),
                enemMode: formData.get('enemMode'),
                autoTags: formData.get('autoTags'),
            };
            files = formData.getAll('files').filter((entry): entry is File => entry instanceof File);
        } else {
            rawBody = await req.json().catch(() => ({}));
        }

        // 4. Validate Input
        const validation = GenerateOptionsSchema.safeParse(rawBody);

        if (!validation.success) {
            return NextResponse.json({ error: 'Dados inválidos.', details: validation.error.format() }, { status: 400 });
        }

        const options = validation.data;
        const sanitizedText = sanitizeInput(options.text || '');

        // 5. Check Limits & Plan
        const { limits, currentUsage, planTier } = await deckService.checkUserLimit(user.id);

        if (currentUsage >= limits.dailyGens) {
            return NextResponse.json({ error: `Limite diário atingido (${limits.dailyGens}).` }, { status: 403 });
        }

        if (sanitizedText.length > limits.maxChars) {
            return NextResponse.json({ error: `Texto excede o limite do plano (${limits.maxChars} caracteres).` }, { status: 403 });
        }

        if (options.generateImages && !limits.allowImageGeneration) {
            return NextResponse.json({ error: 'Seu plano não permite geração de imagens.' }, { status: 403 });
        }

        if (options.enemMode && !limits.allowEnemMode) {
            return NextResponse.json({ error: 'Seu plano não permite o Modo ENEM. Faça upgrade para Pro ou Ultimate.' }, { status: 403 });
        }

        if (options.autoTags && !limits.allowFolders) { // using allowFolders as proxy to Pro features
            return NextResponse.json({ error: 'Seu plano não permite tags automáticas. Faça upgrade para Pro ou Ultimate.' }, { status: 403 });
        }

        // 6. Process Attachments
        const totalFiles = files.length;
        if (totalFiles > MAX_UPLOAD_FILES) {
            return NextResponse.json({ error: `Máximo de ${MAX_UPLOAD_FILES} arquivos permitidos.` }, { status: 400 });
        }

        const attachmentParts: { inline_data: { mime_type: string; data: string } }[] = [];

        for (const file of files) {
            if (file.size > MAX_UPLOAD_BYTES) {
                return NextResponse.json({ error: 'Arquivo muito grande (max 20MB).' }, { status: 413 });
            }

            const mimeType = file.type.toLowerCase();
            if (!isImageMimeType(mimeType) && !isPdfMimeType(mimeType)) {
                return NextResponse.json({ error: 'Formato não suportado (apenas PDF e Imagens).' }, { status: 400 });
            }

            if (isImageMimeType(mimeType) && !limits.allowOCR) return NextResponse.json({ error: 'Plano não permite OCR.' }, { status: 403 });
            if (isPdfMimeType(mimeType) && !limits.allowFile) return NextResponse.json({ error: 'Plano não permite upload de arquivos.' }, { status: 403 });

            const buffer = Buffer.from(await file.arrayBuffer());
            attachmentParts.push({
                inline_data: {
                    mime_type: mimeType,
                    data: buffer.toString('base64'),
                }
            });
        }

        if (!sanitizedText && attachmentParts.length === 0) {
            return NextResponse.json({ error: 'Forneça texto ou anexos.' }, { status: 400 });
        }

        // 7. Logic: Card Count Calculation
        let requestedCardCount = limits.maxCardsPerGen;
        if (limits.customCardCount && options.cardCount) {
            requestedCardCount = Math.min(options.cardCount, limits.maxCardsPerGen);
        }

        // 8. Generate Flashcards (AI Service)
        const cards = await aiService.generateFlashcards({
            userText: sanitizedText,
            attachments: attachmentParts,
            config: {
                ...options,
                cardCount: requestedCardCount,
                aiOptimized: limits.aiOptimized,
                enemMode: !!options.enemMode,
                autoTags: !!options.autoTags
            }
        });

        // 9. Generate Images (Image Service) - Parallelized
        let imageStats = null;
        let finalCards = cards;

        if (options.generateImages && limits.maxImageCardsPerGen > 0 && cards.length > 0) {
            const requestedImages = (options.imageCount && options.imageCount > 0) ? options.imageCount : limits.maxImageCardsPerGen;
            const maxImages = Math.min(cards.length, limits.maxImageCardsPerGen, requestedImages);

            const { updatedCards, stats } = await imageService.generateCardsImages(cards, maxImages);
            finalCards = updatedCards;
            imageStats = stats;
        }

        // 10. Update Usage
        await deckService.incrementUsage(user.id);

        const notification = planTier === 'free'
            ? 'Para salvar seu baralho e ter acesso ilimitado às gerações diárias, faça upgrade para o Pro.'
            : undefined;

        return NextResponse.json({
            cards: finalCards,
            usage: currentUsage + 1,
            limit: limits.dailyGens,
            imageGeneration: imageStats,
            notification, // Return notification for client to display
        });

    } catch (error: any) {
        console.error('[API/Generate] Error:', error);

        if (error.message && (error.message.includes('AI Service') || error.message.includes('fetch'))) {
            return NextResponse.json({ error: 'Erro de comunicação com o serviço de IA. Tente novamente.' }, { status: 502 });
        }

        return NextResponse.json({ error: error.message || 'Erro interno no servidor.' }, { status: 500 });
    }
}
