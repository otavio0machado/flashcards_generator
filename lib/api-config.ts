export const API_BASE_URL = process.env.NEXT_PUBLIC_IS_DESKTOP === 'true'
    ? 'https://flashcardsgenerator.com.br'
    : '';

export const getApiUrl = (path: string) => {
    const cleanPath = path.startsWith('/') ? path : `/${path}`;
    return `${API_BASE_URL}${cleanPath}`;
};
