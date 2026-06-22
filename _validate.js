// Playwright validation for TostiBurguer landing
const { chromium } = require('C:/Users/User/.minimax-agent/projects/nocturne-speakeasy/node_modules/playwright');
const path = require('path');

const URL = 'https://agent-cdn.minimax.io/mcp/anon/general/1782086658_010feacb.html';
const SHOTS = 'C:/Users/User/.minimax-agent/projects/tostiburguer/shots';

(async () => {
  const browser = await chromium.launch({ headless: true });
  const ctx = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const page = await ctx.newPage();

  const pageErrors = [];
  const consoleErrors = [];
  const failedRequests = [];
  const successfulImgs = [];

  page.on('pageerror', e => pageErrors.push(e.message));
  page.on('console', m => { if (m.type() === 'error') consoleErrors.push(m.text()); });
  page.on('requestfailed', r => failedRequests.push(`${r.url()} -> ${r.failure() && r.failure().errorText}`));
  page.on('response', r => {
    if (r.url().match(/\.(jpg|jpeg|png|gif|webp|svg)$/i) && r.status() === 200) {
      successfulImgs.push(r.url().split('/').pop().slice(0, 60));
    }
  });

  console.log('Loading page...');
  await page.goto(URL, { waitUntil: 'networkidle', timeout: 30000 });
  await page.waitForTimeout(2500);

  // Check key elements
  const heroH1 = await page.locator('.hero h1').textContent().catch(() => null);
  const cardCount = await page.locator('.card').count();
  const filterCount = await page.locator('.filter__btn').count();
  const comboCount = await page.locator('.combo').count();
  const canvasOk = await page.evaluate(() => {
    const c = document.getElementById('menuCanvas');
    return c ? { w: c.width, h: c.height } : null;
  });

  console.log('--- DIAG ---');
  console.log('Hero h1:', heroH1);
  console.log('Cards:', cardCount, '| Filters:', filterCount, '| Combos:', comboCount);
  console.log('Canvas:', canvasOk);
  console.log('Page errors:', pageErrors.length, pageErrors);
  console.log('Console errors:', consoleErrors.length, consoleErrors);
  console.log('Failed requests:', failedRequests.length, failedRequests);
  console.log('Images loaded OK:', successfulImgs.length);

  // Screenshots
  console.log('\nTaking screenshots...');
  await page.screenshot({ path: path.join(SHOTS, '01_hero.png'), fullPage: false });

  await page.locator('#menu').scrollIntoViewIfNeeded();
  await page.waitForTimeout(800);
  await page.screenshot({ path: path.join(SHOTS, '02_menu.png'), fullPage: false });

  // hover on a card to test canvas spotlight
  const firstCard = page.locator('.card').first();
  await firstCard.hover();
  await page.waitForTimeout(600);
  await page.screenshot({ path: path.join(SHOTS, '03_menu_hover.png'), fullPage: false });

  await page.locator('#combos').scrollIntoViewIfNeeded();
  await page.waitForTimeout(600);
  await page.screenshot({ path: path.join(SHOTS, '04_combos.png'), fullPage: false });

  await page.locator('#about').scrollIntoViewIfNeeded();
  await page.waitForTimeout(600);
  await page.screenshot({ path: path.join(SHOTS, '05_about.png'), fullPage: false });

  await page.locator('#contact').scrollIntoViewIfNeeded();
  await page.waitForTimeout(600);
  await page.screenshot({ path: path.join(SHOTS, '06_contact.png'), fullPage: false });

  // full page
  await page.screenshot({ path: path.join(SHOTS, '00_full.png'), fullPage: true });

  // mobile
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(URL, { waitUntil: 'networkidle' });
  await page.waitForTimeout(2000);
  await page.screenshot({ path: path.join(SHOTS, '07_mobile.png'), fullPage: false });

  await browser.close();
  console.log('\nDONE');
})().catch(e => { console.error('FATAL:', e); process.exit(1); });