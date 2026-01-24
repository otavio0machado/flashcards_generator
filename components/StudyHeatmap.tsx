'use client';

import React, { useEffect, useMemo, useState } from 'react';
import {
  buildActivityRange,
  getDateKey,
  getStudySummary,
  parseDateKey,
  startOfUtcDay,
  StudyActivityDay,
  StudyActivityRecord,
} from '@/lib/study-activity';

type StudyHeatmapProps = {
  activityData: StudyActivityRecord[];
  days?: number;
  label?: string;
  ctaHref?: string;
};

const RANGE_OPTIONS = [7, 30, 90];
const WEEKLY_GOAL = 4;

const getRangeSummary = (range: StudyActivityDay[]) => {
  let activeDays = 0;
  let totalCards = 0;
  let bestStreak = 0;
  let currentStreak = 0;
  let lastActiveKey: string | null = null;

  for (const day of range) {
    totalCards += day.count;
    if (day.count > 0) {
      activeDays += 1;
      currentStreak += 1;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
      }
      lastActiveKey = day.date;
    } else {
      currentStreak = 0;
    }
  }

  const averagePerDay = range.length ? totalCards / range.length : 0;
  const averagePerActiveDay = activeDays ? totalCards / activeDays : 0;

  return {
    activeDays,
    totalCards,
    averagePerDay,
    averagePerActiveDay,
    bestStreak,
    lastActiveKey,
  };
};

const getWeeklyTotals = (range: StudyActivityDay[]) => {
  const weeks: { total: number; from: string; to: string }[] = [];
  for (let i = 0; i < range.length; i += 7) {
    const slice = range.slice(i, i + 7);
    if (slice.length === 0) continue;
    const total = slice.reduce((sum, day) => sum + day.count, 0);
    weeks.push({
      total,
      from: slice[0].date,
      to: slice[slice.length - 1].date,
    });
  }
  return weeks;
};

const getThresholds = (normalize: boolean, average: number) => {
  if (!normalize || average <= 0) {
    return { lowMax: 4, midMax: 9 };
  }

  const lowMax = Math.max(1, Math.round(average * 0.75));
  const midMax = Math.max(lowMax + 1, Math.round(average * 1.5));
  return { lowMax, midMax };
};

const getLevelClass = (count: number, thresholds: { lowMax: number; midMax: number }) => {
  if (count <= 0) return 'bg-gray-100 border border-gray-200';
  if (count <= thresholds.lowMax) return 'bg-emerald-100 border border-emerald-200';
  if (count <= thresholds.midMax) return 'bg-emerald-200 border border-emerald-300';
  return 'bg-emerald-500 border border-emerald-500';
};

const formatDateLabel = (dateKey: string) => {
  const date = parseDateKey(dateKey);
  return date.toLocaleDateString('pt-BR', {
    weekday: 'short',
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  });
};

const formatWeekLabel = (fromKey: string, toKey: string) => {
  const from = parseDateKey(fromKey);
  const to = parseDateKey(toKey);
  const fromLabel = from.toLocaleDateString('pt-BR', { day: '2-digit', month: 'short' });
  const toLabel = to.toLocaleDateString('pt-BR', { day: '2-digit', month: 'short' });
  return `${fromLabel} - ${toLabel}`;
};

