// Script to generate PWA screenshots
// Run with: node scripts/generate-screenshots.js

const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const screenshotsDir = path.join(__dirname, '../public/screenshots');

// Ensure directory exists
if (!fs.existsSync(screenshotsDir)) {
    fs.mkdirSync(screenshotsDir, { recursive: true });
}

// Create SVG templates for screenshots
const createScreenshotSVG = (width, height, isDesktop) => {
    const brandColor = '#CC3F00';
    const bgColor = '#18181B';
    
    return `
    <svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">
        <defs>
            <linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color:${brandColor};stop-opacity:0.1" />
                <stop offset="100%" style="stop-color:${brandColor};stop-opacity:0.3" />
            </linearGradient>
        </defs>
        
        <!-- Background -->
        <rect width="100%" height="100%" fill="${bgColor}"/>
        <rect width="100%" height="100%" fill="url(#grad1)"/>
        
        <!-- Header -->
        <rect x="0" y="0" width="100%" height="${isDesktop ? 64 : 56}" fill="#27272A"/>
        
        <!-- Logo placeholder -->
        <circle cx="${isDesktop ? 40 : 28}" cy="${isDesktop ? 32 : 28}" r="${isDesktop ? 16 : 12}" fill="${brandColor}"/>
        <text x="${isDesktop ? 70 : 50}" y="${isDesktop ? 38 : 33}" 
              font-family="system-ui, -apple-system, sans-serif" 
              font-size="${isDesktop ? 18 : 14}" 
              font-weight="600" 
              fill="white">Flashcards Generator</text>
        
        <!-- Main content area -->
        <rect x="${isDesktop ? 40 : 16}" y="${isDesktop ? 100 : 80}" 
              width="${isDesktop ? width - 80 : width - 32}" 
              height="${isDesktop ? 200 : 150}" 
              rx="12" fill="#27272A"/>
        
        <!-- Title text -->
        <text x="${width / 2}" y="${isDesktop ? 150 : 130}" 
              text-anchor="middle"
              font-family="system-ui, -apple-system, sans-serif" 
              font-size="${isDesktop ? 28 : 20}" 
              font-weight="700" 
              fill="white">Crie Flashcards com IA</text>
        
        <text x="${width / 2}" y="${isDesktop ? 190 : 160}" 
              text-anchor="middle"
              font-family="system-ui, -apple-system, sans-serif" 
              font-size="${isDesktop ? 16 : 12}" 
              fill="#A1A1AA">Transforme qualquer texto em cards de estudo</text>
        
        <!-- CTA Button -->
        <rect x="${width / 2 - (isDesktop ? 100 : 80)}" y="${isDesktop ? 220 : 180}" 
              width="${isDesktop ? 200 : 160}" 
              height="${isDesktop ? 50 : 40}" 
              rx="8" fill="${brandColor}"/>
        <text x="${width / 2}" y="${isDesktop ? 252 : 205}" 
              text-anchor="middle"
              font-family="system-ui, -apple-system, sans-serif" 
              font-size="${isDesktop ? 16 : 14}" 
              font-weight="600" 
              fill="white">Começar Agora</text>
        
        <!-- Flashcard previews -->
        ${isDesktop ? `
        <rect x="40" y="340" width="300" height="180" rx="12" fill="#3F3F46"/>
        <rect x="${width / 2 - 150}" y="340" width="300" height="180" rx="12" fill="#3F3F46"/>
        <rect x="${width - 340}" y="340" width="300" height="180" rx="12" fill="#3F3F46"/>
        ` : `
        <rect x="16" y="260" width="${width - 32}" height="120" rx="8" fill="#3F3F46"/>
        <rect x="16" y="400" width="${width - 32}" height="120" rx="8" fill="#3F3F46"/>
        `}
        
        <!-- Feature icons and text -->
        <circle cx="${isDesktop ? 190 : width / 2 - 80}" cy="${isDesktop ? 380 : 300}" r="24" fill="${brandColor}" opacity="0.2"/>
        <circle cx="${isDesktop ? width / 2 : width / 2}" cy="${isDesktop ? 380 : 300}" r="24" fill="${brandColor}" opacity="0.2"/>
        <circle cx="${isDesktop ? width - 190 : width / 2 + 80}" cy="${isDesktop ? 380 : 300}" r="24" fill="${brandColor}" opacity="0.2"/>
    </svg>
    `;
};

async function generateScreenshots() {
    console.log('📸 Generating PWA screenshots...\n');

    try {
        // Desktop screenshot (wide)
        const desktopSVG = createScreenshotSVG(1280, 720, true);
        await sharp(Buffer.from(desktopSVG))
            .png()
            .toFile(path.join(screenshotsDir, 'screenshot-desktop.png'));
        console.log('✅ screenshot-desktop.png (1280x720)');

        // Mobile screenshot (narrow)
        const mobileSVG = createScreenshotSVG(750, 1334, false);
        await sharp(Buffer.from(mobileSVG))
            .png()
            .toFile(path.join(screenshotsDir, 'screenshot-mobile.png'));
        console.log('✅ screenshot-mobile.png (750x1334)');

        console.log('\n🎉 Screenshots generated successfully!');
        console.log('📁 Location: public/screenshots/\n');
    } catch (error) {
        console.error('❌ Error generating screenshots:', error);
        process.exit(1);
    }
}

generateScreenshots();
