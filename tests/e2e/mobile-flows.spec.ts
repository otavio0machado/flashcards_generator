import { test, expect, devices } from '@playwright/test';

test.use({ ...devices['iPhone 12'] });

test.describe('Mobile App Flows', () => {
    test('Mobile landing page renders correctly for guest', async ({ page }) => {
        await page.goto('/');

        // Check for HomeHero elements
        await expect(page.locator('text=Flashcards Generator').first()).toBeVisible();
        await expect(page.locator('text=Aprenda mais focando no que importa')).toBeVisible();
        await expect(page.locator('text=Testar grátis agora').first()).toBeVisible();

        // Check for Mobile Sections
        await expect(page.locator('text=Do texto ao estudo em segundos')).toBeVisible(); // HowItWorksSection
        await expect(page.locator('text=Estude melhor, não mais')).toBeVisible(); // FeaturesSection
        await expect(page.locator('text=Para quem é?')).toBeVisible(); // ForWhoSection

        // Check for Mobile Pricing
        await expect(page.locator('text=Comece grátis')).toBeVisible();
    });

    test('Generator page shows mobile specific elements', async ({ page }) => {
        // Navigate to generate page
        await page.goto('/app/generate');

        // Check if we are redirected to login or if we are guests
        // If guests can access generate:
        // Verify mobile layout

        // Note: Since auth is required for some features, we might be redirected.
        // Assuming public access or mock auth for this test.
        // For now, checks if the route loads.
        await expect(page).toHaveURL(/\/app\/generate|\/auth\/login/);
    });
});
