
/**
 * Sanitizes user input to prevent AI prompt injection.
 * Removes common patterns used to override system instructions.
 */
export function sanitizeInput(text: string): string {
    if (!text) return '';

    // Remove potential prompt injection patterns
    const dangerousPatterns = [
        /ignore\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /disregard\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /forget\s+(all\s+)?(previous|above|prior)\s+instructions?/gi,
        /new\s+instructions?:/gi,
        /system\s*prompt/gi,
        /you\s+are\s+now/gi,
        /act\s+as\s+if/gi,
        /pretend\s+(you\s+are|to\s+be)/gi,
        // Portuguese / Spanish patterns
        /ignorar?\s+(todas\s+as\s+)?instruções?\s+(anteriores|acima)/gi,
        /esqueça?\s+(todas\s+as\s+)?instruções?\s+(anteriores|acima)/gi,
        /novas?\s+instruções?:/gi,
        /você\s+(agora\s+)?é/gi,
        /aja\s+como\s+se/gi,
        /finja\s+ser/gi,
        /olvida\s+todo/gi,
    ];

    let sanitized = text;
    for (const pattern of dangerousPatterns) {
        sanitized = sanitized.replace(pattern, '[REMOVED]');
    }

    // Limit consecutive special characters to prevent token exhaustion attacks or formatting issues
    sanitized = sanitized.replace(/[{}[\]<>]{3,}/g, '');

    return sanitized.trim();
}

/**
 * Wait for a specified number of milliseconds.
 */
export function sleep(ms: number): Promise<void> {
    return new Promise((resolve) => setTimeout(resolve, ms));
}
