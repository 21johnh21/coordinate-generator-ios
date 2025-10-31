#!/usr/bin/env node

/**
 * Geo Roulette Splash Screen Generator
 *
 * This script creates a 2732x2732 PNG splash screen using Canvas.
 * Run: node generate-splash.js
 */

const fs = require('fs');
const { createCanvas, loadImage } = require('canvas');

async function generateSplashScreen() {
  console.log('🎨 Generating Geo Roulette splash screen...');

  // Create 2732x2732 canvas
  const canvas = createCanvas(2732, 2732);
  const ctx = canvas.getContext('2d');

  // Background gradient
  const gradient = ctx.createLinearGradient(0, 0, 2732, 2732);
  gradient.addColorStop(0, '#0f172a');
  gradient.addColorStop(0.5, '#1e293b');
  gradient.addColorStop(1, '#0f172a');
  ctx.fillStyle = gradient;
  ctx.fillRect(0, 0, 2732, 2732);

  // Decorative gradient orbs
  // Top-right orb
  const orb1 = ctx.createRadialGradient(2532, 200, 0, 2532, 200, 800);
  orb1.addColorStop(0, 'rgba(16, 185, 129, 0.15)');
  orb1.addColorStop(0.7, 'rgba(16, 185, 129, 0)');
  orb1.addColorStop(1, 'transparent');
  ctx.fillStyle = orb1;
  ctx.fillRect(0, 0, 2732, 2732);

  // Bottom-left orb
  const orb2 = ctx.createRadialGradient(200, 2532, 0, 200, 2532, 600);
  orb2.addColorStop(0, 'rgba(20, 184, 166, 0.15)');
  orb2.addColorStop(0.7, 'rgba(20, 184, 166, 0)');
  orb2.addColorStop(1, 'transparent');
  ctx.fillStyle = orb2;
  ctx.fillRect(0, 0, 2732, 2732);

  // Icon container (rounded square with gradient)
  const iconSize = 512;
  const iconX = (2732 - iconSize) / 2;
  const iconY = 900;
  const borderRadius = 120;

  // Create gradient for icon background
  const iconGradient = ctx.createLinearGradient(iconX, iconY, iconX + iconSize, iconY + iconSize);
  iconGradient.addColorStop(0, '#10b981');
  iconGradient.addColorStop(1, '#14b8a6');

  // Draw rounded rectangle
  ctx.fillStyle = iconGradient;
  ctx.beginPath();
  ctx.moveTo(iconX + borderRadius, iconY);
  ctx.lineTo(iconX + iconSize - borderRadius, iconY);
  ctx.quadraticCurveTo(iconX + iconSize, iconY, iconX + iconSize, iconY + borderRadius);
  ctx.lineTo(iconX + iconSize, iconY + iconSize - borderRadius);
  ctx.quadraticCurveTo(iconX + iconSize, iconY + iconSize, iconX + iconSize - borderRadius, iconY + iconSize);
  ctx.lineTo(iconX + borderRadius, iconY + iconSize);
  ctx.quadraticCurveTo(iconX, iconY + iconSize, iconX, iconY + iconSize - borderRadius);
  ctx.lineTo(iconX, iconY + borderRadius);
  ctx.quadraticCurveTo(iconX, iconY, iconX + borderRadius, iconY);
  ctx.closePath();
  ctx.fill();

  // Draw shadow for icon
  ctx.shadowColor = 'rgba(16, 185, 129, 0.4)';
  ctx.shadowBlur = 40;
  ctx.shadowOffsetY = 20;
  ctx.fill();
  ctx.shadowColor = 'transparent';
  ctx.shadowBlur = 0;
  ctx.shadowOffsetY = 0;

  // Try to load and draw the icon
  try {
    if (fs.existsSync('icon.png')) {
      const icon = await loadImage('icon.png');
      const innerIconSize = 380;
      const innerIconX = iconX + (iconSize - innerIconSize) / 2;
      const innerIconY = iconY + (iconSize - innerIconSize) / 2;
      ctx.drawImage(icon, innerIconX, innerIconY, innerIconSize, innerIconSize);
    } else {
      console.log('⚠️  icon.png not found, skipping icon overlay');
    }
  } catch (err) {
    console.log('⚠️  Could not load icon.png:', err.message);
  }

  // App name
  ctx.font = 'bold 160px -apple-system, system-ui, sans-serif';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';

  const textGradient = ctx.createLinearGradient(0, 1520, 2732, 1520);
  textGradient.addColorStop(0, '#10b981');
  textGradient.addColorStop(1, '#14b8a6');
  ctx.fillStyle = textGradient;
  ctx.fillText('Geo Roulette', 1366, 1520);

  // Tagline
  ctx.font = '400 72px -apple-system, system-ui, sans-serif';
  ctx.fillStyle = '#94a3b8';
  ctx.fillText('Random Coordinates Worldwide', 1366, 1680);

  // Save to file
  const buffer = canvas.toBuffer('image/png');
  fs.writeFileSync('splash.png', buffer);

  console.log('✅ Splash screen generated: splash.png (2732x2732)');
  console.log('');
  console.log('Next steps:');
  console.log('  1. Check splash.png to see if it looks good');
  console.log('  2. Run: cordova-res ios --type splash --splash-source splash.png --skip-config --copy');
  console.log('  3. Run: npm run sync');
}

generateSplashScreen().catch(err => {
  console.error('❌ Error generating splash screen:', err);
  process.exit(1);
});
