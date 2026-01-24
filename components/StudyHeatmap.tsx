'use client';

import React from 'react';
import { buildActivityRange, StudyActivityRecord } from '@/lib/study-activity';

type StudyHeatmapProps = {
  activityData: StudyActivityRecord[];
  days?: number;
  label?: string;
};

const getLevelClass = (count: number) => {
  if (count <= 0) return 'bg-gray-100 border border-gray-200';
  if (count < 5) return 'bg-emerald-100 border border-emerald-200';
  if (count < 10) return 'bg-emerald-200 border border-emerald-300';
  return 'bg-emerald-500 border border-emerald-500';
};

export default function StudyHeatmap({
  activityData,
  days = 30,
  label = 'Consist\u00eancia (\u00daltimos 30 dias)',
}: StudyHeatmapProps) {
  const range = buildActivityRange(activityData, days);

  return (
    <div className="flex flex-col gap-3">
      <span className="text-xs font-medium text-foreground/50 uppercase tracking-wider">
        {label}
      </span>
      <div className="flex flex-wrap items-end gap-4">
        <div className="grid grid-rows-7 grid-flow-col gap-1">
          {range.map((day) => (
            <div
              key={day.date}
              title={`${day.count} cards em ${day.date}`}
              aria-label={`${day.count} cards em ${day.date}`}
              className={`h-3 w-3 rounded-[3px] transition-colors duration-300 ${getLevelClass(
                day.count
              )}`}
            />
          ))}
        </div>
        <div className="hidden sm:flex items-center gap-1 text-[10px] font-semibold uppercase tracking-wider text-foreground/40">
          <span>menos</span>
          <span className="h-2.5 w-2.5 rounded-[3px] bg-gray-100 border border-gray-200" />
          <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-100 border border-emerald-200" />
          <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-200 border border-emerald-300" />
          <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-500 border border-emerald-500" />
          <span>mais</span>
        </div>
      </div>
    </div>
  );
}
