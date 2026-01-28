
import { NextResponse } from 'next/server';
import { createServerClient } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import { Ratelimit } from '@upstash/ratelimit';
import { Redis } from '@upstash/redis';
import { supabaseAdmin } from '@/lib/supabase-admin';

// Domain Services
import { deckService } from '@/services/deckService';
import { aiService } from '@/services/aiService';
import { imageService } from '@/services/imageService';
import { GenerateOptionsSchema } from '@/lib/validators';
import { sanitizeInput } from '@/lib/utils';
import { ErrorCodes } from '@/types/api';

export const dynamic = 'force-dynamic';

const MAX_UPLOAD_FILES = 4;
const MAX_UPLOAD_BYTES = 20 * 1024 * 1024;
const IMAGE_MIME_TYPES = new Set(['image/jpeg', 'image/jpg', 'image/png', 'image/webp', 'image/heic', 'image/heif']);
const PDF_MIME_TYPE = 'application/pdf';
const DOCX_MIME_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

// Rate limiter
const ratelimit = process.env.UPSTASH_REDIS_REST_URL ? new Ratelimit({
    redis: Redis.fromEnv(),
    limiter: Ratelimit.slidingWindow(10, '1 m'),
    analytics: true,
}) : null;

// Helpers
const isImageMimeType = (mimeType: string) => IMAGE_MIME_TYPES.has(mimeType.toLowerCase());
const isPdfMimeType = (mimeType: string) => mimeType.toLowerCase() === PDF_MIME_TYPE;
const isDocxMimeType = (mimeType: string) => mimeType.toLowerCase() === DOCX_MIME_TYPE;

async function extractPdfText(buffer: Buffer, selectedPages?: number[]): Promise<string> {
    const pdfjs = await import('pdfjs-dist/legacy/build/pdf.mjs');
    const loadingTask = pdfjs.getDocument({ data: new Uint8Array(buffer) });
    const pdf = await loadingTask.promise;
    const pages: string[] = [];

    const totalPages = pdf.numPages;
    let pagesToRead: number[] = [];

    if (Array.isArray(selectedPages) && selectedPages.length > 0) {
        pagesToRead = Array.from(new Set(selectedPages))
            .map((page) => Math.max(1, Math.min(totalPages, Math.floor(page))))
            .filter((page) => page >= 1 && page <= totalPages)
            .sort((a, b) => a - b);
    } else {
        pagesToRead = Array.from({ length: totalPages }, (_, idx) => idx + 1);
    }

    if (pagesToRead.length === 0) return '';

    for (const pageNum of pagesToRead) {
        const page = await pdf.getPage(pageNum);
        const content = await page.getTextContent();
        const pageText = content.items
            .map((item) => {
                // TextItem has 'str', TextMarkedContent does not
                if ('str' in item && typeof item.str === 'string') {
                    return item.str;
                }
                return '';
            })
            .filter(Boolean)
            .join(' ');
        if (pageText.trim()) pages.push(pageText);
    }

    return pages.join('\n\n');
}

async function extractDocxText(buffer: Buffer): Promise<string> {
    const mammoth = await import('mammoth');
    const bytes = new Uint8Array(buffer);
    const arrayBuffer = bytes.buffer.slice(bytes.byteOffset, bytes.byteOffset + bytes.byteLength);
    const result = await mammoth.extractRawText({ arrayBuffer: arrayBuffer as ArrayBuffer });
    return (result?.value || '').trim();
}

