'use client';

import { usePathname } from 'next/navigation';
import Link from 'next/link';
import { Home, BookOpen, Store, Settings, Sparkles } from 'lucide-react';
import { motion } from 'framer-motion';

const navItems = [
    { href: '/', icon: Home, label: 'Início' },
    { href: '/marketplace', icon: Store, label: 'Explorar' },
    { href: '/app', icon: Sparkles, label: 'Gerar' },
    { href: '/decks', icon: BookOpen, label: 'Biblioteca' },
    { href: '/settings', icon: Settings, label: 'Config' },
];

export default function BottomNav() {
    const pathname = usePathname();

    // Don't show on auth pages
    if (pathname?.startsWith('/auth')) {
        return null;
    }

    return (
        <nav className="fixed bottom-0 left-0 right-0 z-50 md:hidden pb-safe">
            {/* Glossy Background */}
            <div className="absolute inset-0 bg-white/90 dark:bg-zinc-950/90 backdrop-blur-xl border-t border-zinc-200/50 dark:border-zinc-800/50 shadow-[0_-4px_20px_-5px_rgba(0,0,0,0.1)]" />

            <div className="relative flex items-center justify-between px-4 pt-2">
                {navItems.map((item, index) => {
                    const isActive = pathname === item.href ||
                        (item.href !== '/' && pathname?.startsWith(item.href));

                    const isCenter = item.href === '/app';

                    if (isCenter) {
                        return (
                            <Link
                                key={item.href}
                                href={item.href}
                                className="relative -top-5 flex flex-col items-center justify-center"
                            >
                                <motion.div
                                    whileHover={{ scale: 1.05 }}
                                    whileTap={{ scale: 0.95 }}
                                    className={`flex items-center justify-center w-16 h-16 rounded-full shadow-[0_8px_25px_-5px_rgba(231,72,2,0.4)] transition-all ${isActive
                                        ? 'bg-brand text-white'
                                        : 'bg-white dark:bg-zinc-800 text-brand border-4 border-zinc-50 dark:border-zinc-900 shadow-lg'
                                        }`}>
                                    <item.icon className="h-7 w-7" />
                                </motion.div>
                                <span className={`text-[10px] mt-2 font-black uppercase tracking-widest ${isActive ? 'text-brand' : 'text-zinc-500'}`}>
                                    {item.label}
                                </span>
                            </Link>
                        );
                    }

                    return (
                        <Link
                            key={item.href}
                            href={item.href}
                            className="flex flex-col items-center justify-center py-2 px-3 min-w-[60px] transition-transform active:scale-90"
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
                                className={`text-[10px] mt-1.5 font-semibold transition-colors ${isActive
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
    );
}
