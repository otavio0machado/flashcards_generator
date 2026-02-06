'use client';

import React, { useState } from 'react';
import { Star } from 'lucide-react';

interface StarRatingProps {
    value: number;
    onChange?: (rating: number) => void;
    readonly?: boolean;
    size?: 'sm' | 'md';
}

export default function StarRating({ value, onChange, readonly = false, size = 'md' }: StarRatingProps) {
    const [hoverValue, setHoverValue] = useState(0);

    const isInteractive = !readonly && !!onChange;
    const iconSize = size === 'sm' ? 'h-4 w-4' : 'h-5 w-5';
    const displayValue = hoverValue || value;

    return (
        <div
            className={`inline-flex items-center gap-0.5 ${isInteractive ? 'cursor-pointer' : ''}`}
            onMouseLeave={() => isInteractive && setHoverValue(0)}
        >
            {[1, 2, 3, 4, 5].map((star) => {
                const isFilled = star <= displayValue;

                return (
                    <button
                        key={star}
                        type="button"
                        disabled={!isInteractive}
                        onClick={() => isInteractive && onChange!(star)}
                        onMouseEnter={() => isInteractive && setHoverValue(star)}
                        className={`p-0 border-0 bg-transparent transition-colors duration-150 ${
                            isInteractive ? 'hover:scale-110 active:scale-95' : ''
                        } disabled:cursor-default`}
                        aria-label={`${star} estrela${star > 1 ? 's' : ''}`}
                    >
                        <Star
                            className={`${iconSize} transition-colors duration-150 ${
                                isFilled
                                    ? 'text-amber-400'
                                    : 'text-foreground/15'
                            }`}
                            fill={isFilled ? 'currentColor' : 'none'}
                        />
                    </button>
                );
            })}
        </div>
    );
}
