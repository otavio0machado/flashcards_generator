import { NextResponse } from 'next/server';
import AnkiExport from 'anki-apkg-export';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

type ExportCard = {
    front?: string;
    back?: string;
    question?: string;
    answer?: string;
};

const getSafeFileName = (title: string) => {
    return title.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'deck';
};

export async function POST(req: Request) {
    try {
        const body = await req.json().catch(() => ({}));
        const title = typeof body?.title === 'string' ? body.title.trim() : 'Deck';
        const cards = Array.isArray(body?.cards) ? body.cards as ExportCard[] : [];

        if (!cards.length) {
            return NextResponse.json({ error: 'Nenhum card para exportar.' }, { status: 400 });
        }

        const apkg = new AnkiExport(title || 'Deck');
        let added = 0;

        cards.forEach((card) => {
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

            if (!front && !back) return;
            apkg.addCard(front, back);
            added += 1;
        });

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
