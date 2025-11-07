#!/bin/sh

# Pre-Xcodebuild Script
# Runs right before xcodebuild starts

set -e

echo "🔧 Pre-xcodebuild configuration"

# Verify that Capacitor sync completed successfully
if [ ! -d "${CI_PRIMARY_REPOSITORY_PATH}/ios/App/App/public" ]; then
    echo "❌ Error: public folder not found. Capacitor sync may have failed."
    exit 1
fi

echo "✅ Pre-xcodebuild checks passed"
