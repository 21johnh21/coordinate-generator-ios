#!/bin/bash

# Sync Web App to iOS
# Usage:
#   sh scripts/sync-web-app.sh       # Production build
#   sh scripts/sync-web-app.sh dev   # Development mode

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Path to your web app (adjust if needed)
WEB_APP_PATH="../coordinate-generator"

# Check if web app exists
if [ ! -d "$WEB_APP_PATH" ]; then
    echo -e "${RED}❌ Web app not found at $WEB_APP_PATH${NC}"
    echo "Please update WEB_APP_PATH in this script"
    exit 1
fi

# Development mode
if [ "$1" == "dev" ]; then
    echo -e "${BLUE}📱 Setting up for DEVELOPMENT mode${NC}"
    echo -e "${BLUE}   iOS app will connect to http://localhost:3000${NC}"
    echo ""
    echo -e "${GREEN}⚡ Make sure your web app is running:${NC}"
    echo "   cd $WEB_APP_PATH && npm start"
    echo ""

    # Copy dev config
    cp capacitor.config.dev.json capacitor.config.json

    # Create minimal www directory for dev
    mkdir -p www
    echo '<!DOCTYPE html><html><body>Loading from localhost:3000...</body></html>' > www/index.html

    # Sync and open
    npx cap sync ios
    npx cap open ios

    echo -e "${GREEN}✅ Development setup complete!${NC}"
    echo -e "${BLUE}   Run 'npm start' in your web app, then build in Xcode${NC}"
    exit 0
fi

# Production mode
echo -e "${BLUE}🏗️  Building web app for production...${NC}"

# Navigate to web app
cd "$WEB_APP_PATH"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo -e "${BLUE}📦 Installing web app dependencies...${NC}"
    npm install
fi

# Build the web app
echo -e "${BLUE}🔨 Building web app...${NC}"
npm run build

# Return to iOS project
cd - > /dev/null

# Clean www directory
echo -e "${BLUE}🧹 Cleaning www directory...${NC}"
rm -rf www/*

# Copy build to www
echo -e "${BLUE}📋 Copying build files...${NC}"
cp -r "$WEB_APP_PATH/build/"* www/

# Ensure production config
if [ -f "capacitor.config.dev.json" ]; then
    # Restore production config if it was in dev mode
    git checkout capacitor.config.json 2>/dev/null || true
fi

# Sync with iOS
echo -e "${BLUE}🔄 Syncing with iOS...${NC}"
npx cap sync ios

echo ""
echo -e "${GREEN}✅ Web app synced to iOS successfully!${NC}"
echo ""
echo -e "${BLUE}📱 Next steps:${NC}"
echo "   1. Open Xcode: ${GREEN}npm run ios${NC}"
echo "   2. Select a simulator or device"
echo "   3. Click the Play button to run"
echo ""
echo -e "${BLUE}💡 Tips:${NC}"
echo "   - For live reload: ${GREEN}npm run sync:dev${NC}"
echo "   - To rebuild: ${GREEN}npm run sync${NC}"
