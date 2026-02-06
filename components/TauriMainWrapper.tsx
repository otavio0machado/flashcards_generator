'use client';

import { usePathname } from 'next/navigation';
import { useTauri } from '@/lib/tauri';
import { usePWA } from '@/lib/pwa';

interface TauriMainWrapperProps {
    children: React.ReactNode;
}

export default function TauriMainWrapper({ children }: TauriMainWrapperProps) {
    const pathname = usePathname();
    const { isTauri, isDesktop, sidebarCollapsed } = useTauri();
    const { isStandalone } = usePWA();

    const isOnboardingPage = pathname?.startsWith('/desktop/');

    const needsMargin = isTauri && isDesktop && !isOnboardingPage;

    return (
        <main
            className={`min-h-screen transition-[margin-left] duration-300 ease-in-out ${needsMargin
                    ? sidebarCollapsed ? 'ml-16' : 'ml-64'
                    : ''
                } ${isTauri ? 'desktop-density' : ''} ${
                    isStandalone ? '!pt-0 pb-20' : ''
                }`}
        >
            {children}
        </main>
    );
}
