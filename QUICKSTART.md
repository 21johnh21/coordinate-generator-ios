# 🚀 Quick Start Guide

## First Time Setup (5 minutes)

```bash
# 1. Install dependencies
npm install

# 2. Initialize iOS project
npx cap add ios

# 3. Sync your web app
npm run sync

# 4. Open in Xcode
npm run ios
```

Then in Xcode: Click ▶️ to run!

---

## Daily Development Workflow

### Option 1: Live Reload (Recommended) ⚡

```bash
# Terminal 1: Start web app
cd ../coordinate-generator
npm start

# Terminal 2: Set up iOS dev mode
cd ../coordinate-generator-ios
npm run sync:dev
```

In Xcode: Run the app. Changes to your web app will show immediately!

### Option 2: Production Build 📦

```bash
# Build and sync
npm run sync

# Open Xcode
npm run ios
```

---

## Common Commands

| What you want to do | Command |
|---------------------|---------|
| First time setup | `npm install` → `npx cap add ios` |
| Development with live reload | `npm run sync:dev` |
| Build production version | `npm run sync` |
| Open in Xcode | `npm run ios` |
| Update Capacitor | `npm run update` |
| Start fresh | `npm run clean` → `npm run sync` |

---

## Troubleshooting

**App shows placeholder page?**
```bash
npm run sync
```

**Changes not showing up?**
- Dev mode: Ensure web app is running on localhost:3000
- Prod mode: Run `npm run sync` again

**Xcode build errors?**
```bash
npm run clean
npm install
npx cap sync ios
```

**"Could not find Capacitor"?**
```bash
npm install
npx cap sync ios
```

---

## Next Steps

- Read the full [README.md](./README.md)
- Customize app icon in Xcode
- Update app name and bundle ID
- Test on real device
- [Prepare for App Store](./README.md#building-for-app-store)

---

## Need Help?

1. Check [README.md](./README.md) for detailed docs
2. Visit [Capacitor Docs](https://capacitorjs.com/docs)
3. Run `npx cap doctor` to diagnose issues
