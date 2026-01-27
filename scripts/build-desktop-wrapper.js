const { execSync } = require('child_process');

console.log('🚀 Starting Desktop Build Process...');

// Set env var for Next.js config
process.env.NEXT_PUBLIC_IS_DESKTOP = 'true';

try {
    // Run Next.js build
    console.log('📦 Running next build (Static Export)...');
    execSync('npx next build', { stdio: 'inherit', env: { ...process.env, NEXT_PUBLIC_IS_DESKTOP: 'true' } });
    console.log('✅ Build successful! Output in /out');
} catch (error) {
    console.error('❌ Build failed:', error);
    process.exit(1);
}
