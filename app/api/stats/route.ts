import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase-admin';

export const dynamic = 'force-dynamic';
export const runtime = 'nodejs';

export async function GET() {
    try {
        const now = new Date();
        const weekAgo = new Date(now);
        weekAgo.setDate(now.getDate() - 7);

        const todayStart = new Date(now);
        todayStart.setHours(0, 0, 0, 0);

        const [cardsResult, decksResult] = await Promise.all([
            supabaseAdmin
                .from('cards')
                .select('id', { count: 'exact', head: true })
                .gte('created_at', weekAgo.toISOString()),
            supabaseAdmin
                .from('decks')
                .select('id', { count: 'exact', head: true })
                .gte('created_at', todayStart.toISOString()),
        ]);

        if (cardsResult.error) {
            console.error(cardsResult.error);
        }
        if (decksResult.error) {
            console.error(decksResult.error);
        }

        return NextResponse.json({
            cardsWeek: cardsResult.count || 0,
            decksToday: decksResult.count || 0,
        });
    } catch (error) {
        console.error('Erro ao buscar stats:', error);
        return NextResponse.json({ cardsWeek: 0, decksToday: 0 }, { status: 200 });
    }
}
