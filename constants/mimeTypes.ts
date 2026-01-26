/**
 * Constantes de MIME Types
 *
 * Centraliza tipos de arquivo suportados para uploads.
 */

// ==================== IMAGENS ====================
export const IMAGE_MIME_TYPES = new Set([
    'image/jpeg',
    'image/jpg',
    'image/png',
    'image/webp',
    'image/heic',
    'image/heif',
]);

// ==================== DOCUMENTOS ====================
export const PDF_MIME_TYPE = 'application/pdf';
export const DOCX_MIME_TYPE = 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';

export const DOCUMENT_MIME_TYPES = new Set([
    PDF_MIME_TYPE,
    DOCX_MIME_TYPE,
]);

// ==================== TODOS OS TIPOS SUPORTADOS ====================
export const ALL_SUPPORTED_MIME_TYPES = new Set([
    ...IMAGE_MIME_TYPES,
    ...DOCUMENT_MIME_TYPES,
]);

// ==================== HELPERS ====================
export function isImageMimeType(mimeType: string): boolean {
    return IMAGE_MIME_TYPES.has(mimeType.toLowerCase());
}

export function isPdfMimeType(mimeType: string): boolean {
    return mimeType.toLowerCase() === PDF_MIME_TYPE;
}

export function isDocxMimeType(mimeType: string): boolean {
    return mimeType.toLowerCase() === DOCX_MIME_TYPE;
}

export function isSupportedMimeType(mimeType: string): boolean {
    return ALL_SUPPORTED_MIME_TYPES.has(mimeType.toLowerCase());
}

// ==================== ACCEPT STRINGS PARA INPUT ====================
export const FILE_ACCEPT = {
    ALL: 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document,image/jpeg,image/jpg,image/png,image/webp,image/heic,image/heif',
    DOCUMENTS_ONLY: 'application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    IMAGES_ONLY: 'image/jpeg,image/jpg,image/png,image/webp,image/heic,image/heif',
} as const;
