'use client';

import { useCallback, useEffect, useState, useRef } from 'react';
import { usePathname, useRouter } from 'next/navigation';
import Link from 'next/link';
import { BookOpen, Store, Settings, Sparkles, LogOut, Sun, Moon, Flame, PanelLeftClose, PanelLeftOpen } from 'lucide-react';
import Logo from '@/components/Logo';
import { useTauri, useDesktopShortcuts } from '@/lib/tauri';
import { supabase } from '@/lib/supabase';
import { User } from '@supabase/supabase-js';
import { addUtcDays, getDateKey, getStudySummary, startOfUtcDay } from '@/lib/study-activity';
import { motion, AnimatePresence } from 'framer-motion';

const navItems = [
    { href: '/app', icon: Sparkles, label: 'Gerar Flashcards', shortcut: 'Ctrl+N' },
    { href: '/decks', icon: BookOpen, label: 'Minha Biblioteca', shortcut: 'Ctrl+B' },
    { href: '/marketplace', icon: Store, label: 'Explorar Decks', shortcut: 'Ctrl+E' },
    { href: '/settings', icon: Settings, label: 'Configurações', shortcut: 'Ctrl+,' },
];

export default function DesktopSidebar() {
    const pathname = usePathname();
    const router = useRouter();
    const { isTauri, isDesktop, appVersion, sidebarCollapsed, setSidebarCollapsed } = useTauri();
    const [user, setUser] = useState<User | null>(null);
    const [theme, setTheme] = useState<'light' | 'dark'>('light');
    const [streak, setStreak] = useState(0);
    const [focusedIndex, setFocusedIndex] = useState(-1);
    const navRefs = useRef<(HTMLAnchorElement | null)[]>([]);

    // Register global keyboard shortcuts
    useDesktopShortcuts();

    const isOnboardingPage = pathname?.startsWith('/desktop/');

    useEffect(() => {
        const storedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null;
        if (storedTheme) setTheme(storedTheme);
    }, []);

    useEffect(() => {
        supabase.auth.getSession().then(({ data: { session } }) => {
            setUser(session?.user ?? null);
        });

        const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
            setUser(session?.user ?? null);
        });

        return () => subscription.unsubscribe();
    }, []);

    const loadStreak = useCallback(async (activeUser: User) => {
        const startDate = addUtcDays(startOfUtcDay(new Date()), -120);
        const startKey = getDateKey(startDate);

        const { data, error } = await supabase
            .from('study_activity')
            .select('day, count')
            .eq('user_id', activeUser.id)
            .gte('day', startKey);

        if (error || !data) return;

        const summary = getStudySummary(data);
        setStreak(summary.streak);
    }, []);

    useEffect(() => {
        if (user) loadStreak(user);
    }, [user, loadStreak]);

    const toggleTheme = () => {
        const newTheme = theme === 'light' ? 'dark' : 'light';
        setTheme(newTheme);
        localStorage.setItem('theme', newTheme);
        document.documentElement.classList.toggle('dark', newTheme === 'dark');
        document.documentElement.setAttribute('data-theme', newTheme);
    };

    const handleLogout = async () => {
        await supabase.auth.signOut();
        router.push('/auth/login');
    };

    const displayName = (() => {
        const fullName = user?.user_metadata?.full_name;
        if (fullName) return fullName.trim().split(/\s+/)[0];
        const emailPrefix = user?.email?.split('@')[0];
        if (emailPrefix) return emailPrefix.split(/[._-]/)[0];
        return 'Usuário';
    })();

    const handleNavKeyDown = (e: React.KeyboardEvent) => {
        if (e.key === 'ArrowDown') {
            e.preventDefault();
            const next = Math.min(focusedIndex + 1, navItems.length - 1);
            setFocusedIndex(next);
            navRefs.current[next]?.focus();
        } else if (e.key === 'ArrowUp') {
            e.preventDefault();
            const prev = Math.max(focusedIndex - 1, 0);
            setFocusedIndex(prev);
            navRefs.current[prev]?.focus();
        }
    };

    if (!isTauri || !isDesktop || isOnboardingPage) {
        return null;
    }

    return (
        <motion.aside
            role="navigation"
            aria-label="Menu principal do desktop"
            className={`fixed left-0 top-0 bottom-0 flex flex-col z-40 bg-[var(--background)] border-r border-[var(--color-border)] transition-[width] duration-300 ease-in-out ${sidebarCollapsed ? 'w-16' : 'w-64'
                }`}
            layout
        >
            {/* Logo */}
            <div className={`h-16 flex items-center border-b border-[var(--color-border)] ${sidebarCollapsed ? 'justify-center px-0' : 'px-4'}`}>
                {sidebarCollapsed ? (
                    <div className="w-8 h-8 bg-brand rounded-sm flex items-center justify-center shrink-0">
                        <span className="text-white font-black text-sm">F</span>
                    </div>
                ) : (
                    <div className="flex-1">
                        <Logo className="h-7 w-auto" />
                    </div>
                )}
            </div>

            {/* User Info */}
            {user && !sidebarCollapsed && (
                <div className="p-4 border-b border-[var(--color-border)]">
                    <div className="flex items-center gap-3 p-3 rounded-sm bg-[var(--surface)] border border-[var(--color-border)]">
                        <div className="w-8 h-8 bg-brand/10 rounded-full flex items-center justify-center shrink-0">
                            <span className="text-brand font-bold text-xs">
                                {displayName.charAt(0).toUpperCase()}
                            </span>
                        </div>
                        <div className="flex-1 min-w-0">
                            <p className="font-bold text-xs truncate text-[var(--foreground)]">
                                {displayName}
                            </p>
                            <div className="flex items-center gap-1 text-[10px] text-[var(--color-text-secondary)]">
                                <Flame className="w-3 h-3 text-brand" />
                                <span>{streak} dias</span>
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {/* Collapsed user avatar */}
            {user && sidebarCollapsed && (
                <div className="p-2 border-b border-[var(--color-border)] flex justify-center">
                    <div className="w-8 h-8 bg-brand/10 rounded-full flex items-center justify-center" title={displayName}>
                        <span className="text-brand font-bold text-xs">
                            {displayName.charAt(0).toUpperCase()}
                        </span>
                    </div>
                </div>
            )}

            {/* Navigation */}
            <nav
                className="flex-1 p-2 space-y-1 overflow-y-auto"
                onKeyDown={handleNavKeyDown}
            >
                {!sidebarCollapsed && (
                    <p className="px-3 py-2 text-[10px] font-black uppercase tracking-widest text-[var(--color-text-secondary)]">
                        Menu
                    </p>
                )}
                {navItems.map((item, index) => {
                    const isActive = pathname === item.href ||
                        (item.href !== '/app' && pathname?.startsWith(item.href));

                    return (
                        <Link
                            key={item.href}
                            href={item.href}
                            ref={(el) => { navRefs.current[index] = el; }}
                            aria-current={isActive ? 'page' : undefined}
                            title={sidebarCollapsed ? `${item.label} (${item.shortcut})` : item.shortcut}
                            className={`flex items-center gap-3 rounded-sm transition-all duration-200 outline-none focus-visible:ring-2 focus-visible:ring-brand ${sidebarCollapsed ? 'justify-center px-1 py-3' : 'px-3 py-2.5'
                                } ${isActive
                                    ? 'bg-brand text-white shadow-sm font-semibold'
                                    : 'text-[var(--color-text-secondary)] hover:bg-[var(--surface-muted,var(--surface))] hover:text-[var(--foreground)] font-medium'
                                }`}
                            onFocus={() => setFocusedIndex(index)}
                        >
                            <item.icon className={`shrink-0 ${sidebarCollapsed ? 'h-5 w-5' : 'h-4 w-4'}`} />
                            <AnimatePresence>
                                {!sidebarCollapsed && (
                                    <motion.span
                                        initial={{ opacity: 0, width: 0 }}
                                        animate={{ opacity: 1, width: 'auto' }}
                                        exit={{ opacity: 0, width: 0 }}
                                        transition={{ duration: 0.15 }}
                                        className="text-sm whitespace-nowrap overflow-hidden"
                                    >
                                        {item.label}
                                    </motion.span>
                                )}
                            </AnimatePresence>
                        </Link>
                    );
                })}
            </nav>

            {/* Footer Actions */}
            <div className="p-2 space-y-1 border-t border-[var(--color-border)]">
                {/* Collapse Toggle */}
                <button
                    onClick={() => setSidebarCollapsed(!sidebarCollapsed)}
                    aria-label={sidebarCollapsed ? 'Expandir menu' : 'Recolher menu'}
                    className={`w-full flex items-center gap-3 rounded-sm transition-all duration-200 text-[var(--color-text-secondary)] hover:bg-[var(--surface-muted,var(--surface))] hover:text-[var(--foreground)] outline-none focus-visible:ring-2 focus-visible:ring-brand ${sidebarCollapsed ? 'justify-center px-1 py-3' : 'px-3 py-2.5'
                        }`}
                >
                    {sidebarCollapsed ? (
                        <PanelLeftOpen className="h-5 w-5 shrink-0" />
                    ) : (
                        <>
                            <PanelLeftClose className="h-4 w-4 shrink-0" />
                            <span className="font-medium text-sm">Recolher</span>
                        </>
                    )}
                </button>

                {/* Theme Toggle */}
                <button
                    onClick={toggleTheme}
                    aria-label={theme === 'light' ? 'Ativar modo escuro' : 'Ativar modo claro'}
                    className={`w-full flex items-center gap-3 rounded-sm transition-all duration-200 text-[var(--color-text-secondary)] hover:bg-[var(--surface-muted,var(--surface))] hover:text-[var(--foreground)] outline-none focus-visible:ring-2 focus-visible:ring-brand ${sidebarCollapsed ? 'justify-center px-1 py-3' : 'px-3 py-2.5'
                        }`}
                >
                    {theme === 'light' ? (
                        <>
                            <Moon className="h-5 w-5 shrink-0" />
                            {!sidebarCollapsed && <span className="font-medium text-sm">Modo Escuro</span>}
                        </>
                    ) : (
                        <>
                            <Sun className="h-5 w-5 shrink-0" />
                            {!sidebarCollapsed && <span className="font-medium text-sm">Modo Claro</span>}
                        </>
                    )}
                </button>

                {/* Logout or Login */}
                {user ? (
                    <button
                        onClick={handleLogout}
                        aria-label="Sair da conta"
                        className={`w-full flex items-center gap-3 rounded-sm transition-all duration-200 text-red-500 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-950/30 outline-none focus-visible:ring-2 focus-visible:ring-red-400 ${sidebarCollapsed ? 'justify-center px-1 py-3' : 'px-3 py-2.5'
                            }`}
                    >
                        <LogOut className={`shrink-0 ${sidebarCollapsed ? 'h-5 w-5' : 'h-4 w-4'}`} />
                        {!sidebarCollapsed && <span className="font-medium text-sm">Sair da Conta</span>}
                    </button>
                ) : (
                    <button
                        onClick={() => router.push('/auth/login')}
                        aria-label="Entrar na conta"
                        className={`w-full flex items-center gap-3 rounded-sm transition-all duration-200 text-brand hover:bg-brand/10 outline-none focus-visible:ring-2 focus-visible:ring-brand ${sidebarCollapsed ? 'justify-center px-1 py-3' : 'px-3 py-2.5'
                            }`}
                    >
                        <LogOut className={`shrink-0 rotate-180 ${sidebarCollapsed ? 'h-5 w-5' : 'h-4 w-4'}`} />
                        {!sidebarCollapsed && <span className="font-medium text-sm">Entrar</span>}
                    </button>
                )}

                {/* Version */}
                {!sidebarCollapsed && (
                    <p className="text-[10px] text-center pt-2 text-[var(--color-text-secondary)] opacity-50">
                        v{appVersion || '1.0.0'}
                    </p>
                )}
            </div>
        </motion.aside>
    );
}
