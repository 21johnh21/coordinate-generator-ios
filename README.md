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

## ☁️ Xcode Cloud Setup (Automated Builds)

This project is configured to build automatically using Xcode Cloud. The build script handles cloning the web app and building everything for you.

### Prerequisites

1. **Two GitHub Repositories** (both required):
   - `coordinate-generator-ios` (this repo) - iOS wrapper
   - `coordinate-generator` (web app) - React application

2. **App Store Connect Access**
   - Apple Developer account
   - App created in App Store Connect

### Initial Setup

#### 1. Configure Additional Repositories

Xcode Cloud needs access to both repositories:

1. Go to [App Store Connect](https://appstoreconnect.apple.com/)
2. **Apps** → **Geo Roulette** → **Xcode Cloud** tab
3. Go to **Settings** (gear icon) → **Repositories** tab
4. Under **Additional Repositories**, you should see `coordinate-generator` detected
5. Click **Grant** next to it
6. Authorize GitHub access on the GitHub page that opens
7. On GitHub (https://github.com/settings/installations):
   - Find **Xcode Cloud** app installation
   - Under **Repository access**, select repositories:
     - ✅ `coordinate-generator-ios`
     - ✅ `coordinate-generator`
   - Click **Save**

#### 2. Set Environment Variables

Critical for building the React app:

1. In App Store Connect → **Xcode Cloud** → Your workflow
2. Click **Edit Workflow**
3. Scroll to **Environment Variables** section
4. Add variable:
   - **Name**: `REACT_APP_MAPBOX_TOKEN`
   - **Value**: Your Mapbox access token
   - ✅ Check **Secret**
   - ✅ Ensure **"Expose to Xcode build and to pre- and post-action build scripts"** is enabled

#### 3. Build Script

The project includes `ios/App/ci_scripts/ci_post_clone.sh` that runs automatically:

```sh
#!/bin/sh
# Xcode Cloud automatically runs this script after cloning

# 1. Installs Node.js
# 2. Installs dependencies for iOS wrapper
# 3. Accesses web app repo (auto-cloned by Xcode Cloud)
# 4. Installs web app dependencies
# 5. Builds React app with environment variables
# 6. Copies build to iOS wrapper
# 7. Syncs with Capacitor
```

**No manual action needed** - this script runs automatically on every build.

### Starting a Build

#### In Xcode:
1. **Product** → **Xcode Cloud** → **Start Build**

#### In App Store Connect:
1. Go to your app → **Xcode Cloud** tab
2. Click **Start Build**

The build takes ~10-15 minutes:
- Clone repositories
- Install Node.js and dependencies
- Build React app
- Build iOS app
- Archive for App Store

### Troubleshooting Xcode Cloud

#### "npm: command not found"
- The script installs Node.js automatically
- Check that the build script is executable: `chmod +x ios/App/ci_scripts/ci_post_clone.sh`

#### "Could not read Username for github"
- Grant access to `coordinate-generator` in Additional Repositories (see setup above)
- Ensure both repos are authorized in GitHub settings

#### "REACT_APP_MAPBOX_TOKEN is not set"
- Add environment variable in Xcode Cloud workflow settings
- Make sure "Expose to... pre- and post-action build scripts" is checked

#### Build succeeds but missing features
- Verify environment variables are set correctly
- Check build logs in App Store Connect for warnings

## 🏗️ Building for App Store (Manual)

If you prefer to build locally instead of using Xcode Cloud:

### 1. Configure App

In Xcode:
1. Open project: `npm run ios`
2. Select the project root in the navigator
3. Go to **Signing & Capabilities** tab
4. Select your Team
5. Ensure Bundle Identifier is unique: `com.georoulette.app`

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

### 4. Configure Privacy & Compliance

Already configured in `ios/App/App/Info.plist`:

```xml
<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>Geo Roulette needs your location to generate random coordinates near you when using the "Near Me" feature. Your location is never stored or shared.</string>

<!-- Required by iOS SDK, even if not requesting "always" permission -->
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Geo Roulette needs your location to generate random coordinates near you when using the "Near Me" feature. Your location is never stored or shared.</string>

<!-- Export Compliance - No custom encryption used -->
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

### 5. Configure Mapbox URL Restrictions

For production, add these URLs to your Mapbox token restrictions:

- **iOS App**: `https://localhost` (Capacitor serves from this origin)
- **Web App**: `https://yourdomain.vercel.app` (or your actual domain)

⚠️ **Important**: Use exact URLs, no wildcards. Mapbox doesn't support `https://localhost/*`.

### 6. Archive and Upload

1. Ensure you've built the latest web app: `npm run sync`
2. In Xcode: **Product** → **Archive**
3. When complete, the Organizer window opens
4. Click **Distribute App**
5. Choose **App Store Connect**
6. Follow the wizard to upload

### 7. App Store Connect Submission

After uploading, you may be asked about encryption:

**Question**: "What type of encryption algorithms does your app implement?"

**Answer**: Select **"None of the algorithms mentioned above"**

Your app only uses:
- Standard HTTPS for Mapbox API (provided by iOS)
- No custom encryption

The `ITSAppUsesNonExemptEncryption` key in Info.plist will skip this prompt in future submissions.

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
