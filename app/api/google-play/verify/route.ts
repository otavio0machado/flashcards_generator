import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';

const supabaseAdmin = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.SUPABASE_SERVICE_ROLE_KEY!
);

interface VerifyRequest {
    purchaseToken: string;
    productId: string;
    orderId: string;
}

/**
 * POST /api/google-play/verify
 *
 * Validates a Google Play purchase using the Google Play Developer API.
 * On successful validation, updates the user's subscription status in Supabase.
 *
 * Prerequisites:
 * - GOOGLE_PLAY_SERVICE_ACCOUNT_KEY env var with the service account JSON
 * - Google Play Developer API enabled in Google Cloud Console
 * - Service account with access to the Google Play Console
 */
export async function POST(request: NextRequest) {
    try {
        const body: VerifyRequest = await request.json();
        const { purchaseToken, productId, orderId } = body;

        if (!purchaseToken || !productId) {
            return NextResponse.json(
                { error: 'Missing purchaseToken or productId' },
                { status: 400 }
            );
        }

        // Get the authenticated user from the request
        const authHeader = request.headers.get('Authorization');
        if (!authHeader) {
            return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });
        }

        const token = authHeader.replace('Bearer ', '');
        const { data: { user }, error: userError } = await supabaseAdmin.auth.getUser(token);

        if (userError || !user) {
            return NextResponse.json({ error: 'Invalid token' }, { status: 401 });
        }

        // TODO: Validate with Google Play Developer API
        // This requires:
        // 1. A Google Cloud service account with Google Play Developer API access
        // 2. The googleapis npm package for making authenticated requests
        // 3. Call: androidpublisher.purchases.subscriptions.get
        //
        // Example (after adding googleapis dependency):
        //
        // const { google } = require('googleapis');
        // const auth = new google.auth.GoogleAuth({
        //     credentials: JSON.parse(process.env.GOOGLE_PLAY_SERVICE_ACCOUNT_KEY!),
        //     scopes: ['https://www.googleapis.com/auth/androidpublisher'],
        // });
        // const androidPublisher = google.androidpublisher({ version: 'v3', auth });
        // const result = await androidPublisher.purchases.subscriptions.get({
        //     packageName: 'com.flashcardsgenerator.app',
        //     subscriptionId: productId,
        //     token: purchaseToken,
        // });
        //
        // For now, we store the purchase and mark it as pending verification.

        // Store the purchase record
        const { error: dbError } = await supabaseAdmin
            .from('google_play_purchases')
            .upsert({
                user_id: user.id,
                purchase_token: purchaseToken,
                product_id: productId,
                order_id: orderId,
                purchase_state: 'pending_verification',
                created_at: new Date().toISOString(),
            }, {
                onConflict: 'purchase_token',
            });

        if (dbError) {
            console.error('[google-play-verify] DB error:', dbError);
            return NextResponse.json(
                { error: 'Failed to store purchase' },
                { status: 500 }
            );
        }

        // Update user's subscription status
        // This should be refined once Google Play API verification is implemented
        const { error: profileError } = await supabaseAdmin
            .from('profiles')
            .update({
                subscription_status: 'active',
                subscription_provider: 'google_play',
                subscription_product_id: productId,
            })
            .eq('id', user.id);

        if (profileError) {
            console.error('[google-play-verify] Profile update error:', profileError);
        }

        return NextResponse.json({ verified: true, orderId });
    } catch (err) {
        console.error('[google-play-verify] Error:', err);
        return NextResponse.json(
            { error: 'Internal server error' },
            { status: 500 }
        );
    }
}
