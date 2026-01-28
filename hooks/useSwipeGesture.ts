'use client';

import { useRef, useCallback, useState } from 'react';
import { PanInfo } from 'framer-motion';

export type SwipeDirection = 'left' | 'right' | 'up' | 'down' | 'none';

export interface SwipeConfig {
    onSwipeLeft?: () => void;
    onSwipeRight?: () => void;
    onSwipeUp?: () => void;
    onSwipeDown?: () => void;
    threshold?: number;          // Minimum distance in pixels (default: 50)
    velocityThreshold?: number;  // Minimum velocity (default: 300)
    enabled?: boolean;
}

export interface SwipeState {
    direction: SwipeDirection;
    offset: { x: number; y: number };
    velocity: { x: number; y: number };
    isDragging: boolean;
}

export interface SwipeHandlers {
    onDragStart: () => void;
    onDrag: (event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => void;
    onDragEnd: (event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => void;
    state: SwipeState;
    reset: () => void;
}

const DEFAULT_THRESHOLD = 50;
const DEFAULT_VELOCITY_THRESHOLD = 300;

export function useSwipeGesture(config: SwipeConfig): SwipeHandlers {
    const {
        onSwipeLeft,
        onSwipeRight,
        onSwipeUp,
        onSwipeDown,
        threshold = DEFAULT_THRESHOLD,
        velocityThreshold = DEFAULT_VELOCITY_THRESHOLD,
        enabled = true,
    } = config;

    const [state, setState] = useState<SwipeState>({
        direction: 'none',
        offset: { x: 0, y: 0 },
        velocity: { x: 0, y: 0 },
        isDragging: false,
    });

    const primaryDirectionRef = useRef<'horizontal' | 'vertical' | null>(null);

    const determineDirection = useCallback((offsetX: number, offsetY: number): SwipeDirection => {
        const absX = Math.abs(offsetX);
        const absY = Math.abs(offsetY);

        // Determine primary axis based on larger movement
        if (absX > absY) {
            return offsetX > 0 ? 'right' : 'left';
        } else if (absY > absX) {
            return offsetY > 0 ? 'down' : 'up';
        }
        return 'none';
    }, []);

    const onDragStart = useCallback(() => {
        if (!enabled) return;

        primaryDirectionRef.current = null;
        setState(prev => ({
            ...prev,
            isDragging: true,
            direction: 'none',
        }));
    }, [enabled]);

    const onDrag = useCallback((event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        if (!enabled) return;

        const { offset, velocity } = info;

        // Lock to primary direction after initial movement
        if (primaryDirectionRef.current === null && (Math.abs(offset.x) > 10 || Math.abs(offset.y) > 10)) {
            primaryDirectionRef.current = Math.abs(offset.x) > Math.abs(offset.y) ? 'horizontal' : 'vertical';
        }

        const direction = determineDirection(offset.x, offset.y);

        setState({
            direction,
            offset: { x: offset.x, y: offset.y },
            velocity: { x: velocity.x, y: velocity.y },
            isDragging: true,
        });
    }, [enabled, determineDirection]);

    const onDragEnd = useCallback((event: MouseEvent | TouchEvent | PointerEvent, info: PanInfo) => {
        if (!enabled) {
            setState(prev => ({ ...prev, isDragging: false }));
            return;
        }

        const { offset, velocity } = info;
        const absX = Math.abs(offset.x);
        const absY = Math.abs(offset.y);
        const absVelX = Math.abs(velocity.x);
        const absVelY = Math.abs(velocity.y);

        // Check if swipe meets threshold (distance OR velocity)
        const meetsHorizontalThreshold = absX >= threshold || absVelX >= velocityThreshold;
        const meetsVerticalThreshold = absY >= threshold || absVelY >= velocityThreshold;

        // Determine which direction was primary
        const isHorizontal = primaryDirectionRef.current === 'horizontal';
        const isVertical = primaryDirectionRef.current === 'vertical';

        if (isHorizontal && meetsHorizontalThreshold) {
            if (offset.x > 0 && onSwipeRight) {
                onSwipeRight();
            } else if (offset.x < 0 && onSwipeLeft) {
                onSwipeLeft();
            }
        } else if (isVertical && meetsVerticalThreshold) {
            if (offset.y < 0 && onSwipeUp) {
                onSwipeUp();
            } else if (offset.y > 0 && onSwipeDown) {
                onSwipeDown();
            }
        }

        // Reset state
        primaryDirectionRef.current = null;
        setState({
            direction: 'none',
            offset: { x: 0, y: 0 },
            velocity: { x: 0, y: 0 },
            isDragging: false,
        });
    }, [enabled, threshold, velocityThreshold, onSwipeLeft, onSwipeRight, onSwipeUp, onSwipeDown]);

    const reset = useCallback(() => {
        primaryDirectionRef.current = null;
        setState({
            direction: 'none',
            offset: { x: 0, y: 0 },
            velocity: { x: 0, y: 0 },
            isDragging: false,
        });
    }, []);

    return {
        onDragStart,
        onDrag,
        onDragEnd,
        state,
        reset,
    };
}
