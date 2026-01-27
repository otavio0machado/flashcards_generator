/**
 * Script para gerar ícones em múltiplos tamanhos
 * 
 * Uso:
 * 1. Coloque o ícone fonte (512x512 ou maior) em: public/icon-source.png
 * 2. Execute: node scripts/generate-icons.mjs
 * 
 * Dependência: npm install sharp
 */

import sharp from 'sharp';
import { mkdir } from 'fs/promises';
import { existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, '..');

// Arquivo fonte do ícone (coloque seu ícone aqui)
const SOURCE_ICON = join(ROOT, 'public', 'icon-source.png');

// Configuração dos ícones a serem gerados
const icons = [
    // PWA Icons (public/icons/)
    { output: 'public/icons/icon-512x512.png', size: 512 },
    { output: 'public/icons/icon-384x384.png', size: 384 },
    { output: 'public/icons/icon-192x192.png', size: 192 },
    { output: 'public/icons/icon-152x152.png', size: 152 },
    { output: 'public/icons/icon-144x144.png', size: 144 },
    { output: 'public/icons/icon-128x128.png', size: 128 },
    { output: 'public/icons/icon-96x96.png', size: 96 },
    { output: 'public/icons/icon-72x72.png', size: 72 },
    { output: 'public/icons/apple-touch-icon.png', size: 180 },
    { output: 'public/icons/favicon-32x32.png', size: 32 },
    { output: 'public/icons/favicon-16x16.png', size: 16 },
    
    // Tauri Icons (src-tauri/icons/)
    { output: 'src-tauri/icons/icon.png', size: 512 },
    { output: 'src-tauri/icons/32x32.png', size: 32 },
    { output: 'src-tauri/icons/128x128.png', size: 128 },
    { output: 'src-tauri/icons/128x128@2x.png', size: 256 },
];

async function generateIcons() {
    console.log('🎨 Gerando ícones...\n');

    if (!existsSync(SOURCE_ICON)) {
        console.error(`❌ Arquivo fonte não encontrado: ${SOURCE_ICON}`);
        console.log('\n📝 Instruções:');
        console.log('   1. Coloque seu ícone (512x512 PNG) em: public/icon-source.png');
        console.log('   2. Execute novamente: node scripts/generate-icons.mjs');
        process.exit(1);
    }

    const source = sharp(SOURCE_ICON);
    const metadata = await source.metadata();
    console.log(`📁 Fonte: ${SOURCE_ICON}`);
    console.log(`📐 Dimensões: ${metadata.width}x${metadata.height}\n`);

    let success = 0;
    let failed = 0;

    for (const icon of icons) {
        const outputPath = join(ROOT, icon.output);
        const outputDir = dirname(outputPath);

        try {
            // Criar diretório se não existir
            if (!existsSync(outputDir)) {
                await mkdir(outputDir, { recursive: true });
            }

            await sharp(SOURCE_ICON)
                .resize(icon.size, icon.size, {
                    fit: 'contain',
                    background: { r: 0, g: 0, b: 0, alpha: 0 }
                })
                .png()
                .toFile(outputPath);

            console.log(`✅ ${icon.output} (${icon.size}x${icon.size})`);
            success++;
        } catch (error) {
            console.error(`❌ ${icon.output}: ${error.message}`);
            failed++;
        }
    }

    console.log(`\n📊 Resultado: ${success} gerados, ${failed} falhas`);

    // Instruções para ICO e ICNS
    console.log('\n⚠️  Arquivos que precisam ser gerados manualmente:');
    console.log('');
    console.log('   📦 src-tauri/icons/icon.ico (Windows)');
    console.log('      → Use: https://convertico.com/');
    console.log('      → Upload: public/icons/icon-512x512.png');
    console.log('');
    console.log('   🍎 src-tauri/icons/icon.icns (macOS)');
    console.log('      → Use: https://cloudconvert.com/png-to-icns');
    console.log('      → Upload: public/icons/icon-512x512.png');
    console.log('');
    console.log('   🌐 public/favicon.svg');
    console.log('      → Converta manualmente ou use a versão PNG');
}

generateIcons().catch(console.error);
