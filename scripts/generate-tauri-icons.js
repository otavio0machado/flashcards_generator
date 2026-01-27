// Script to generate Tauri app icons from logo
const sharp = require('sharp');
const path = require('path');
const fs = require('fs');

const iconsDir = path.join(__dirname, '../src-tauri/icons');
// Try to find the best source icon
const iconSourcePath = path.join(__dirname, '../public/icon-source.png');
const startLogoPath = path.join(__dirname, '../public/logo.png');
const sourceIcon = fs.existsSync(iconSourcePath) ? iconSourcePath : startLogoPath;

// Ensure directory exists
if (!fs.existsSync(iconsDir)) {
    fs.mkdirSync(iconsDir, { recursive: true });
}

const sizes = [
    { size: 32, name: '32x32.png' },
    { size: 128, name: '128x128.png' },
    { size: 256, name: '128x128@2x.png' },
    { size: 512, name: 'icon.png' },
];

// Create a valid ICO file manually
function createIco(pngBuffers) {
    // ICO header: 6 bytes
    // ICONDIR: idReserved (2), idType (2), idCount (2)
    const iconCount = pngBuffers.length;
    const headerSize = 6;
    const dirEntrySize = 16;
    const dirSize = dirEntrySize * iconCount;

    let offset = headerSize + dirSize;
    const dirEntries = [];

    for (const { buffer, size } of pngBuffers) {
        dirEntries.push({
            width: size >= 256 ? 0 : size,
            height: size >= 256 ? 0 : size,
            colorCount: 0,
            reserved: 0,
            planes: 1,
            bitCount: 32,
            bytesInRes: buffer.length,
            imageOffset: offset
        });
        offset += buffer.length;
    }

    const totalSize = offset;
    const ico = Buffer.alloc(totalSize);

    // Write header
    ico.writeUInt16LE(0, 0);  // Reserved
    ico.writeUInt16LE(1, 2);  // Type (1 = ICO)
    ico.writeUInt16LE(iconCount, 4);  // Image count

    // Write directory entries
    let pos = 6;
    for (const entry of dirEntries) {
        ico.writeUInt8(entry.width, pos);
        ico.writeUInt8(entry.height, pos + 1);
        ico.writeUInt8(entry.colorCount, pos + 2);
        ico.writeUInt8(entry.reserved, pos + 3);
        ico.writeUInt16LE(entry.planes, pos + 4);
        ico.writeUInt16LE(entry.bitCount, pos + 6);
        ico.writeUInt32LE(entry.bytesInRes, pos + 8);
        ico.writeUInt32LE(entry.imageOffset, pos + 12);
        pos += 16;
    }

    // Write image data
    for (const { buffer } of pngBuffers) {
        buffer.copy(ico, pos);
        pos += buffer.length;
    }

    return ico;
}

async function generateIcons() {
    console.log('🎨 Generating Tauri icons...\n');

    let sourceBuffer;

    // Check if source exists
    if (!fs.existsSync(sourceIcon)) {
        console.log('⚠️  Source logo.png not found, creating placeholder icons...');

        // Create a simple SVG as placeholder
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

    // Generate PNGs
    for (const { size, name } of sizes) {
        await sharp(sourceBuffer)
            .resize(size, size)
            .png()
            .toFile(path.join(iconsDir, name));
        console.log(`✅ ${name}`);
    }

    // Generate ICO with multiple sizes
    const icoSizes = [16, 32, 48, 256];
    const pngBuffers = [];

    for (const size of icoSizes) {
        const buffer = await sharp(sourceBuffer)
            .resize(size, size)
            .png()
            .toBuffer();
        pngBuffers.push({ buffer, size });
    }

    const icoBuffer = createIco(pngBuffers);
    fs.writeFileSync(path.join(iconsDir, 'icon.ico'), icoBuffer);
    console.log('✅ icon.ico');

    // For macOS, just use PNG (real .icns requires special tooling)
    await sharp(sourceBuffer)
        .resize(512, 512)
        .png()
        .toFile(path.join(iconsDir, 'icon.icns'));
    console.log('✅ icon.icns (PNG format)');

    console.log('\n🎉 Tauri icons generated!');
    console.log('📁 Location: src-tauri/icons/\n');
}

generateIcons().catch(console.error);
