'use client';

import React, { useEffect, useState } from 'react';
import { CheckCircle, AlertCircle, X, Info } from 'lucide-react';

export type ToastType = 'success' | 'error' | 'info';

interface ToastProps {
    message: string;
    type: ToastType;
    duration?: number;
    onClose: () => void;
}

export default function Toast({ message, type, duration = 5000, onClose }: ToastProps) {
    const [isVisible, setIsVisible] = useState(true);

    useEffect(() => {
        const timer = setTimeout(() => {
            setIsVisible(false);
            setTimeout(onClose, 300); // Wait for animation
        }, duration);

        return () => clearTimeout(timer);
    }, [duration, onClose]);

    const styles = {
        success: 'bg-green-50 text-green-800 border-green-100',
        error: 'bg-red-50 text-red-800 border-red-100',
        info: 'bg-brand/5 text-brand border-brand/10'
    };

    const icons = {
        success: <CheckCircle className="h-4 w-4 text-green-500" />,
        error: <AlertCircle className="h-4 w-4 text-red-500" />,
        info: <Info className="h-4 w-4 text-brand" />
    };

    return (
        <div className={`fixed bottom-8 left-1/2 -translate-x-1/2 z-[200] flex items-center gap-3 px-4 py-3 rounded-sm border shadow-lg transition-all duration-300 ${styles[type]} ${isVisible ? 'translate-y-0 opacity-100 scale-100' : 'translate-y-4 opacity-0 scale-95'}`}>
            <div className="shrink-0">{icons[type]}</div>
            <p className="text-sm font-bold tracking-tight uppercase tracking-widest text-[10px] sm:text-[11px]">
                {message}
            </p>
            <button
                onClick={() => {
                    setIsVisible(false);
                    setTimeout(onClose, 300);
                }}
                className="ml-2 hover:opacity-70 transition-opacity"
            >
                <X className="h-3 w-3" />
            </button>
        </div>
    );
}
