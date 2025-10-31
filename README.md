# Geo Roulette - iOS App

Native iOS wrapper for the Geo Roulette coordinate generator web app using [Capacitor](https://capacitorjs.com/).

## 📋 Prerequisites

- **macOS** (required for iOS development)
- **Xcode 14+** (from App Store)
- **Node.js 16+** and npm
- **CocoaPods** (install: `sudo gem install cocoapods`)
- **Xcode Command Line Tools**: `xcode-select --install`

## 🚀 Quick Start

### 1. Install Dependencies

```bash
npm install
```

### 2. Choose Your Development Mode

#### Option A: Development Mode (Live Reload) ⚡

Best for active development. The iOS app connects to your local web server.

```bash
# 1. Start your web app (in separate terminal)
cd ../coordinate-generator
npm start

# 2. Set up iOS for development
npm run sync:dev

# This will:
# - Configure Capacitor to use localhost:3000
# - Open Xcode
# - You can now run the app and see live changes!
```

#### Option B: Production Mode (Bundled) 📦

For testing the production build or preparing for release.

```bash
# Build web app and sync to iOS
npm run sync

# Open in Xcode
npm run ios
```

### 3. Run in Xcode

Once Xcode opens:
1. Select a simulator or connected device from the top toolbar
2. Click the ▶️ Play button (or press Cmd+R)
3. The app will build and launch!

## 📱 Project Structure

```
coordinate-generator-ios/
├── capacitor.config.json           # Production config
├── capacitor.config.dev.json       # Development config (localhost)
├── package.json                    # Dependencies and scripts
├── scripts/
│   └── sync-web-app.sh            # Build and sync automation
├── www/                           # Web app build output
│   └── (generated files)
└── ios/                           # Generated iOS project
    └── App/
        └── App.xcodeproj          # Xcode project
```

## 🛠️ Available Scripts

| Script | Description |
|--------|-------------|
| `npm run sync:dev` | Development mode - connect to localhost:3000 |
| `npm run sync` | Build web app and sync to iOS |
| `npm run ios` | Open project in Xcode |
| `npm run build` | Full production build |
| `npm run update` | Update Capacitor iOS platform |
| `npm run clean` | Clean all generated files |

## 🔧 Configuration

### App Info

Update these in `capacitor.config.json`:

```json
{
  "appId": "com.georoulette.app",
  "appName": "Geo Roulette"
}
```

### Colors & Theme

The app uses the same dark theme as the web app:
- Background: `#0f172a` (slate-900)
- Primary: Emerald green gradient

### Permissions

Already configured in `capacitor.config.json`:
- ✅ Location (when in use) - for "Near Me" feature
- ✅ Haptic feedback
- ✅ Share sheet

## 📲 Native Features

### Already Working

These web APIs work seamlessly through Capacitor:

- ✅ **Geolocation** - `navigator.geolocation` works natively
- ✅ **Clipboard** - Copy coordinates
- ✅ **Deep Links** - Open in Apple Maps
- ✅ **localStorage** - Settings persistence
- ✅ **Touch gestures** - Map interactions

### Optional Enhancements

To add native iOS features, install plugins:

```bash
# Haptic feedback
npm install @capacitor/haptics

# Native share sheet
npm install @capacitor/share

# Status bar control
npm install @capacitor/status-bar
```

Then use in your web app:

```javascript
import { Haptics, ImpactStyle } from '@capacitor/haptics';

// Add haptic feedback when generating coordinates
await Haptics.impact({ style: ImpactStyle.Medium });
```

## 🏗️ Building for App Store

### 1. Configure App

In Xcode:
1. Open project: `npm run ios`
2. Select the project root in the navigator
3. Go to **Signing & Capabilities** tab
4. Select your Team
5. Ensure Bundle Identifier is unique: `com.yourcompany.georoulette`

### 2. Set Version & Build Number

In Xcode:
- **General** tab → **Version**: 1.0.0
- **General** tab → **Build**: 1

Or edit `ios/App/App/Info.plist`:
```xml
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
<key>CFBundleVersion</key>
<string>1</string>
```

### 3. Add App Icon

1. Create icon set (1024x1024 PNG)
2. Use [AppIcon Generator](https://appicon.co/) to generate all sizes
3. In Xcode: **Assets.xcassets** → **AppIcon** → Drag images

Or use automated tool:
```bash
npm install -g cordova-res
cordova-res ios --skip-config --copy
```

### 4. Configure Privacy Descriptions

Already set in `ios/App/App/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Geo Roulette needs your location to generate nearby random coordinates</string>
```

### 5. Archive and Upload

1. In Xcode: **Product** → **Archive**
2. When complete, the Organizer window opens
3. Click **Distribute App**
4. Choose **App Store Connect**
5. Follow the wizard to upload

## 🐛 Troubleshooting

### "Could not find module 'Capacitor'"

```bash
npm install
npx cap sync ios
```

### "No such file or directory - www/"

```bash
npm run sync
```

### Changes not showing up

Development mode:
```bash
# Make sure web app is running first
cd ../coordinate-generator && npm start

# Then sync
npm run sync:dev
```

Production mode:
```bash
npm run sync  # Rebuilds everything
```

### CocoaPods errors

```bash
cd ios/App
pod repo update
pod install --repo-update
cd ../..
npx cap sync ios
```

### "Developer Mode is not enabled" on iOS 16+

On your device:
1. Settings → Privacy & Security
2. Developer Mode → Enable
3. Restart device

## 🔄 Workflow Tips

### Daily Development

1. Keep web app running: `cd ../coordinate-generator && npm start`
2. Use dev mode: `npm run sync:dev`
3. Make changes to web app → automatically reflected in iOS
4. Rebuild in Xcode when needed

### Before Testing

```bash
# Fresh production build
npm run clean
npm run sync
npm run ios
```

### Before Release

1. Update version numbers in `package.json` and Xcode
2. Test on physical device
3. Full production build: `npm run build`
4. Archive in Xcode

## 📚 Resources

- [Capacitor Docs](https://capacitorjs.com/docs)
- [Capacitor iOS Guide](https://capacitorjs.com/docs/ios)
- [Apple Developer](https://developer.apple.com/)
- [App Store Connect](https://appstoreconnect.apple.com/)

## 🆘 Need Help?

1. Check [Capacitor Docs](https://capacitorjs.com/docs)
2. Review logs: `npx cap doctor`
3. Clean and rebuild: `npm run clean && npm run sync`

## 📄 License

Same as the web app.
