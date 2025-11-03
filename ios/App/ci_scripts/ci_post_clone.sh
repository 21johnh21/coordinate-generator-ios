#!/bin/sh

# Xcode Cloud Post-Clone Script
# This script runs after Xcode Cloud clones the repository

set -e

echo "🔍 Starting Xcode Cloud build preparation"

# Install Node.js using Homebrew (pre-installed on Xcode Cloud)
echo "📦 Installing Node.js..."
brew install node

# Navigate to project root
cd ../../..

echo "📦 Installing iOS wrapper dependencies..."
npm install

echo "📥 Cloning web app repository..."
cd ..
if [ -d "coordinate-generator" ]; then
  echo "Removing existing coordinate-generator directory..."
  rm -rf coordinate-generator
fi

# Clone the web app repository (Xcode Cloud has access via Additional Repositories)
git clone https://github.com/21johnh21/coordinate-generator.git
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
