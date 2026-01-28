'use client';

import React, { useState, useRef, useEffect } from 'react';
import { Search, X } from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { haptic } from '@/lib/haptics';
import { useMobilePreferences } from '@/lib/mobile-preferences';

interface FilterChip {
    id: string;
    label: string;
}

interface SearchBarProps {
    value: string;
    onChange: (value: string) => void;
    onSubmit?: (value: string) => void;
    placeholder?: string;
    filters?: FilterChip[];
    selectedFilters?: string[];
    onFilterChange?: (filters: string[]) => void;
    autoFocus?: boolean;
    className?: string;
}

export default function SearchBar({
    value,
    onChange,
    onSubmit,
    placeholder = 'Buscar...',
    filters,
    selectedFilters = [],
    onFilterChange,
    autoFocus = false,
    className = '',
}: SearchBarProps) {
    const [isFocused, setIsFocused] = useState(false);
    const inputRef = useRef<HTMLInputElement>(null);
    const [prefs] = useMobilePreferences();

    useEffect(() => {
        if (autoFocus && inputRef.current) {
            inputRef.current.focus();
        }
    }, [autoFocus]);

    const handleClear = () => {
        onChange('');
        inputRef.current?.focus();
        if (prefs.hapticFeedbackEnabled) {
            haptic('tap');
        }
    };

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        onSubmit?.(value);
        inputRef.current?.blur();
    };

    const handleFilterToggle = (filterId: string) => {
        if (!onFilterChange) return;

        if (prefs.hapticFeedbackEnabled) {
            haptic('selection');
        }

        const newFilters = selectedFilters.includes(filterId)
            ? selectedFilters.filter(f => f !== filterId)
            : [...selectedFilters, filterId];

        onFilterChange(newFilters);
    };

    return (
        <div className={className}>
            <form onSubmit={handleSubmit}>
                <div
                    className={`
                        flex items-center gap-2 px-3 h-11
                        bg-zinc-100 dark:bg-zinc-800/60
                        rounded-[var(--corner-card)]
                        transition-all duration-200
                        ${isFocused
                            ? 'ring-2 ring-brand/50 bg-white dark:bg-zinc-800'
                            : ''
                        }
                    `}
                >
                    <Search className="w-4 h-4 text-zinc-400 flex-shrink-0" />

                    <input
                        ref={inputRef}
                        type="text"
                        value={value}
                        onChange={(e) => onChange(e.target.value)}
                        onFocus={() => setIsFocused(true)}
                        onBlur={() => setIsFocused(false)}
                        placeholder={placeholder}
                        className="
                            flex-1 bg-transparent
                            text-[var(--label)] placeholder:text-zinc-400
                            text-base outline-none
                            min-w-0
                        "
                        aria-label={placeholder}
                    />

                    <AnimatePresence>
                        {value && (
                            <motion.button
                                type="button"
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={{ opacity: 1, scale: 1 }}
                                exit={{ opacity: 0, scale: 0.8 }}
                                transition={{ duration: 0.15 }}
                                onClick={handleClear}
                                className="
                                    p-1 -mr-1
                                    bg-zinc-300 dark:bg-zinc-600
                                    rounded-full
                                    text-zinc-600 dark:text-zinc-300
                                    active:scale-90
                                    transition-transform
                                "
                                aria-label="Limpar busca"
                            >
                                <X className="w-3.5 h-3.5" />
                            </motion.button>
                        )}
                    </AnimatePresence>
                </div>
            </form>

            {filters && filters.length > 0 && (
                <div className="flex gap-2 mt-3 overflow-x-auto pb-1 -mx-1 px-1 scrollbar-hide">
                    {filters.map((filter) => {
                        const isSelected = selectedFilters.includes(filter.id);
                        return (
                            <button
                                key={filter.id}
                                onClick={() => handleFilterToggle(filter.id)}
                                className={`
                                    flex-shrink-0 px-3 py-1.5
                                    rounded-full text-sm font-medium
                                    transition-all duration-150
                                    active:scale-95
                                    ${isSelected
                                        ? 'bg-brand text-white'
                                        : 'bg-zinc-100 dark:bg-zinc-800 text-zinc-600 dark:text-zinc-400'
                                    }
                                `}
                                aria-pressed={isSelected}
                            >
                                {filter.label}
                            </button>
                        );
                    })}
                </div>
            )}
        </div>
    );
}
