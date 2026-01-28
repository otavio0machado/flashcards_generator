import { test, expect } from '@playwright/test';

test.describe('Generator flow', () => {
  test('Generate -> Edit inline -> Delete card', async ({ page }) => {
    await page.goto('/app');

    // Ensure textarea is present and input sample content
    const textarea = page.locator('#content-input');
    await expect(textarea).toBeVisible();
    const sample = `A mitocôndria é a organela responsável pela respiração celular e produção de ATP. Este texto tem mais de cinquenta caracteres para fins de teste.`;

    await textarea.fill(sample);

    // Click Generate and wait for spinner to disappear
    await page.click('#generate-button');

    // Wait for cards view; first card should appear
    const firstCardHeader = page.locator('text=Card #1');
    await expect(firstCardHeader).toBeVisible({ timeout: 10000 });

    // Edit first card
    const editButtons = page.locator('button[aria-label="Editar"]');
    await expect(editButtons.first()).toBeVisible();
    await editButtons.first().click();

    const firstQuestionTextarea = page.locator('textarea').nth(0); // first textarea in editor
    await firstQuestionTextarea.fill('Qual é a função da mitocôndria?');

    const saveButton = page.locator('button', { hasText: 'Salvar' }).first();
    await saveButton.click();

    // Verify updated question text appears
    await expect(page.locator('text="Qual é a função da mitocôndria?"')).toBeVisible();

    // Delete the first card
    const deleteButtons = page.locator('button[aria-label="Excluir"]');
    const beforeCount = await page.locator('text=Card #').count();
    await deleteButtons.first().click();

    // After deletion, number of cards should be less (or Card #1 no longer present)
    await expect(page.locator('text=Card #1')).not.toBeVisible();
  });
});