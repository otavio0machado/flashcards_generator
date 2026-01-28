'use client';

import React from 'react';

/**
 * AppShell
 *
 * Centralized page shell that guarantees consistent top spacing across all screens,
 * handles the device safe area (status bar), and provides a single header layout
 * for title/eyebrow/subtitle and optional header actions (CTAs).
 *
 * Usage:
 * <AppShell title="Minha Página" eyebrow="SEÇÃO" subtitle="Breve descrição">
 *   ...page content...
 * </AppShell>
 *
 * This prevents per-page top margin/padding variations and keeps the main H1
 * visually aligned across mobile and desktop breakpoints.
 */

interface AppShellProps {
  title?: React.ReactNode;
  eyebrow?: string;
  subtitle?: React.ReactNode;
  headerActions?: React.ReactNode;
  titleClassName?: string;
  maxWidthClass?: string; // Tailwind max width class (e.g., 'max-w-7xl')
  children?: React.ReactNode;
  className?: string;
}

export default function AppShell({ title, eyebrow, subtitle, headerActions, titleClassName, maxWidthClass = 'max-w-7xl', children, className = '' }: AppShellProps) {
  // Use safe-area-inset-top + standard top spacing so all screens align
  // Base spacing: mobile pt-12 (48px), md:pt-20 (80px)
  const topPadding = 'calc(env(safe-area-inset-top, 0px) + 3rem)';
  const topPaddingMd = 'calc(env(safe-area-inset-top, 0px) + 5rem)';

  return (
    <div>
      <div
        style={{ paddingTop: topPadding }}
        className={`${maxWidthClass} mx-auto px-4 sm:px-6 lg:px-8 pt-12 md:pt-20`}
      >
        <header className={`mb-8 ${className}`}>
          {/* Stack on small screens to avoid overlap with headerActions; align side-by-side on sm+ */}
          <div className="flex flex-col sm:flex-row items-start sm:items-end justify-between gap-6">
            <div>
              {eyebrow && <p className="text-[11px] font-black uppercase tracking-widest text-brand mb-3">{eyebrow}</p>}
              {title && (
                <h1 className={`${titleClassName ?? 'text-3xl md:text-4xl'} font-bold tracking-tight text-foreground`}>{title}</h1>
              )}
              {subtitle && <p className="text-foreground/60 font-medium mt-2">{subtitle}</p>}
            </div>
            {/* Optional header actions (e.g., CTA) can be provided by pages via headerActions prop */}
            <div className="flex-shrink-0 mt-4 sm:mt-0 max-w-[260px] w-full sm:w-auto">{(headerActions as React.ReactNode) ?? null}</div>
          </div>
        </header>
      </div>

      {/* Content area — note we keep the same horizontal paddings to align content with header */}
      <div className={`${maxWidthClass} mx-auto px-4 sm:px-6 lg:px-8 pb-12 md:pb-20`}>{children}</div>

    </div>
  );
}
