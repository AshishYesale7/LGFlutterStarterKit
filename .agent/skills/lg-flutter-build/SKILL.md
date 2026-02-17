```skill
---
name: lg-flutter-build
description: 'Builds, tests, and packages Flutter apps for all target platforms (Android APK, Web, Linux, macOS, iOS). Handles release signing, optimization, and artifact placement.'
---

# Liquid Galaxy Flutter Build Manager

## Overview

This skill manages the complete build pipeline for Liquid Galaxy Flutter applications across all supported platforms. It handles compilation, testing, optimization, and artifact generation.

**Announce at start:** "I'm using the lg-flutter-build skill to build your app for [Platform(s)]."

> **Context**: Gemini Summer of Code 2026 — the release APK is a key Task 2 deliverable.

### ⚠️ MANDATORY: APK Naming Convention

When building release APKs, the output **MUST** match the `LG-<TaskName>` convention:
- `android/app/build.gradle` → `applicationId` should reflect the project name
- Release notes and artifact filenames should reference `LG-<TaskName>`
- Example: `LG-Earthquake-Viz-arm64-v8a-release.apk`

## 🔍 Pre-Build Checks (Mandatory)

Before any build, run these verification steps:

```bash
# 1. Code Quality
cd flutter_client
flutter analyze                    # Zero errors required
dart format --set-exit-if-changed . # Formatting check

# 2. Tests
flutter test                       # All tests must pass

# 3. Dependency Resolution
flutter pub get                    # Ensure deps are resolved
flutter pub outdated               # Check for critical updates
```

If ANY check fails, **stop and fix** before building.

## 📱 Android Build (Primary — LG Rig Target)

### Debug Build (for development)
```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### Release Build (for submission)
```bash
flutter build apk --release --split-per-abi
# Outputs:
#   build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
#   build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk
#   build/app/outputs/flutter-apk/app-x86_64-release.apk
```

### With Custom LG Host (build-time config)
```bash
flutter build apk --release --dart-define=LG_HOST=192.168.1.100
flutter build apk --release --dart-define=LG_HOST=10.160.67.198
```

### Verification
- Install on device: `adb install build/app/outputs/flutter-apk/app-release.apk`
- Check it launches without crash
- Verify SSH connection to LG rig if applicable

## 🌐 Web Build

```bash
flutter build web --release --web-renderer canvaskit
# Output: build/web/
```

### Deployment Options
- **Local testing**: `cd build/web && python3 -m http.server 8080`
- **Firebase Hosting**: `firebase deploy --only hosting`
- **GitHub Pages**: Copy `build/web/` contents to `gh-pages` branch

### Verification
- Open in browser, verify no console errors
- Test KML generation and display
- Check responsive layout

## 🐧 Linux Build (LG Rig Native)

```bash
flutter build linux --release
# Output: build/linux/x64/release/bundle/
```

### Verification
- Run: `./build/linux/x64/release/bundle/<app_name>`
- Verify full-screen mode works
- Test SSH connection to LG master

## 🍎 macOS Build (Development)

```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/<AppName>.app
```

### Entitlements Required
Ensure `macos/Runner/Release.entitlements` includes:
```xml
<key>com.apple.security.network.client</key>
<true/>
<key>com.apple.security.network.server</key>
<true/>
```

## 📲 iOS Build (Optional Showcase)

```bash
flutter build ios --release --no-codesign
# Or with signing:
flutter build ipa --release
```

### Verification
- Test on simulator: `flutter run -d "iPhone 15 Pro"`
- Check network permissions in `Info.plist`

## 🏗 Build All Platforms Script

For a comprehensive build, execute sequentially:

```bash
#!/bin/bash
echo "=== LG Flutter Build Pipeline ==="

cd flutter_client

echo "[1/5] Running analysis..."
flutter analyze || exit 1

echo "[2/5] Running tests..."
flutter test || exit 1

echo "[3/5] Building Android APK..."
flutter build apk --release --split-per-abi || echo "Android build failed"

echo "[4/5] Building Web..."
flutter build web --release --web-renderer canvaskit || echo "Web build failed"

echo "[5/5] Building Linux..."
flutter build linux --release || echo "Linux build failed"

echo "=== Build Complete ==="
echo "Artifacts:"
ls -la build/app/outputs/flutter-apk/*.apk 2>/dev/null
ls -la build/web/index.html 2>/dev/null
ls -la build/linux/x64/release/bundle/ 2>/dev/null
```

## 📦 Artifact Management

After successful builds, organize artifacts:

```text
builds/
├── android/
│   ├── app-arm64-v8a-release.apk
│   └── app-x86_64-release.apk
├── web/
│   └── (web build contents)
├── linux/
│   └── (linux bundle)
└── BUILD_INFO.md  (auto-generated: date, commit, flutter version)
```

## Post-Build Commit

```bash
git add .
git commit -m "build: release artifacts for [platforms]"
```

## Reference Links

- **Flutter build modes**: https://docs.flutter.dev/testing/build-modes
- **Android APK signing**: https://docs.flutter.dev/deployment/android
- **Flutter web deployment**: https://docs.flutter.dev/deployment/web
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## Handoff

After successful build, ask:
- "Would you like to deploy to a test device?"
- "Ready for a Code Review?" -> Hand to **lg-code-reviewer**

```
