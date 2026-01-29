export const ANIMATION = {
    buttonTap: { scale: 0.95 },
    cardSwipe: { threshold: 60, velocity: 200 },
    sheet: { initial: { y: '100%' }, animate: { y: 0 } },
    duration: { fast: 150, normal: 300 }
};

export const getMotionProps = (reduceMotion: boolean) =>
    reduceMotion ? { transition: { duration: 0 } } : {};
