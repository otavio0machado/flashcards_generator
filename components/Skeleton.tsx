import React from 'react';

interface SkeletonProps {
    className?: string;
    width?: string;
    height?: string;
}

export function Skeleton({ className = '', width, height }: SkeletonProps) {
    return (
        <div
            className={`animate-pulse bg-gray-200 rounded-sm ${className}`}
            style={{ width, height }}
        />
    );
}

export function DeckCardSkeleton() {
    return (
        <div className="bg-white border border-border p-6 rounded-sm shadow-sm">
            <div className="flex items-start justify-between mb-8">
                <div className="animate-pulse bg-gray-200 rounded-sm w-9 h-9" />
                <div className="animate-pulse bg-gray-200 rounded-sm w-6 h-6" />
            </div>

            <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-3/4 mb-2" />
            <div className="animate-pulse bg-gray-200 rounded-sm h-3 w-1/2 mb-8" />

            <div className="flex flex-col sm:flex-row gap-2">
                <div className="animate-pulse bg-gray-200 rounded-sm h-9 flex-1" />
                <div className="animate-pulse bg-gray-200 rounded-sm h-9 flex-1" />
            </div>
        </div>
    );
}

export function MarketplaceCardSkeleton() {
    return (
        <div className="bg-white border border-border p-6 rounded-sm shadow-sm">
            <div className="flex items-start justify-between mb-6">
                <div className="animate-pulse bg-gray-200 rounded-sm w-9 h-9" />
                <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-20" />
            </div>

            <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-3/4 mb-2" />
            <div className="animate-pulse bg-gray-200 rounded-sm h-3 w-full mb-1" />
            <div className="animate-pulse bg-gray-200 rounded-sm h-3 w-2/3 mb-4" />

            <div className="flex flex-wrap gap-2 mb-6">
                <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-16" />
                <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-14" />
                <div className="animate-pulse bg-gray-200 rounded-sm h-5 w-20" />
            </div>

            <div className="flex flex-col sm:flex-row gap-2">
                <div className="animate-pulse bg-gray-200 rounded-sm h-9 flex-1" />
                <div className="animate-pulse bg-gray-200 rounded-sm h-9 flex-1" />
            </div>
        </div>
    );
}
