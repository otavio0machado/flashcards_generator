// Script to generate Android app icons from logo
const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

// Source icon
const iconSourcePath = path.join(__dirname, '../public/icon-source.png');
const startLogoPath = path.join(__dirname, '../public/logo.png');
const sourceIcon = fs.existsSync(iconSourcePath) ? iconSourcePath : startLogoPath;

// Android resource directory (created by `tauri android init`)
const androidResDir = path.join(__dirname, '../src-tauri/gen/android/app/src/main/res');

// Android mipmap sizes
const mipmapSizes = [
    { folder: 'mipmap-mdpi', size: 48 },
    { folder: 'mipmap-hdpi', size: 72 },
    { folder: 'mipmap-xhdpi', size: 96 },
    { folder: 'mipmap-xxhdpi', size: 144 },
    { folder: 'mipmap-xxxhdpi', size: 192 },
];

// Adaptive icon foreground sizes (with padding for safe zone)
const adaptiveSizes = [
    { folder: 'mipmap-mdpi', size: 108 },
    { folder: 'mipmap-hdpi', size: 162 },
    { folder: 'mipmap-xhdpi', size: 216 },
    { folder: 'mipmap-xxhdpi', size: 324 },
    { folder: 'mipmap-xxxhdpi', size: 432 },
];

async function generateAndroidIcons() {
    console.log('Generating Android icons...\n');

    if (!fs.existsSync(androidResDir)) {
        console.log(`Android res directory not found at: ${androidResDir}`);
        console.log('Run "npx tauri android init" first to create the Android project.\n');
        console.log('Creating icons in a staging directory instead...');
    }

    const outputDir = fs.existsSync(androidResDir)
        ? androidResDir
        : path.join(__dirname, '../src-tauri/android-icons-staging');

    let sourceBuffer;

    if (!fs.existsSync(sourceIcon)) {
        console.log('Source logo not found, creating placeholder...');
        const svg = `
        <svg width="512" height="512" xmlns="http://www.w3.org/2000/svg">
            <rect width="100%" height="100%" fill="#CC3F00"/>
            <text x="50%" y="50%" text-anchor="middle" dy=".35em"
                  font-family="system-ui" font-size="200" font-weight="bold" fill="white">F</text>
        </svg>`;
        sourceBuffer = Buffer.from(svg);
    } else {
        sourceBuffer = fs.readFileSync(sourceIcon);
    }

    // Generate standard launcher icons
    for (const { folder, size } of mipmapSizes) {
        const dir = path.join(outputDir, folder);
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }

        await sharp(sourceBuffer)
            .resize(size, size)
            .png()
            .toFile(path.join(dir, 'ic_launcher.png'));

        // Round icon variant
        await sharp(sourceBuffer)
            .resize(size, size)
            .png()
            .toFile(path.join(dir, 'ic_launcher_round.png'));

        console.log(`  ${folder}/ic_launcher.png (${size}x${size})`);
    }

    // Generate adaptive icon foreground (icon with padding for safe zone)
    for (const { folder, size } of adaptiveSizes) {
        const dir = path.join(outputDir, folder);
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }

        // The foreground icon has padding (66.67% of the full size is the icon)
        const iconSize = Math.round(size * 0.667);
        const padding = Math.round((size - iconSize) / 2);

        const foreground = await sharp(sourceBuffer)
            .resize(iconSize, iconSize)
            .png()
            .toBuffer();

        await sharp({
            create: {
                width: size,
                height: size,
                channels: 4,
                background: { r: 0, g: 0, b: 0, alpha: 0 },
            },
        })
            .composite([{ input: foreground, left: padding, top: padding }])
            .png()
            .toFile(path.join(dir, 'ic_launcher_foreground.png'));

        console.log(`  ${folder}/ic_launcher_foreground.png (${size}x${size})`);
    }

    // Generate Play Store icon (512x512)
    const playStoreDir = path.join(outputDir, '..', 'play-store');
    if (!fs.existsSync(playStoreDir)) {
        fs.mkdirSync(playStoreDir, { recursive: true });
    }

    await sharp(sourceBuffer)
        .resize(512, 512)
        .png()
        .toFile(path.join(playStoreDir, 'icon-512.png'));
    console.log(`  play-store/icon-512.png (512x512)`);

    // Generate feature graphic (1024x500)
    const featureGraphicSvg = `
    <svg width="1024" height="500" xmlns="http://www.w3.org/2000/svg">
        <defs>
            <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
                <stop offset="0%" style="stop-color:#CC3F00"/>
                <stop offset="100%" style="stop-color:#F97316"/>
            </linearGradient>
        </defs>
        <rect width="100%" height="100%" fill="url(#bg)"/>
        <text x="512" y="200" text-anchor="middle" font-family="system-ui" font-size="64" font-weight="bold" fill="white">
            Flashcards Generator
        </text>
        <text x="512" y="280" text-anchor="middle" font-family="system-ui" font-size="28" fill="rgba(255,255,255,0.9)">
            Gere flashcards com IA para Anki e Quizlet
        </text>
        <text x="512" y="340" text-anchor="middle" font-family="system-ui" font-size="22" fill="rgba(255,255,255,0.7)">
            Cole seu texto e pare de perder horas resumindo
        </text>
    </svg>`;

    await sharp(Buffer.from(featureGraphicSvg))
        .resize(1024, 500)
        .png()
        .toFile(path.join(playStoreDir, 'feature-graphic.png'));
    console.log(`  play-store/feature-graphic.png (1024x500)`);

    // Create adaptive icon XML files (ic_launcher.xml)
    const adaptiveIconXml = `<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background"/>
    <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>`;

    const anydpiDir = path.join(outputDir, 'mipmap-anydpi-v26');
    if (!fs.existsSync(anydpiDir)) {
        fs.mkdirSync(anydpiDir, { recursive: true });
    }
    fs.writeFileSync(path.join(anydpiDir, 'ic_launcher.xml'), adaptiveIconXml);
    fs.writeFileSync(path.join(anydpiDir, 'ic_launcher_round.xml'), adaptiveIconXml);
    console.log(`  mipmap-anydpi-v26/ic_launcher.xml`);

    // Create background color resource
    const valuesDir = path.join(outputDir, 'values');
    if (!fs.existsSync(valuesDir)) {
        fs.mkdirSync(valuesDir, { recursive: true });
    }

    const colorsXml = `<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#CC3F00</color>
</resources>`;
    fs.writeFileSync(path.join(valuesDir, 'ic_launcher_background.xml'), colorsXml);
    console.log(`  values/ic_launcher_background.xml`);

    console.log('\nAndroid icons generated!');
    console.log(`Location: ${outputDir}\n`);
}

generateAndroidIcons().catch(console.error);
