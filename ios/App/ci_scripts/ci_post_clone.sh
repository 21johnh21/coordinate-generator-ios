#!/bin/sh

# Xcode Cloud Post-Clone Script
# This script runs after Xcode Cloud clones the repository

set -e

echo "🔍 Starting Xcode Cloud build preparation"

# Xcode Cloud provides CI_WORKSPACE_PATH and CI_PRIMARY_REPOSITORY_PATH
# CI_WORKSPACE_PATH = /Volumes/workspace
# CI_PRIMARY_REPOSITORY_PATH = /Volumes/workspace/repository (this iOS repo)
IOS_REPO_PATH="${CI_PRIMARY_REPOSITORY_PATH:-$(cd ../../.. && pwd)}"
WORKSPACE_PATH="${CI_WORKSPACE_PATH:-$(cd ../../../.. && pwd)}"
WEB_REPO_PATH="${WORKSPACE_PATH}/coordinate-generator"

echo "📍 iOS repo: ${IOS_REPO_PATH}"
echo "📍 Workspace: ${WORKSPACE_PATH}"
echo "📍 Web app will be cloned to: ${WEB_REPO_PATH}"

# Install Node.js using Homebrew (pre-installed on Xcode Cloud)
echo "📦 Installing Node.js..."
brew install node

# Install iOS wrapper dependencies
echo "📦 Installing iOS wrapper dependencies..."
cd "${IOS_REPO_PATH}"
npm install

# Clone web app repository
echo "📥 Cloning web app repository..."
cd "${WORKSPACE_PATH}"
if [ -d "coordinate-generator" ]; then
  echo "Removing existing coordinate-generator directory..."
  rm -rf coordinate-generator
fi
git clone https://github.com/21johnh21/coordinate-generator.git

# Build web app
echo "📦 Installing web app dependencies..."
cd "${WEB_REPO_PATH}"
npm install

echo "🔨 Building web app..."
npm run build

# Copy to iOS project
echo "📋 Copying web app to iOS..."
cd "${IOS_REPO_PATH}"
mkdir -p www
rm -rf www/*
cp -r "${WEB_REPO_PATH}/build/"* www/

# Sync with Capacitor
echo "🔄 Syncing with Capacitor..."
npx cap sync ios

echo "✅ Build preparation complete!"
