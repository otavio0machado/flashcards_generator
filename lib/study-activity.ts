export type StudyActivityRecord = {
  day: string;
  count: number;
};

const MS_PER_DAY = 24 * 60 * 60 * 1000;

export const startOfUtcDay = (date: Date): Date => {
  return new Date(Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate()));
};

export const addUtcDays = (date: Date, days: number): Date => {
  const next = new Date(date);
  next.setUTCDate(next.getUTCDate() + days);
  return next;
};

export const getDateKey = (date: Date): string => {
  return date.toISOString().slice(0, 10);
};

export const parseDateKey = (dateKey: string): Date => {
  const [year, month, day] = dateKey.split('-').map(Number);
  return new Date(Date.UTC(year, month - 1, day));
};

export const buildActivityRange = (
  activity: StudyActivityRecord[],
  days: number,
  endDate: Date = new Date()
) => {
  if (days <= 0) return [];

  const activityMap = new Map<string, number>();
  for (const item of activity) {
    if (!item?.day) continue;
    activityMap.set(item.day, item.count ?? 0);
  }

  const normalizedEnd = startOfUtcDay(endDate);
  const range: { date: string; count: number }[] = [];

  for (let offset = days - 1; offset >= 0; offset -= 1) {
    const date = addUtcDays(normalizedEnd, -offset);
    const key = getDateKey(date);
    range.push({ date: key, count: activityMap.get(key) ?? 0 });
  }

  return range;
};

export const getStudySummary = (
  activity: StudyActivityRecord[],
  today: Date = new Date()
) => {
  const activityMap = new Map<string, number>();
  for (const item of activity) {
    if (!item?.day) continue;
    activityMap.set(item.day, item.count ?? 0);
  }

  const normalizedToday = startOfUtcDay(today);
  const todayKey = getDateKey(normalizedToday);
  const hasStudiedToday = (activityMap.get(todayKey) ?? 0) > 0;

  let cursor = hasStudiedToday ? normalizedToday : addUtcDays(normalizedToday, -1);
  let streak = 0;
  while ((activityMap.get(getDateKey(cursor)) ?? 0) > 0) {
    streak += 1;
    cursor = addUtcDays(cursor, -1);
  }

  let lastActiveKey: string | null = null;
  for (const [dayKey, count] of activityMap.entries()) {
    if (count <= 0) continue;
    if (!lastActiveKey || dayKey > lastActiveKey) {
      lastActiveKey = dayKey;
    }
  }

  let daysSinceLastStudy: number | null = null;
  if (lastActiveKey) {
    const lastActiveDate = parseDateKey(lastActiveKey);
    daysSinceLastStudy = Math.round(
      (normalizedToday.getTime() - lastActiveDate.getTime()) / MS_PER_DAY
    );
  }

  const isFrozen = streak >= 7 && !hasStudiedToday && daysSinceLastStudy === 1;

  return {
    streak,
    hasStudiedToday,
    isFrozen,
    daysSinceLastStudy,
  };
};
