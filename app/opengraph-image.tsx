import { ImageResponse } from 'next/og';

export const size = {
    width: 1200,
    height: 630,
};

export const contentType = 'image/png';

export default function OpenGraphImage() {
    return new ImageResponse(
        (
            <div
                style={{
                    width: '1200px',
                    height: '630px',
                    display: 'flex',
                    flexDirection: 'column',
                    justifyContent: 'center',
                    alignItems: 'center',
                    background: '#FF4F00',
                    color: '#FFFFFF',
                    padding: '64px',
                    textAlign: 'center',
                    fontSize: 64,
                    fontWeight: 700,
                    letterSpacing: '-0.02em',
                }}
            >
                Flashcards Generator
                <span
                    style={{
                        display: 'block',
                        marginTop: 16,
                        fontSize: 28,
                        fontWeight: 500,
                        opacity: 0.9,
                    }}
                >
                    Estude melhor com IA
                </span>
            </div>
        ),
        {
            ...size,
        }
    );
}