async function ensureUserProfile(userId: string): Promise<boolean> {
    try {
        const { error } = await supabaseAdmin
            .from('profiles')
            .upsert({ id: userId, plan_tier: 'free' }, { onConflict: 'id', ignoreDuplicates: true });

        if (error) {
            console.error('[API/Generate] Erro ao garantir perfil:', error);
            return false;
        }
        return true;
    } catch (error) {
        console.error('[API/Generate] Exceção ao garantir perfil:', error);
        return false;
    }
}

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
            return NextResponse.json({ error: 'Não autorizado. Por favor, faça login.', code: ErrorCodes.AUTH_REQUIRED }, { status: 401 });
        }

        // 1.1 Ensure Profile Exists (legacy users / missing trigger)
        await ensureUserProfile(user.id);

        // 2. Rate Limiting
        if (ratelimit) {
            const { success, limit, reset, remaining } = await ratelimit.limit(user.id);
            if (!success) {
                return NextResponse.json({ error: 'Muitas requisições. Aguarde um momento.', code: ErrorCodes.RATE_LIMIT_EXCEEDED }, {
                    status: 429, headers: {
                        'X-RateLimit-Limit': limit.toString(),
                        'X-RateLimit-Remaining': remaining.toString(),
                        'X-RateLimit-Reset': reset.toString(),
                    }
                });
            }
        }

        // 3. Parse Request
        let rawBody: unknown = {};
        let files: File[] = [];
        let fileIds: string[] = [];
        let pdfPageSelections: Record<string, number[] | 'all'> = {};

        const contentType = req.headers.get('content-type') || '';
        if (contentType.includes('multipart/form-data')) {
            const formData = await req.formData();
            const pdfPageSelectionsRaw = formData.get('pdfPageSelections');
            rawBody = {
                text: formData.get('text'),
                language: formData.get('language'),
                difficulty: formData.get('difficulty'),
                studyLevel: formData.get('studyLevel'),
                studyGoal: formData.get('studyGoal'),
                templateType: formData.get('templateType'),
                cardStyle: formData.get('cardStyle'),
                cardCount: formData.get('cardCount'),
                imageCount: formData.get('imageCount'),
                generateImages: formData.get('generateImages'),
                enemMode: formData.get('enemMode'),
                autoTags: formData.get('autoTags'),
            };
            files = formData.getAll('files').filter((entry): entry is File => entry instanceof File);
            fileIds = formData.getAll('fileIds').filter((entry): entry is string => typeof entry === 'string');

            if (typeof pdfPageSelectionsRaw === 'string' && pdfPageSelectionsRaw.trim()) {
                try {
                    pdfPageSelections = JSON.parse(pdfPageSelectionsRaw);
                } catch (error) {
                    console.warn('[API/Generate] Invalid pdfPageSelections JSON', error);
                }
            }
        } else {
            rawBody = await req.json().catch(() => ({}));
        }

        // 4. Validate Input
        const validation = GenerateOptionsSchema.safeParse(rawBody);

        if (!validation.success) {
            return NextResponse.json({ error: 'Dados inválidos.', code: ErrorCodes.VALIDATION_ERROR, details: validation.error.format() }, { status: 400 });
        }

        const options = validation.data;
        const baseText = sanitizeInput(options.text || '');

        // 5. Check Limits & Plan
        const { limits, currentUsage, planTier } = await deckService.checkUserLimit(user.id, supabaseAdmin);

        if (currentUsage >= limits.dailyGens) {
            return NextResponse.json({ error: `Limite diário atingido (${limits.dailyGens}).`, code: ErrorCodes.PLAN_LIMIT_EXCEEDED }, { status: 403 });
        }

        if (options.generateImages && !limits.allowImageGeneration) {
            return NextResponse.json({ error: 'Seu plano não permite geração de imagens.', code: ErrorCodes.UPGRADE_REQUIRED }, { status: 403 });
        }

        if (options.enemMode && !limits.allowEnemMode) {
            return NextResponse.json({ error: 'Seu plano não permite o Modo ENEM. Faça upgrade para Pro ou Ultimate.', code: ErrorCodes.UPGRADE_REQUIRED }, { status: 403 });
        }

        if (options.autoTags && !limits.allowFolders) { // using allowFolders as proxy to Pro features
            return NextResponse.json({ error: 'Seu plano não permite tags automáticas. Faça upgrade para Pro ou Ultimate.', code: ErrorCodes.UPGRADE_REQUIRED }, { status: 403 });
        }

        // 6. Process Attachments
        const totalFiles = files.length;
        if (totalFiles > MAX_UPLOAD_FILES) {
            return NextResponse.json({ error: `Máximo de ${MAX_UPLOAD_FILES} arquivos permitidos.`, code: ErrorCodes.VALIDATION_ERROR }, { status: 400 });
        }

        const attachmentParts: { inline_data: { mime_type: string; data: string } }[] = [];
        const extractedTextParts: string[] = [];

        for (let index = 0; index < files.length; index += 1) {
            const file = files[index];
            if (file.size > MAX_UPLOAD_BYTES) {
                return NextResponse.json({ error: 'Arquivo muito grande (max 20MB).', code: ErrorCodes.VALIDATION_ERROR }, { status: 413 });
            }

            const mimeType = file.type.toLowerCase();
            if (!isImageMimeType(mimeType) && !isPdfMimeType(mimeType) && !isDocxMimeType(mimeType)) {
                return NextResponse.json({ error: 'Formato não suportado (apenas PDF, DOCX e Imagens).', code: ErrorCodes.VALIDATION_ERROR }, { status: 400 });
            }

            if (isImageMimeType(mimeType) && !limits.allowOCR) return NextResponse.json({ error: 'Plano não permite OCR.', code: ErrorCodes.UPGRADE_REQUIRED }, { status: 403 });
            if ((isPdfMimeType(mimeType) || isDocxMimeType(mimeType)) && !limits.allowFile) {
                return NextResponse.json({ error: 'Plano não permite upload de arquivos.', code: ErrorCodes.UPGRADE_REQUIRED }, { status: 403 });
            }

            const buffer = Buffer.from(await file.arrayBuffer());
            if (isImageMimeType(mimeType)) {
                attachmentParts.push({
                    inline_data: {
                        mime_type: mimeType,
                        data: buffer.toString('base64'),
                    }
                });
            } else if (isPdfMimeType(mimeType)) {
                const fileId = fileIds[index] || file.name;
                const selection = pdfPageSelections[fileId];
                const selectedPages = Array.isArray(selection) ? selection : undefined;
                const extracted = await extractPdfText(buffer, selectedPages);
                if (extracted) extractedTextParts.push(extracted);
            } else if (isDocxMimeType(mimeType)) {
                const extracted = await extractDocxText(buffer);
                if (extracted) extractedTextParts.push(extracted);
            }
        }

        const combinedText = [baseText, ...extractedTextParts].filter(Boolean).join('\n\n').trim();

        if (!combinedText && attachmentParts.length === 0) {
            return NextResponse.json({ error: 'Forneça texto ou anexos.', code: ErrorCodes.INVALID_INPUT }, { status: 400 });
        }

        if (combinedText.length > limits.maxChars) {
            return NextResponse.json({ error: `Texto excede o limite do plano (${limits.maxChars} caracteres).`, code: ErrorCodes.PLAN_LIMIT_EXCEEDED }, { status: 403 });
        }

        // 7. Logic: Card Count Calculation
        let requestedCardCount = limits.maxCardsPerGen;
        if (limits.customCardCount && options.cardCount) {
            requestedCardCount = Math.min(options.cardCount, limits.maxCardsPerGen);
        }

        // 8. Generate Flashcards (AI Service)
        const cards = await aiService.generateFlashcards({
            userText: combinedText,
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
        await deckService.incrementUsage(user.id, supabaseAdmin);

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

    } catch (error: unknown) {
        const errorMessage = error instanceof Error ? error.message : 'Erro desconhecido';
        console.error('[API/Generate] Error:', error);

        if (errorMessage.includes('AI Service') || errorMessage.includes('fetch')) {
            return NextResponse.json({ error: 'Erro de comunicação com o serviço de IA. Tente novamente.', code: ErrorCodes.SERVICE_UNAVAILABLE }, { status: 502 });
        }

        return NextResponse.json({ error: errorMessage || 'Erro interno no servidor.', code: ErrorCodes.INTERNAL_ERROR }, { status: 500 });
    }
}
