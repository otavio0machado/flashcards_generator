import { createServerClient, type CookieOptions } from '@supabase/auth-helpers-nextjs';
import { NextRequest, NextResponse } from 'next/server';

export async function middleware(req: NextRequest) {
    let res = NextResponse.next({
        request: {
            headers: req.headers,
        },
    });

    const supabase = createServerClient(
        process.env.NEXT_PUBLIC_SUPABASE_URL || '',
        process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '',
        {
            cookies: {
                get(name: string) {
                    return req.cookies.get(name)?.value;
                },
                set(name: string, value: string, options: CookieOptions) {
                    req.cookies.set({
                        name,
                        value,
                        ...options,
                    });
                    res = NextResponse.next({
                        request: {
                            headers: req.headers,
                        },
                    });
                    res.cookies.set({
                        name,
                        value,
                        ...options,
                    });
                },
                remove(name: string, options: CookieOptions) {
                    req.cookies.set({
                        name,
                        value: '',
                        ...options,
                    });
                    res = NextResponse.next({
                        request: {
                            headers: req.headers,
                        },
                    });
                    res.cookies.set({
                        name,
                        value: '',
                        ...options,
                    });
                },
            },
        }
    );

    // Usar getUser() para validar JWT server-side (mais seguro que getSession())
    const {
        data: { user },
        error,
    } = await supabase.auth.getUser();

    const isAuthenticated = !error && user;

    // Se o usuário está tentando acessar o /decks e não está logado
    if (req.nextUrl.pathname.startsWith('/decks') && !isAuthenticated) {
        return NextResponse.redirect(new URL('/auth/login', req.url));
    }

    // Se o usuário está logado e tenta ir para login/signup
    if (req.nextUrl.pathname.startsWith('/auth') && isAuthenticated) {
        return NextResponse.redirect(new URL('/app', req.url));
    }

    return res;
}

export const config = {
    matcher: ['/app/:path*', '/auth/:path*', '/decks/:path*'],
};

