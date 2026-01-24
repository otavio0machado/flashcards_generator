'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import Image from 'next/image';
import { User as UserIcon, LogOut, Menu, X } from 'lucide-react';
import { User } from '@supabase/supabase-js';
import { motion } from 'framer-motion';

export default function Navbar() {
  const router = useRouter();
  const pathname = usePathname();
  const [user, setUser] = useState<User | null>(null);
  const [scrolled, setScrolled] = useState(false);
  const [mobileOpen, setMobileOpen] = useState(false);

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

  const handleLogout = async () => {
    await supabase.auth.signOut();
    router.push('/');
    router.refresh();
  };

  const displayName = (() => {
    const fullName = user?.user_metadata?.full_name;
    if (fullName) return fullName.trim().split(/\s+/)[0];

    const emailPrefix = user?.email?.split('@')[0];
    if (emailPrefix) return emailPrefix.split(/[._-]/)[0];

    return 'Usuario';
  })();

  return (
    <nav className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${scrolled || mobileOpen ? 'bg-white/80 backdrop-blur-md border-b border-border py-2' : 'bg-transparent py-4'
      }`}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <Link href="/" className="flex items-center group">
              <motion.div
                whileHover={{ scale: 1.05 }}
                whileTap={{ scale: 0.95 }}
                className="relative h-9 w-auto transition-transform"
              >
                <Image
                  src="/logo.png"
                  alt="Flashcards Generator"
                  width={150}
                  height={36}
                  className="h-full w-auto object-contain"
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
            <Link href="/guia" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Tutorial
            </Link>
            <Link href="/app" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Gerador (App)
            </Link>

            {user ? (
              <div className="flex items-center gap-4 border-l border-border pl-8">
                <Link href="/settings" className="flex items-center gap-2 px-3 py-1.5 bg-gray-50 rounded-sm border border-border hover:bg-gray-100 transition-all cursor-pointer">
                  <UserIcon className="h-4 w-4 text-foreground/40" />
                  <span className="text-xs font-bold text-foreground/60">
                    {(() => {
                      // 1. Try full name from metadata
                      const fullName = user.user_metadata?.full_name;
                      if (fullName) return fullName.trim().split(/\s+/)[0];

                      // 2. Fallback to email prefix (split by common delimiters)
                      const emailPrefix = user.email?.split('@')[0];
                      if (emailPrefix) return emailPrefix.split(/[._-]/)[0];

                      return 'Usuário';
                    })()}
                  </span>
                </Link>
                <button
                  onClick={handleLogout}
                  className="text-foreground/40 hover:text-red-500 transition-colors"
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
                    className="bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm block"
                  >
                    Criar Conta
                  </Link>
                </motion.div>
              </div>
            )}
          </div>

          <div className="md:hidden">
            <Link
              href={user ? "/app" : "/auth/login"}
              className="bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm"
            >
              {user ? "App" : "Entrar"}
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
}
