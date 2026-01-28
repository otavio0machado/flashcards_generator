'use client';

import { usePathname, useRouter } from 'next/navigation';
import Link from 'next/link';
import { Home, BookOpen, Store, Settings, Sparkles } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { useState, useEffect } from 'react';
import { getSupabase } from '@/lib/supabase';
import { useTauri } from '@/lib/tauri';
import type { Session, AuthChangeEvent } from '@supabase/supabase-js';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

const navItems = [
    { href: '/', icon: Home, label: 'Início', requiresAuth: false },
    { href: '/marketplace', icon: Store, label: 'Explorar', requiresAuth: false },
    { href: '/app', icon: Sparkles, label: 'Gerar', requiresAuth: false },
    { href: '/decks', icon: BookOpen, label: 'Biblioteca', requiresAuth: true },
    { href: '/settings', icon: Settings, label: 'Config', requiresAuth: true },
];

export default function BottomNav() {
    const pathname = usePathname();
    const router = useRouter();
    const { isTauri, isMobile } = useTauri();
    const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null);
    const [showLoginPrompt, setShowLoginPrompt] = useState(false);
    const [pendingRoute, setPendingRoute] = useState<string | null>(null);
    const [prefs] = useMobilePreferences();

    useEffect(() => {
        const supabase = getSupabase();
        supabase.auth.getSession().then(({ data: { session } }: { data: { session: Session | null } }) => {
            setIsAuthenticated(!!session);
        });

        const { data: { subscription } } = supabase.auth.onAuthStateChange((_event: AuthChangeEvent, session: Session | null) => {
            setIsAuthenticated(!!session);
        });

        return () => subscription.unsubscribe();
    }, []);

    // Don't show on auth pages
    if (pathname?.startsWith('/auth')) {
        return null;
    }

    const handleNavClick = async (e: React.MouseEvent, item: typeof navItems[0]) => {
        // Haptic feedback on navigation
        if (prefs.hapticFeedbackEnabled) {
            haptic('selection');
        }

        // Special-case for Tauri mobile: clicking Início should not trigger a landing page reload
        if (item.href === '/' && isTauri && isMobile) {
            e.preventDefault();

            // If user is already on the home page, do nothing (avoid redirect to /app)
            if (pathname === '/') {
                return;
            }

            // Ensure we know auth state
            let auth = isAuthenticated;
            if (auth === null) {
                const supabase = getSupabase();
                const { data: { session } } = await supabase.auth.getSession();
                auth = !!session;
                setIsAuthenticated(auth);
            }

            if (item.requiresAuth && !auth) {
                setPendingRoute(item.href);
                setShowLoginPrompt(true);
                return;
            }

            // Navigate to the home page on mobile for a consistent predictable experience
            router.push('/');
            return;
        }

        if (item.requiresAuth && !isAuthenticated) {
            e.preventDefault();
            setPendingRoute(item.href);
            setShowLoginPrompt(true);
        }
    };

    const handleLogin = () => {
        setShowLoginPrompt(false);
        router.push('/auth/login');
    };

    return (
        <>
            <nav className="fixed bottom-0 left-0 right-0 z-50 md:hidden pb-safe">
                {/* Glossy Background */}
                <div className="absolute inset-0 bg-white/90 dark:bg-zinc-950/90 backdrop-blur-xl border-t border-zinc-200/50 dark:border-zinc-800/50 shadow-[0_-4px_20px_-5px_rgba(0,0,0,0.1)]" />

                <div className="relative flex items-center justify-around max-w-md mx-auto pt-2">
                    {navItems.map((item) => {
                        const isActive = pathname === item.href ||
                            (item.href !== '/' && pathname?.startsWith(item.href));

                        const isCenter = item.href === '/app';

                        if (isCenter) {
                            return (
                                <Link
                                    key={item.href}
                                    href={item.href}
                                    onClick={(e) => handleNavClick(e, item)}
                                    className="relative -top-5 flex flex-col items-center justify-center"
                                >
                                    <motion.div
                                        whileHover={{ scale: 1.05 }}
                                        whileTap={{ scale: 0.95 }}
                                        className={`flex items-center justify-center w-14 h-14 rounded-full shadow-[0_8px_25px_-5px_rgba(231,72,2,0.4)] transition-all ${isActive
                                            ? 'bg-brand text-white'
                                            : 'bg-white dark:bg-zinc-800 text-brand border-4 border-zinc-50 dark:border-zinc-900 shadow-lg'
                                            }`}>
                                        <item.icon className="h-6 w-6" />
                                    </motion.div>
                                    <span className={`text-[10px] mt-1.5 font-bold uppercase tracking-wide ${isActive ? 'text-brand' : 'text-zinc-500'}`}>
                                        {item.label}
                                    </span>
                                </Link>
                            );
                        }

                        return (
                            <Link
                                key={item.href}
                                href={item.href}
                                onClick={(e) => handleNavClick(e, item)}
                                className="flex flex-col items-center justify-center py-2 px-2 min-w-[50px] transition-transform active:scale-90"
                            >
                                <div className="relative">
                                    {isActive && (
                                        <motion.div
                                            layoutId="bottomNavActiveBg"
                                            className="absolute -inset-2 bg-brand/10 dark:bg-brand/20 rounded-xl -z-10"
                                            transition={{ type: 'spring', stiffness: 400, damping: 30 }}
                                        />
                                    )}
                                    <item.icon
                                        className={`h-5 w-5 transition-colors ${isActive
                                            ? 'text-brand'
                                            : 'text-zinc-400 dark:text-zinc-500'
                                            }`}
                                    />
                                </div>
                                <span
                                    className={`text-[10px] mt-1 font-semibold transition-colors ${isActive
                                        ? 'text-brand'
                                        : 'text-zinc-400 dark:text-zinc-500'
                                        }`}
                                >
                                    {item.label}
                                </span>
                            </Link>
                        );
                    })}
                </div>
            </nav>

            {/* Login Prompt Modal */}
            <AnimatePresence>
                {showLoginPrompt && (
                    <motion.div
                        initial={{ opacity: 0 }}
                        animate={{ opacity: 1 }}
                        exit={{ opacity: 0 }}
                        className="fixed inset-0 z-[60] flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
                        onClick={() => setShowLoginPrompt(false)}
                    >
                        <motion.div
                            initial={{ scale: 0.9, opacity: 0 }}
                            animate={{ scale: 1, opacity: 1 }}
                            exit={{ scale: 0.9, opacity: 0 }}
                            className="bg-white dark:bg-zinc-900 rounded-2xl p-6 max-w-sm w-full shadow-2xl"
                            onClick={(e) => e.stopPropagation()}
                        >
                            <div className="text-center">
                                <div className="w-16 h-16 mx-auto mb-4 bg-brand/10 rounded-full flex items-center justify-center">
                                    <Sparkles className="w-8 h-8 text-brand" />
                                </div>
                                <h3 className="text-xl font-bold text-zinc-900 dark:text-white mb-2">
                                    Faça login para continuar
                                </h3>
                                <p className="text-zinc-600 dark:text-zinc-400 mb-6">
                                    Você precisa estar logado para acessar {pendingRoute === '/decks' ? 'sua biblioteca' : 'as configurações'}.
                                </p>
                                <div className="flex gap-3">
                                    <button
                                        onClick={() => setShowLoginPrompt(false)}
                                        className="flex-1 px-4 py-3 rounded-xl border border-zinc-200 dark:border-zinc-700 text-zinc-700 dark:text-zinc-300 font-medium hover:bg-zinc-50 dark:hover:bg-zinc-800 transition-colors"
                                    >
                                        Cancelar
                                    </button>
                                    <button
                                        onClick={handleLogin}
                                        className="flex-1 px-4 py-3 rounded-xl bg-brand text-white font-medium hover:bg-brand/90 transition-colors"
                                    >
                                        Fazer login
                                    </button>
                                </div>
                            </div>
                        </motion.div>
                    </motion.div>
                )}
            </AnimatePresence>
        </>
    );
}
