---
name: Test iOS Emulator
description: Workflow to test the Flutter LG controller app on iOS Simulator for cross-platform validation.
---

# Test iOS Emulator Workflow

> **Context**: Gemini Summer of Code 2026 — iOS is NOT required for the LG rig (which runs Linux/Android), but cross-platform testing demonstrates robust Flutter architecture.

## Related Skills
- **lg-emulator-manager** (.agent/skills/lg-emulator-manager/SKILL.md) — emulator/simulator management
- **lg-debugger** (.agent/skills/lg-debugger/SKILL.md) — diagnosing platform-specific issues
- **lg-flutter-build** (.agent/skills/lg-flutter-build/SKILL.md) — building for iOS

## Prerequisites
- macOS with Xcode installed
- iOS Simulator available: `open -a Simulator`
- Flutter iOS support: `flutter doctor` shows iOS toolchain

## Steps

### 1. Configure iOS Permissions
Ensure `ios/Runner/Info.plist` includes network permissions:
```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```

### 2. Install Dependencies
```bash
cd flutter_client
flutter pub get
cd ios && pod install && cd ..
```

### 3. Run on Simulator
```bash
# List available simulators
flutter devices

# Run on iOS Simulator
flutter run -d "iPhone 15 Pro"
```

### 4. Verify Functionality
- [ ] App launches without crash
- [ ] SSH connection works (HTTP/SSH networking)
- [ ] UI renders correctly on iOS form factor
- [ ] KML generation works
- [ ] Navigation and gestures work properly

### 5. Build (Optional)
```bash
flutter build ios --release --no-codesign
```

## Notes
- iOS builds are NOT required for LG rig testing (LG runs Linux)
- iOS testing demonstrates cross-platform capability of the Flutter codebase
- The primary deliverable is the **Android APK** (see **lg-flutter-build**)
- For contest submission evidence, use **lg-demo-recorder** (.agent/skills/lg-demo-recorder/SKILL.md)
