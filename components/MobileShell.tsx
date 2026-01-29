'use client';

import React from 'react';

interface MobileShellProps {
  children: React.ReactNode;
  className?: string;
  title?: string;
}

export default function MobileShell({ children, className = '', title }: MobileShellProps) {
  return (
    <div className={`ios-safe min-h-screen bg-[var(--system-background)] text-[var(--label)] ${className}`}>
      <div className="max-w-md mx-auto px-[var(--spacing-16)] pt-4 pb-20">
        {title && (
          <header className="mb-4">
            <h1 className="text-2xl font-bold">{title}</h1>
          </header>
        )}
        {children}
      </div>
    </div>
  );
}
