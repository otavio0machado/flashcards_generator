/**
 * Script para otimizar as logos para web
 * 
 * Uso: node scripts/optimize-logos.mjs
 * 
 * Reduz o tamanho das logos mantendo qualidade visual
 */

import sharp from 'sharp';
import { existsSync } from 'fs';
import { stat } from 'fs/promises';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = join(__dirname, '..');

const logos = [
    {
        input: 'public/logo.png',
        output: 'public/logo.png',
        maxWidth: 400,  // Largura máxima para logo
    },
    {
        input: 'public/logo-dark.png',
        output: 'public/logo-dark.png',
        maxWidth: 400,
    },
];

function formatBytes(bytes) {
    if (bytes < 1024) return bytes + ' B';
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
    return (bytes / (1024 * 1024)).toFixed(2) + ' MB';
}

async function optimizeLogos() {
    console.log('🎨 Otimizando logos...\n');

    for (const logo of logos) {
        const inputPath = join(ROOT, logo.input);
        const outputPath = join(ROOT, logo.output);

        if (!existsSync(inputPath)) {
            console.log(`⚠️  ${logo.input} não encontrado, pulando...`);
            continue;
        }

        try {
            // Tamanho original
            const originalStats = await stat(inputPath);
            const originalSize = originalStats.size;

            // Ler metadata
            const metadata = await sharp(inputPath).metadata();
            console.log(`📁 ${logo.input}`);
            console.log(`   Original: ${metadata.width}x${metadata.height} (${formatBytes(originalSize)})`);

            // Calcular nova altura mantendo proporção
            const aspectRatio = metadata.height / metadata.width;
            const newWidth = Math.min(metadata.width, logo.maxWidth);
            const newHeight = Math.round(newWidth * aspectRatio);

            // Otimizar
            await sharp(inputPath)
                .resize(newWidth, newHeight, {
                    fit: 'inside',
                    withoutEnlargement: true,
                })
                .png({
                    quality: 85,
                    compressionLevel: 9,
                    palette: true,  // Usar paleta de cores para reduzir tamanho
                })
                .toFile(outputPath + '.tmp');

            // Substituir original
            const { rename, unlink } = await import('fs/promises');
            if (existsSync(outputPath)) {
                await unlink(outputPath);
            }
            await rename(outputPath + '.tmp', outputPath);

            // Tamanho final
            const finalStats = await stat(outputPath);
            const finalSize = finalStats.size;
            const reduction = ((1 - finalSize / originalSize) * 100).toFixed(1);

            console.log(`   Otimizado: ${newWidth}x${newHeight} (${formatBytes(finalSize)})`);
            console.log(`   ✅ Redução: ${reduction}%\n`);

        } catch (error) {
            console.error(`❌ Erro ao processar ${logo.input}: ${error.message}\n`);
        }
    }

    console.log('✨ Otimização concluída!');
}

optimizeLogos().catch(console.error);
