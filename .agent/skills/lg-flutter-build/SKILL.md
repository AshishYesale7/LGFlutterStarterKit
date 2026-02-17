---
name: lg-flutter-build
description: Build and deploy Flutter apps for LG rig testing
---

# LG Flutter Build

Manages the build process for Flutter apps targeting the Liquid Galaxy.

## Build Targets
1. **Debug APK**: `flutter build apk --debug`
2. **Release APK**: `flutter build apk --release`
3. **With LG Host**: `flutter build apk --dart-define=LG_HOST=192.168.56.101`
4. **App Bundle**: `flutter build appbundle`

## Build Verification
1. `flutter analyze` — zero errors
2. `flutter test` — all passing
3. `flutter build apk --debug` — successful build
4. Install on device/emulator: `flutter install`
5. Verify app launches and connects to LG rig

## Size Optimization
- Enable ProGuard for release builds
- Use `--split-per-abi` for smaller APKs
- Remove unused assets and dependencies
- Use `flutter build apk --release --split-per-abi`

## Deployment
1. Build release APK
2. Transfer to device via ADB: `adb install build/app/outputs/flutter-apk/app-release.apk`
3. Or upload to GitHub Release
