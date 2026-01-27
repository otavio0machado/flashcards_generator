'use client';

import { usePathname } from 'next/navigation';
import { useTauri } from '@/lib/tauri';

interface TauriMainWrapperProps {
    children: React.ReactNode;
}

export default function TauriMainWrapper({ children }: TauriMainWrapperProps) {
    const pathname = usePathname();
    const { isTauri, isDesktop, sidebarCollapsed } = useTauri();

    const isOnboardingPage = pathname?.startsWith('/desktop/');

    const needsMargin = isTauri && isDesktop && !isOnboardingPage;

    return (
        <main
            className={`min-h-screen transition-[margin-left] duration-300 ease-in-out ${needsMargin
                    ? sidebarCollapsed ? 'ml-16' : 'ml-64'
                    : ''
                } ${isTauri ? 'desktop-density' : ''}`}
        >
            {children}
        </main>
    );
}
