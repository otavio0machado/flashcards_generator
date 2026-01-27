'use client';

import { usePathname } from 'next/navigation';
import Link from 'next/link';
import { Home, BookOpen, Store, Settings, Sparkles } from 'lucide-react';
import { motion } from 'framer-motion';

const navItems = [
    { href: '/', icon: Home, label: 'Início' },
    { href: '/app', icon: Sparkles, label: 'Gerar' },
    { href: '/decks', icon: BookOpen, label: 'Biblioteca' },
    { href: '/marketplace', icon: Store, label: 'Explorar' },
    { href: '/settings', icon: Settings, label: 'Config' },
];

export default function BottomNav() {
    const pathname = usePathname();

    // Don't show on auth pages
    if (pathname?.startsWith('/auth')) {
        return null;
    }

    return (
        <nav className="fixed bottom-0 left-0 right-0 z-50 md:hidden">
            {/* Blur background */}
            <div className="absolute inset-0 bg-white/80 dark:bg-zinc-900/80 backdrop-blur-lg border-t border-zinc-200 dark:border-zinc-800" />
            
            {/* Safe area padding for iOS */}
            <div className="relative flex items-center justify-around px-2 pb-safe pt-2">
                {navItems.map((item) => {
                    const isActive = pathname === item.href || 
                        (item.href !== '/' && pathname?.startsWith(item.href));
                    
                    return (
                        <Link
                            key={item.href}
                            href={item.href}
                            className="relative flex flex-col items-center justify-center py-2 px-3 min-w-[64px]"
                        >
                            {isActive && (
                                <motion.div
                                    layoutId="bottomNavIndicator"
                                    className="absolute -top-1 left-1/2 -translate-x-1/2 w-8 h-1 bg-brand rounded-full"
                                    transition={{ type: 'spring', stiffness: 500, damping: 30 }}
                                />
                            )}
                            <item.icon 
                                className={`h-5 w-5 mb-1 transition-colors ${
                                    isActive 
                                        ? 'text-brand' 
                                        : 'text-zinc-500 dark:text-zinc-400'
                                }`} 
                            />
                            <span 
                                className={`text-[10px] font-medium transition-colors ${
                                    isActive 
                                        ? 'text-brand' 
                                        : 'text-zinc-500 dark:text-zinc-400'
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
