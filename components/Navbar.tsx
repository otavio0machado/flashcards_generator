'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { supabase } from '@/lib/supabase';
import Image from 'next/image';
import { User, LogOut } from 'lucide-react';

export default function Navbar() {
  const router = useRouter();
  const [user, setUser] = useState<any>(null);

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

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-md border-b border-border">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <Link href="/" className="flex items-center gap-3 group">
              <div className="relative h-10 w-10 overflow-hidden transform group-hover:scale-110 transition-transform">
                <Image
                  src="/logo.png"
                  alt="Icon"
                  width={40}
                  height={40}
                  className="object-contain"
                  priority
                />
              </div>
              <span className="text-xl font-black tracking-tighter text-foreground whitespace-nowrap">
                Flashcards <span className="text-brand">Generator</span>
              </span>
            </Link>
          </div>

          <div className="hidden md:flex items-center gap-8">
            <Link href="/" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Início
            </Link>
            <Link href="/guia" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Como Usar
            </Link>
            {user && (
              <Link href="/decks" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
                Minha Biblioteca
              </Link>
            )}
            <Link href="/app" className="text-sm font-medium text-foreground/70 hover:text-brand transition-colors">
              Gerador (App)
            </Link>

            {user ? (
              <div className="flex items-center gap-4 border-l border-border pl-8">
                <div className="flex items-center gap-2 px-3 py-1.5 bg-gray-50 rounded-sm border border-border">
                  <User className="h-4 w-4 text-foreground/40" />
                  <span className="text-xs font-bold text-foreground/60">{user.email?.split('@')[0]}</span>
                </div>
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
                <Link
                  href="/auth/signup"
                  className="bg-brand text-white px-4 py-2 rounded-sm text-sm font-bold hover:bg-brand/90 transition-all shadow-sm"
                >
                  Criar Conta
                </Link>
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
