/**
 * Script para gerar ícones PWA em múltiplos tamanhos
 * Requer: npm install sharp
 * Uso: node scripts/generate-icons.js
 */

const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const sizes = [72, 96, 128, 144, 152, 192, 384, 512];
const inputFile = path.join(__dirname, '../public/logo.png');
const outputDir = path.join(__dirname, '../public/icons');

async function generateIcons() {
    // Criar diretório de saída se não existir
    if (!fs.existsSync(outputDir)) {
        fs.mkdirSync(outputDir, { recursive: true });
    }

    console.log('🎨 Gerando ícones PWA...\n');

    for (const size of sizes) {
        const outputFile = path.join(outputDir, `icon-${size}x${size}.png`);
        
        try {
            await sharp(inputFile)
                .resize(size, size, {
                    fit: 'contain',
                    background: { r: 255, g: 255, b: 255, alpha: 1 }
                })
                .png()
                .toFile(outputFile);
            
            console.log(`✅ icon-${size}x${size}.png`);
        } catch (error) {
            console.error(`❌ Erro ao gerar icon-${size}x${size}.png:`, error.message);
        }
    }

    // Gerar Apple Touch Icon (180x180)
    try {
        await sharp(inputFile)
            .resize(180, 180, {
                fit: 'contain',
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .png()
            .toFile(path.join(outputDir, 'apple-touch-icon.png'));
        
        console.log('✅ apple-touch-icon.png (180x180)');
    } catch (error) {
        console.error('❌ Erro ao gerar apple-touch-icon:', error.message);
    }

    // Gerar favicon (32x32)
    try {
        await sharp(inputFile)
            .resize(32, 32, {
                fit: 'contain',
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .png()
            .toFile(path.join(outputDir, 'favicon-32x32.png'));
        
        console.log('✅ favicon-32x32.png');
    } catch (error) {
        console.error('❌ Erro ao gerar favicon:', error.message);
    }

    // Gerar favicon 16x16
    try {
        await sharp(inputFile)
            .resize(16, 16, {
                fit: 'contain',
                background: { r: 255, g: 255, b: 255, alpha: 1 }
            })
            .png()
            .toFile(path.join(outputDir, 'favicon-16x16.png'));
        
        console.log('✅ favicon-16x16.png');
    } catch (error) {
        console.error('❌ Erro ao gerar favicon 16x16:', error.message);
    }

    console.log('\n🎉 Ícones gerados com sucesso em /public/icons/');
}

generateIcons().catch(console.error);