export default function StudyHeatmap({
  activityData,
  days = 30,
  label = 'Consist\u00eancia (\u00daltimos 30 dias)',
  ctaHref,
}: StudyHeatmapProps) {
  const [rangeDays, setRangeDays] = useState(days);
  const [normalizeByAverage, setNormalizeByAverage] = useState(false);

  useEffect(() => {
    setRangeDays(days);
  }, [days]);

  const range = useMemo(
    () => buildActivityRange(activityData, rangeDays),
    [activityData, rangeDays]
  );
  const summary = useMemo(() => getRangeSummary(range), [range]);
  const studySummary = useMemo(() => getStudySummary(activityData), [activityData]);
  const weeklyTotals = useMemo(() => getWeeklyTotals(range), [range]);
  const last7Range = useMemo(() => buildActivityRange(activityData, 7), [activityData]);

  const weeklyActiveDays = useMemo(
    () => last7Range.filter((day) => day.count > 0).length,
    [last7Range]
  );
  const goalRemaining = Math.max(WEEKLY_GOAL - weeklyActiveDays, 0);
  const goalProgress = WEEKLY_GOAL ? Math.min(weeklyActiveDays / WEEKLY_GOAL, 1) : 0;
  const isEmpty = summary.totalCards === 0;

  const thresholds = useMemo(
    () =>
      getThresholds(
        normalizeByAverage,
        summary.averagePerActiveDay || summary.averagePerDay
      ),
    [normalizeByAverage, summary.averagePerActiveDay, summary.averagePerDay]
  );

  const todayKey = useMemo(() => getDateKey(startOfUtcDay(new Date())), []);
  const lastStudyKey = summary.lastActiveKey;
  const maxWeeklyTotal = Math.max(1, ...weeklyTotals.map((week) => week.total));

  const labelText = (() => {
    if (label.match(/\d+/)) {
      return label.replace(/\d+/, String(rangeDays));
    }
    return `${label} (\u00daltimos ${rangeDays} dias)`;
  })();

  const averagePerDayLabel = summary.averagePerDay.toFixed(1);
  const averagePerActiveLabel = summary.averagePerActiveDay.toFixed(1);
  const legendLow = `1-${thresholds.lowMax}`;
  const legendMid = `${thresholds.lowMax + 1}-${thresholds.midMax}`;
  const legendHigh = `${thresholds.midMax + 1}+`;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-3">
        <span className="text-xs font-medium text-foreground/50 uppercase tracking-wider">
          {labelText}
        </span>
        <div className="flex flex-wrap items-center gap-2">
          <div className="flex items-center gap-1 rounded-sm border border-border bg-white p-1">
            {RANGE_OPTIONS.map((option) => (
              <button
                key={option}
                type="button"
                onClick={() => setRangeDays(option)}
                className={`px-2.5 py-1 text-[11px] font-bold uppercase tracking-wider rounded-sm transition-all ${
                  rangeDays === option
                    ? 'bg-brand text-white shadow-sm'
                    : 'text-foreground/50 hover:text-foreground hover:bg-gray-50'
                }`}
              >
                {option}d
              </button>
            ))}
          </div>
          <button
            type="button"
            onClick={() => setNormalizeByAverage((prev) => !prev)}
            aria-pressed={normalizeByAverage}
            title="Normalizar pela m\u00e9dia de cards por dia ativo"
            className={`px-3 py-1 text-[11px] font-bold uppercase tracking-wider rounded-sm border transition-all ${
              normalizeByAverage
                ? 'border-brand bg-brand/10 text-brand'
                : 'border-border text-foreground/50 hover:text-foreground hover:bg-gray-50'
            }`}
          >
            Normalizar
          </button>
          {normalizeByAverage && summary.averagePerActiveDay > 0 && (
            <span className="text-[10px] font-semibold uppercase tracking-wider text-foreground/40">
              Base: {averagePerActiveLabel} cards/dia ativo
            </span>
          )}
        </div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-5 gap-3">
        <div className="bg-gray-50 border border-border rounded-sm p-3">
          <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
            Dias ativos
          </div>
          <div className="text-lg font-bold text-foreground">
            {summary.activeDays}
            <span className="text-xs text-foreground/40">/{rangeDays}</span>
          </div>
        </div>
        <div className="bg-gray-50 border border-border rounded-sm p-3">
          <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
            Streak atual
          </div>
          <div className="text-lg font-bold text-foreground">{studySummary.streak} dias</div>
        </div>
        <div className="bg-gray-50 border border-border rounded-sm p-3">
          <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
            Melhor streak
          </div>
          <div className="text-lg font-bold text-foreground">{summary.bestStreak} dias</div>
        </div>
        <div className="bg-gray-50 border border-border rounded-sm p-3">
          <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
            Total de cards
          </div>
          <div className="text-lg font-bold text-foreground">{summary.totalCards}</div>
        </div>
        <div className="bg-gray-50 border border-border rounded-sm p-3">
          <div className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
            {'M\u00e9dia/dia'}
          </div>
          <div className="text-lg font-bold text-foreground">{averagePerDayLabel}</div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-[minmax(0,1fr)_240px] gap-4">
        <div className="space-y-3">
          <div className="flex flex-wrap items-end gap-4">
            <div className="grid grid-rows-7 grid-flow-col gap-1 overflow-visible">
              {range.map((day) => {
                const isToday = day.date === todayKey;
                const isLastStudy = day.date === lastStudyKey;
                const highlightClass = isToday
                  ? 'ring-2 ring-brand/80'
                  : isLastStudy
                  ? 'ring-2 ring-amber-400/80'
                  : 'ring-1 ring-transparent';
                const cardLabel = day.count === 1 ? 'card' : 'cards';

                return (
                  <div key={day.date} className="group relative">
                    <button
                      type="button"
                      title={`${day.count} ${cardLabel} em ${day.date}`}
                      aria-label={`${day.count} ${cardLabel} em ${day.date}`}
                      className={`h-3 w-3 rounded-[3px] transition-colors duration-300 ${getLevelClass(
                        day.count,
                        thresholds
                      )} ${highlightClass} focus:outline-none focus-visible:ring-2 focus-visible:ring-brand/70`}
                    />
                    <div className="pointer-events-none absolute left-1/2 top-0 z-10 w-44 -translate-x-1/2 -translate-y-full rounded-sm border border-border bg-white px-3 py-2 text-left shadow-lg opacity-0 transition-opacity duration-150 group-hover:opacity-100 group-focus-within:opacity-100">
                      <div className="text-xs font-semibold text-foreground">
                        {formatDateLabel(day.date)}
                      </div>
                      <div className="text-[11px] text-foreground/60">
                        {day.count} {cardLabel}
                      </div>
                      {day.decks?.length ? (
                        <div className="text-[11px] text-foreground/60">
                          Baralhos: {day.decks.join(', ')}
                        </div>
                      ) : null}
                      {isToday ? (
                        <div className="text-[10px] font-bold uppercase tracking-wider text-brand">
                          Hoje
                        </div>
                      ) : isLastStudy ? (
                        <div className="text-[10px] font-bold uppercase tracking-wider text-amber-600">
                          {'\u00daltimo estudo'}
                        </div>
                      ) : null}
                    </div>
                  </div>
                );
              })}
            </div>
            <div className="flex flex-col gap-2 text-[10px] font-semibold uppercase tracking-wider text-foreground/40">
              <div className="flex flex-wrap items-center gap-3">
                <span>menos</span>
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] bg-gray-100 border border-gray-200" />
                  <span>0</span>
                </div>
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-100 border border-emerald-200" />
                  <span>{legendLow}</span>
                </div>
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-200 border border-emerald-300" />
                  <span>{legendMid}</span>
                </div>
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] bg-emerald-500 border border-emerald-500" />
                  <span>{legendHigh}</span>
                </div>
                <span>mais</span>
              </div>
              <div className="flex flex-wrap items-center gap-3">
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] ring-2 ring-brand/80" />
                  <span>Hoje</span>
                </div>
                <div className="flex items-center gap-1">
                  <span className="h-2.5 w-2.5 rounded-[3px] ring-2 ring-amber-400/80" />
                  <span>{'\u00daltimo estudo'}</span>
                </div>
              </div>
            </div>
          </div>

          {isEmpty && (
            <div className="border border-dashed border-border rounded-sm p-4 bg-white/70">
              <div className="text-sm font-bold text-foreground">
                {'Estude 10 cards hoje para iniciar sua consist\u00eancia.'}
              </div>
              <div className="text-xs text-foreground/50 mt-1">
                {'A consist\u00eancia di\u00e1ria melhora a reten\u00e7\u00e3o e reduz revis\u00f5es.'}
              </div>
              {ctaHref && (
                <a
                  href={ctaHref}
                  className="inline-flex mt-3 text-xs font-bold text-brand hover:underline"
                >
                  {'Come\u00e7ar a estudar'}
                </a>
              )}
            </div>
          )}
        </div>

        <div className="space-y-3">
          <div className="bg-gray-50 border border-border rounded-sm p-3">
            <div className="flex items-center justify-between">
              <span className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                {'Meta de consist\u00eancia'}
              </span>
              <span className="text-[10px] font-bold uppercase tracking-wider text-foreground/60">
                {WEEKLY_GOAL}x/semana
              </span>
            </div>
            <div className="mt-2 h-2 rounded-sm bg-gray-200 overflow-hidden">
              <div
                className="h-full bg-brand transition-all"
                style={{ width: `${goalProgress * 100}%` }}
              />
            </div>
            <div className="mt-2 text-[11px] text-foreground/60">
              {weeklyActiveDays >= WEEKLY_GOAL
                ? 'Meta batida nesta semana.'
                : `Faltam ${goalRemaining} dia${goalRemaining === 1 ? '' : 's'} para bater a meta.`}
            </div>
          </div>

          <div className="bg-gray-50 border border-border rounded-sm p-3">
            <div className="flex items-center justify-between">
              <span className="text-[10px] font-bold uppercase tracking-wider text-foreground/40">
                {'Tend\u00eancia semanal'}
              </span>
              <span className="text-[10px] font-bold uppercase tracking-wider text-foreground/60">
                {weeklyTotals.length} semanas
              </span>
            </div>
            <div className="mt-3 flex items-end gap-1.5 h-16">
              {weeklyTotals.map((week) => {
                const height = Math.max(6, (week.total / maxWeeklyTotal) * 60);
                return (
                  <div
                    key={week.from}
                    title={`${week.total} cards (${formatWeekLabel(week.from, week.to)})`}
                    className="flex-1 rounded-sm bg-emerald-200/80"
                    style={{ height }}
                  />
                );
              })}
            </div>
            <div className="mt-2 text-[10px] text-foreground/40">
              Cada barra representa o total de cards por semana.
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
