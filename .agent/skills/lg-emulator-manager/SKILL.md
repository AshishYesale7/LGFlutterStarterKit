---
name: lg-emulator-manager
description: Manage emulators for visual testing and demonstration
---

# LG Emulator Manager

Full lifecycle management of Android/iOS emulators for visual testing.

## Phase 1: Device Detection
```bash
# List connected devices
flutter devices
# List available Android emulators
emulator -list-avds
# List iOS simulators (macOS only)
xcrun simctl list devices available
```

## Phase 2: Launch Emulator
```bash
# Android
emulator -avd <avd-name> -no-snapshot-load &
# or via Flutter
flutter emulators --launch <emulator-id>

# iOS (macOS only)
open -a Simulator
xcrun simctl boot <device-id>
```

## Phase 3: Run App on Emulator
```bash
flutter run -d <device-id>
# or for specific emulator
flutter run -d emulator-5554
```

## Phase 4: Screenshots
```bash
# Android
adb exec-out screencap -p > docs/screenshots/screen_$(date +%s).png
# iOS
xcrun simctl io booted screenshot docs/screenshots/screen_$(date +%s).png
```

## Phase 5: Screen Recording
```bash
# Android (max 3 minutes by default)
adb shell screenrecord /sdcard/demo.mp4
adb pull /sdcard/demo.mp4 docs/recordings/demo.mp4

# iOS
xcrun simctl io booted recordVideo docs/recordings/demo.mp4
```

## Phase 6: Visual Debugging
- Flutter DevTools: `flutter run` → press 'd' for DevTools
- Layout Inspector: highlight widget boundaries
- Network Inspector: monitor API calls
- Performance overlay: check for jank

## Phase 7: Automated UI Testing
```bash
# Run integration tests on emulator
flutter test integration_test/app_test.dart -d <device-id>
```
