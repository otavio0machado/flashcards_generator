import { NextResponse } from 'next/server';
import { createServerClient, type CookieOptions } from '@supabase/auth-helpers-nextjs';
import { cookies } from 'next/headers';
import AnkiExport from 'anki-apkg-export';
import { gunzipSync } from 'zlib';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

type ExportCard = {
    front?: string;
    back?: string;
    question?: string;
    answer?: string;
    image_url?: string | null;
    imageUrl?: string | null;
};

const getSafeFileName = (title: string) => {
    return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';
};

const parseDataUrl = (value: string) => {
    const match = value.match(/^data:(.+);base64,(.+)$/i);
    if (!match) return null;
    return { mimeType: match[1], base64: match[2] };
};

const mimeToExtension = (mimeType: string) => {
    switch (mimeType.toLowerCase()) {
        case 'image/jpeg':
        case 'image/jpg':
            return 'jpg';
        case 'image/png':
            return 'png';
        case 'image/webp':
            return 'webp';
        case 'image/heic':
            return 'heic';
        case 'image/heif':
            return 'heif';
        default:
            return 'png';
    }
};

const resolveImageData = async (imageUrl: string, index: number) => {
    const dataUrl = parseDataUrl(imageUrl);
    if (dataUrl) {
        const ext = mimeToExtension(dataUrl.mimeType);
        return {
            filename: `image-${index + 1}.${ext}`,
            data: Buffer.from(dataUrl.base64, 'base64'),
        };
    }

    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
        try {
            const response = await fetch(imageUrl);
            if (!response.ok) return null;
            const arrayBuffer = await response.arrayBuffer();
            const mimeType = response.headers.get('content-type') || 'image/png';
            const ext = mimeToExtension(mimeType);
            return {
                filename: `image-${index + 1}.${ext}`,
                data: Buffer.from(arrayBuffer),
            };
        } catch (error) {
            console.error('Erro ao baixar imagem para exportacao:', error);
        }
    }

    return null;
};

export async function POST(req: Request) {
    try {
        const cookieStore = await cookies();
        const supabase = createServerClient(
            process.env.NEXT_PUBLIC_SUPABASE_URL!,
            process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
            {
                cookies: {
                    get(name: string) {
                        return cookieStore.get(name)?.value;
                    },
                    set(name: string, value: string, options: CookieOptions) {
                        cookieStore.set({ name, value, ...options });
                    },
                    remove(name: string, options: CookieOptions) {
                        cookieStore.set({ name, value: '', ...options });
                    },
                },
            }
        );

        const { data: { user }, error: authError } = await supabase.auth.getUser();
        if (authError || !user) {
            return NextResponse.json({ error: 'Não autorizado. Faça login para exportar.' }, { status: 401 });
        }

        const contentEncoding = req.headers.get('content-encoding') || '';
        let body: Record<string, unknown> = {};
        if (contentEncoding.toLowerCase().includes('gzip')) {
            const raw = Buffer.from(await req.arrayBuffer());
            const decompressed = gunzipSync(raw);
            body = JSON.parse(decompressed.toString('utf-8')) as Record<string, unknown>;
        } else {
            body = await req.json().catch(() => ({}));
        }
        const title = typeof body?.title === 'string' ? body.title.trim() : 'Deck';
        const cards = Array.isArray(body?.cards) ? body.cards as ExportCard[] : [];

        if (!cards.length) {
            return NextResponse.json({ error: 'Nenhum card para exportar.' }, { status: 400 });
        }

        const apkg = new AnkiExport(title || 'Deck');
        let added = 0;

        for (const [index, card] of cards.entries()) {
            const front = typeof card.front === 'string'
                ? card.front
                : typeof card.question === 'string'
                    ? card.question
                    : '';
            const back = typeof card.back === 'string'
                ? card.back
                : typeof card.answer === 'string'
                    ? card.answer
                    : '';

            if (!front && !back) continue;

            const imageUrl = typeof card.image_url === 'string'
                ? card.image_url
                : typeof card.imageUrl === 'string'
                    ? card.imageUrl
                    : '';
            let frontWithImage = front;

            if (imageUrl) {
                const imageData = await resolveImageData(imageUrl, index);
                if (imageData) {
                    apkg.addMedia(imageData.filename, imageData.data);
                    frontWithImage = front
                        ? `${front}<br/><img src="${imageData.filename}" />`
                        : `<img src="${imageData.filename}" />`;
                }
            }

            apkg.addCard(frontWithImage, back);
            added += 1;
        }

        if (!added) {
            return NextResponse.json({ error: 'Nenhum card válido para exportar.' }, { status: 400 });
        }

        const zip = await apkg.save();
        const buffer = Buffer.isBuffer(zip)
            ? zip
            : typeof zip === 'string'
                ? Buffer.from(zip, 'binary')
                : zip instanceof ArrayBuffer
                    ? Buffer.from(new Uint8Array(zip))
                    : Buffer.from(zip);
        const filename = `${getSafeFileName(title || 'deck')}.apkg`;
        const responseBody = new Uint8Array(buffer);

        return new Response(responseBody, {
            headers: {
                'Content-Type': 'application/vnd.anki.package',
                'Content-Disposition': `attachment; filename="${filename}"`
            }
        });
    } catch (error) {
        console.error('Erro ao exportar .apkg:', error);
        return NextResponse.json({ error: 'Falha ao exportar baralho.' }, { status: 500 });
    }
}
