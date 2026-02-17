---
name: lg-dependency-resolver
description: Diagnose and fix dependency resolution failures
---

# LG Dependency Resolver

Targeted diagnosis and fix for dependency resolution failures.

## Error Classification
| Error Type | Detection | Fix |
|-----------|-----------|-----|
| `pub get` failure | "version solving failed" | Check version constraints, try `flutter pub upgrade` |
| Gradle build failure | "Could not resolve" | Check `android/build.gradle`, sync SDK versions |
| CocoaPods failure | "pod install failed" | `cd ios && pod install --repo-update` |
| SDK mismatch | "requires SDK version" | Update `pubspec.yaml` environment constraint |
| Dependency conflict | "incompatible versions" | Use dependency_overrides or update constraints |

## Resolution Protocol
1. Read the exact error message
2. Classify the error type
3. Apply the targeted fix (NOT just "flutter clean")
4. Verify with `flutter pub get` + `flutter analyze`

## Common Fixes
```bash
# Clear all caches and rebuild
flutter clean
flutter pub cache repair
flutter pub get

# Gradle specific
cd android && ./gradlew clean && cd ..
flutter build apk

# CocoaPods specific  
cd ios && rm Podfile.lock && pod install --repo-update && cd ..
```
