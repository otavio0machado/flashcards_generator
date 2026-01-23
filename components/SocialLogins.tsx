'use client';

import React from 'react';
import { Github, Facebook, Apple } from 'lucide-react';
import { supabase } from '@/lib/supabase';

interface SocialLoginsProps {
    onError: (message: string) => void;
}

export default function SocialLogins({ onError }: SocialLoginsProps) {
    const handleOAuthLogin = async (provider: 'google' | 'github' | 'facebook' | 'apple') => {
        try {
            const { error } = await supabase.auth.signInWithOAuth({
                provider,
                options: {
                    redirectTo: `${window.location.origin}/auth/callback`,
                },
            });
            if (error) throw error;
        } catch (error: any) {
            onError(error.message || 'Erro ao entrar com provedor social.');
        }
    };

    return (
        <div className="grid grid-cols-2 gap-3 mt-6">
            <button
                onClick={() => handleOAuthLogin('google')}
                className="flex items-center justify-center gap-2 border border-border py-2.5 rounded-sm text-sm font-bold hover:bg-gray-50 transition-all group"
            >
                <svg className="h-4 w-4 group-hover:scale-110 transition-transform" viewBox="0 0 24 24">
                    <path
                        fill="currentColor"
                        d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                    />
                    <path
                        fill="currentColor"
                        d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                    />
                    <path
                        fill="currentColor"
                        d="M5.84 14.1c-.22-.66-.35-1.36-.35-2.1s.13-1.44.35-2.1V7.06H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.94l3.66-2.84z"
                    />
                    <path
                        fill="currentColor"
                        d="M12 5.38c1.62 0 3.06.56 4.21 1.66l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                    />
                </svg>
                Google
            </button>
            <button
                onClick={() => handleOAuthLogin('facebook')}
                className="flex items-center justify-center gap-2 border border-border py-2.5 rounded-sm text-sm font-bold hover:bg-gray-50 transition-all group"
            >
                <Facebook className="h-4 w-4 text-[#1877F2] fill-[#1877F2] group-hover:scale-110 transition-transform" />
                Facebook
            </button>
            <button
                onClick={() => handleOAuthLogin('apple')}
                className="flex items-center justify-center gap-2 border border-border py-2.5 rounded-sm text-sm font-bold hover:bg-gray-50 transition-all group"
            >
                <Apple className="h-4 w-4 text-black fill-black group-hover:scale-110 transition-transform" />
                Apple
            </button>
            <button
                onClick={() => handleOAuthLogin('github')}
                className="flex items-center justify-center gap-2 border border-border py-2.5 rounded-sm text-sm font-bold hover:bg-gray-50 transition-all group"
            >
                <Github className="h-4 w-4 text-foreground group-hover:scale-110 transition-transform" />
                GitHub
            </button>
        </div>
    );
}
