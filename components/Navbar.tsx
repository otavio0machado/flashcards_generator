'use client';

import React, { useCallback, useEffect, useState } from 'react';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import { User as UserIcon, LogOut, Menu, X } from 'lucide-react';
import { User } from '@supabase/supabase-js';
import { motion } from 'framer-motion';
import StreakBadge from '@/components/StreakBadge';
import { addUtcDays, getDateKey, getStudySummary, startOfUtcDay } from '@/lib/study-activity';
import ThemeToggle from '@/components/ThemeToggle';
import Logo from '@/components/Logo';
import { trackEvent } from '@/lib/analytics';
import { useTauri } from '@/lib/tauri';

export default function Navbar() {
  const router = useRouter();
  const pathname = usePathname();
  const { isTauri, isDesktop, isMobile, isTablet } = useTauri();
  const [user, setUser] = useState<User | null>(null);
  const [scrolled, setScrolled] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);
  const [streak, setStreak] = useState(0);
  const [hasStudiedToday, setHasStudiedToday] = useState(false);
  const [isFrozen, setIsFrozen] = useState(false);

  const loadStudySummary = useCallback(async (activeUser: User) => {
    const startDate = addUtcDays(startOfUtcDay(new Date()), -120);
    const startKey = getDateKey(startDate);

    const { data, error } = await supabase
      .from('study_activity')
      .select('day, count')
      .eq('user_id', activeUser.id)
      .gte('day', startKey);

    if (error) {
      console.error('Erro ao carregar atividade de estudo:', error);
      return null;
    }

    return getStudySummary(data ?? []);
  }, []);

  const refreshStudySummary = useCallback(async () => {
    if (!user) return;
    const summary = await loadStudySummary(user);
    if (!summary) return;
    setStreak(summary.streak);
    setHasStudiedToday(summary.hasStudiedToday);
    setIsFrozen(summary.isFrozen);
  }, [loadStudySummary, user]);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  useEffect(() => {
    setMobileOpen(false);
  }, [pathname]);

  useEffect(() => {
    // Get initial session
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
    });

    // Listen for changes
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null);
    });

    return () => subscription.unsubscribe();
  }, []);

  useEffect(() => {
    if (!user) {
      setStreak(0);
      setHasStudiedToday(false);
      setIsFrozen(false);
      return;
    }

    refreshStudySummary();
  }, [refreshStudySummary, user]);

  useEffect(() => {
    if (!user) return;

    const handleUpdate = () => {
      refreshStudySummary();
    };

    window.addEventListener('study-activity-updated', handleUpdate);
    return () => window.removeEventListener('study-activity-updated', handleUpdate);
  }, [refreshStudySummary, user]);

  const handleLogout = async () => {
    setMobileOpen(false);
    await supabase.auth.signOut();
    router.push('/');
    router.refresh();
  };

  const closeMobileMenu = () => setMobileOpen(false);

  const displayName = (() => {
    const fullName = user?.user_metadata?.full_name;
    if (fullName) return fullName.trim().split(/\s+/)[0];

    const emailPrefix = user?.email?.split('@')[0];
    if (emailPrefix) return emailPrefix.split(/[._-]/)[0];

    return 'Usuario';
  })();

  // Hide Navbar in Tauri desktop (we have sidebar instead)
  // Also hide on mobile/tablet completely since we have bottom nav
  if ((isTauri && isDesktop) || isMobile || isTablet) {
    return null;
  }

  return (
    <nav className={`fixed top-0 left-0 right-0 z-[60] transition-all duration-300 ${scrolled || mobileOpen ? 'bg-white/80 dark:bg-zinc-950/80 backdrop-blur-md border-b border-border py-2' : 'bg-transparent py-4'
      }`}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <Link href="/" className="flex items-center group">
              <motion.div
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className="transition-transform"
              >
                <Logo
                  className="h-12 w-[170px] sm:h-14 sm:w-[200px]"
                  priority
                />
              </motion.div>
            </Link>
          </div>

          <div className="hidden md:flex items-center gap-8">
            {user && (
              <Link href="/decks" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
                Minha Biblioteca
              </Link>
            )}
            <Link href="/marketplace" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Marketplace
            </Link>
            <Link href="/download" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Download
            </Link>
            <Link href="/guia" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Tutorial
            </Link>
            <Link href="/documentacao" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Documentacao
            </Link>
            <Link href="/app" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Gerador (App)
            </Link>

            <ThemeToggle className="p-2 rounded-sm border border-border bg-white/80 text-foreground/70 hover:text-foreground hover:bg-gray-50 transition-colors" />

            {user ? (
              <div className="flex items-center gap-4 border-l border-border pl-8">
                <StreakBadge
                  streak={streak}
                  hasStudiedToday={hasStudiedToday}
                  isFrozen={isFrozen}
                />
                <Link href="/settings" className="flex items-center gap-2 px-3 py-1.5 bg-gray-50 rounded-sm border border-border hover:bg-gray-100 transition-all cursor-pointer">
                  <UserIcon className="h-4 w-4 text-foreground/60" />
                  <span className="text-xs font-bold text-foreground/70">
                    {displayName}
                  </span>
                </Link>
                <button
                  onClick={handleLogout}
                  className="text-foreground/60 hover:text-red-500 transition-colors"
                  title="Sair"
                >
                  <LogOut className="h-5 w-5" />
                </button>
              </div>
            ) : (
              <div className="flex items-center gap-4">
                <Link href="/auth/login" className="text-sm font-bold text-foreground/60 hover:text-foreground transition-colors">
                  Entrar
                </Link>
                <motion.div
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                >
                  <Link
                    href="/auth/signup"
                    onClick={() => trackEvent('signup_started', { location: 'navbar' })}
                    className="bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm block"
                  >
                    Criar Conta
                  </Link>
                </motion.div>
              </div>
            )}
          </div>

          <div className="md:hidden flex items-center gap-2">
            <Link
              href={user ? "/app" : "/auth/login"}
              className="bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm"
            >
              {user ? "App" : "Entrar"}
            </Link>
            <ThemeToggle className="p-2 rounded-sm border border-border bg-white/80 text-foreground/70 hover:text-foreground hover:bg-gray-50 transition-colors" />
            <button
              type="button"
              onClick={() => setMobileOpen((open) => !open)}
              aria-label={mobileOpen ? "Fechar menu" : "Abrir menu"}
              aria-expanded={mobileOpen}
              aria-controls="mobile-nav"
              className="p-2 rounded-sm border border-border bg-white/80 text-foreground/70 hover:text-foreground hover:bg-gray-50 transition-colors"
            >
              {mobileOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
            </button>
          </div>
        </div>
      </div>

      {mobileOpen && (
        <div id="mobile-nav" className="md:hidden border-t border-border bg-white/95 dark:bg-zinc-950/95 backdrop-blur-md">
          <div className="px-4 py-4 space-y-1">
            {user && (
              <div className="flex items-center justify-between gap-3 px-3 py-3 mb-2 rounded-sm border border-border bg-gray-50">
                <span className="text-xs font-bold text-foreground/60">
                  Oi, {displayName}
                </span>
                <StreakBadge
                  streak={streak}
                  hasStudiedToday={hasStudiedToday}
                  isFrozen={isFrozen}
                />
              </div>
            )}
            <Link href="/" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Inicio
            </Link>
            <Link href="/guia" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Tutorial
            </Link>
            <Link href="/documentacao" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Documentacao
            </Link>
            <Link href="/marketplace" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Marketplace
            </Link>
            <Link href="/download" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Download
            </Link>
            <Link href="/app" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
              Gerador (App)
            </Link>
            {user && (
              <Link href="/decks" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
                Minha Biblioteca
              </Link>
            )}
            {user && (
              <Link href="/settings" onClick={closeMobileMenu} className="block px-3 py-4 rounded-sm text-sm font-semibold text-foreground/70 hover:text-brand hover:bg-gray-50 transition-colors">
                Minha Conta
              </Link>
            )}
            {user ? (
              <button
                type="button"
                onClick={handleLogout}
                className="w-full text-left px-3 py-4 rounded-sm text-sm font-semibold text-red-600 hover:bg-red-50 transition-colors"
              >
                Sair
              </button>
            ) : (
              <div className="pt-2">
                <Link
                  href="/auth/signup"
                  onClick={closeMobileMenu}
                  className="block w-full text-center bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm"
                >
                  Criar Conta
                </Link>
              </div>
            )}
          </div>
        </div>
      )}
    </nav>
  );
}
