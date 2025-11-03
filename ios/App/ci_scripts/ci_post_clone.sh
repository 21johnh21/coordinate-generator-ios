#!/bin/sh

# Xcode Cloud Post-Clone Script
# This script runs after Xcode Cloud clones the repository

set -e

echo "🔍 Starting Xcode Cloud build preparation"
echo "📍 Current directory: $(pwd)"

# Install Node.js using Homebrew (pre-installed on Xcode Cloud)
echo "📦 Installing Node.js..."
brew install node

# Verify installation
echo "✅ Node version: $(node --version)"
echo "✅ npm version: $(npm --version)"

# Navigate to project root
cd ../../..
echo "📍 Project root: $(pwd)"

echo "📦 Installing iOS wrapper dependencies..."
npm install

echo "📥 Cloning web app repository..."
cd ..
if [ -d "coordinate-generator" ]; then
  echo "⚠️  Web app directory already exists, removing..."
  rm -rf coordinate-generator
fi

# Use GitHub token for authentication if available
if [ -n "$GITHUB_TOKEN" ]; then
  echo "🔐 Using authenticated clone..."
  git clone https://${GITHUB_TOKEN}@github.com/21johnh21/coordinate-generator.git
else
  echo "⚠️  No GITHUB_TOKEN found, trying public clone..."
  git clone https://github.com/21johnh21/coordinate-generator.git
fi

cd coordinate-generator

echo "📦 Installing web app dependencies..."
npm install

echo "🔨 Building web app..."
npm run build

echo "📋 Copying web app to iOS..."
cd ../coordinate-generator-ios
rm -rf www/*
cp -r ../coordinate-generator/build/* www/

echo "🔄 Syncing with Capacitor..."
npx cap sync ios

echo "✅ Build preparation complete!"
