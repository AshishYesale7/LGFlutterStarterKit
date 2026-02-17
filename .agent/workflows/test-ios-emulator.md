---
name: Test iOS Emulator
description: Workflow to test the Flutter LG controller app on iOS Simulator for cross-platform validation.
---

# Test iOS Emulator Workflow

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
- The primary deliverable is the Android APK
