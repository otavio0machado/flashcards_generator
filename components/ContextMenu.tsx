'use client';

import React from 'react';
import { m, AnimatePresence } from 'framer-motion';

interface MenuOption {
    id: string;
    label: string;
    icon?: React.ComponentType<React.SVGProps<SVGSVGElement>>;
    destructive?: boolean;
    onClick: () => void;
}

interface ContextMenuProps {
    open: boolean;
    x: number;
    y: number;
    options: MenuOption[];
    onClose: () => void;
}

export default function ContextMenu({ open, x, y, options, onClose }: ContextMenuProps) {
    return (
        <AnimatePresence>
            {open && (
                <m.div
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    transition={{ type: 'spring', stiffness: 500, damping: 30 }}
                    style={{ top: y, left: x }}
                    className="fixed z-[100] bg-[var(--secondary-system-background)] border border-zinc-200 dark:border-zinc-800 rounded-[var(--corner-card)] shadow-lg p-1 w-48"
                    onMouseLeave={onClose}
                >
                    {options.map(opt => (
                        <button
                            key={opt.id}
                            onClick={() => {
                                opt.onClick();
                                onClose();
                            }}
                            className={`w-full flex items-center gap-3 px-3 py-2 text-left text-sm font-medium hover:bg-zinc-50 dark:hover:bg-zinc-900 transition-colors ${opt.destructive ? 'text-red-500' : 'text-foreground'}`}
                        >
                            {opt.icon ? <opt.icon className="w-4 h-4" /> : null}
                            <span className="truncate">{opt.label}</span>
                        </button>
                    ))}
                </m.div>
            )}
        </AnimatePresence>
    );
}
