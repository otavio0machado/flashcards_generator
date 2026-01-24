'use client';

import React, { useEffect, useRef, useState } from 'react';
import { Flame } from 'lucide-react';

type StreakBadgeProps = {
  streak: number;
  hasStudiedToday: boolean;
  isFrozen?: boolean;
  className?: string;
};

const getStatusLabel = (hasStudiedToday: boolean, isFrozen: boolean, streak: number) => {
  if (streak <= 0) return 'streak inativo';
  if (isFrozen) return 'streak congelado';
  return hasStudiedToday ? 'streak ativo' : 'streak inativo';
};

export default function StreakBadge({
  streak,
  hasStudiedToday,
  isFrozen = false,
  className = '',
}: StreakBadgeProps) {
  const [pulse, setPulse] = useState(false);
  const previous = useRef<boolean | null>(null);

  useEffect(() => {
    if (previous.current === null) {
      previous.current = hasStudiedToday;
      return;
    }

    if (!previous.current && hasStudiedToday) {
      setPulse(true);
      const timeout = setTimeout(() => setPulse(false), 650);
      previous.current = hasStudiedToday;
      return () => clearTimeout(timeout);
    }

    previous.current = hasStudiedToday;
  }, [hasStudiedToday]);

  const statusLabel = getStatusLabel(hasStudiedToday, isFrozen, streak);
  const isActive = hasStudiedToday && streak > 0;
  const isFrozenState = isFrozen && !hasStudiedToday && streak > 0;
  const tooltipLabel = `${statusLabel} - ${streak} dias`;

  const baseClass =
    'flex items-center gap-1.5 px-3 py-1 rounded-full border text-xs font-semibold transition-colors duration-300';

  const statusClass = isFrozenState
    ? 'bg-blue-50 border-blue-200 text-blue-500'
    : isActive
      ? 'bg-orange-50 border-orange-200 text-orange-600'
      : 'bg-gray-50 border-gray-200 text-gray-400 grayscale';

  const iconClass = isFrozenState
    ? 'text-blue-400'
    : isActive
      ? 'text-orange-600 fill-orange-500'
      : 'text-gray-400';

  return (
    <div
      aria-label={tooltipLabel}
      className={`${baseClass} ${statusClass} ${pulse ? 'animate-streak-pulse' : ''} ${className}`}
    >
      <span title={tooltipLabel} aria-label={tooltipLabel} className="inline-flex">
        <Flame className={`h-3.5 w-3.5 ${iconClass}`} />
      </span>
      <span className="font-mono">{streak}</span>
    </div>
  );
}
