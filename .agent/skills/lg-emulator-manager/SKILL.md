---
name: lg-emulator-manager
description: Full lifecycle management of Android/iOS emulators for visual testing, debugging, and capturing demo evidence for contest submission.
---

# LG Emulator Manager

Manages emulators for **visual testing** and **evidence capture** during the pipeline. Used by `lg-exec` (between batches), `lg-demo-recorder` (capturing screenshots/recordings), and `lg-tester` (integration tests).

**Announce:** "Emulator Manager activated. Let me set up a device for visual testing."

## Phase 1: Device Detection
```bash
# List connected devices (physical + emulators)
flutter devices

# List available Android emulators
emulator -list-avds

# iOS simulators (macOS only)
xcrun simctl list devices available
```

## Phase 2: Launch Emulator
```bash
# Android — launch specific AVD
emulator -avd <avd-name> -no-snapshot-load &

# Android — via Flutter (picks first available)
flutter emulators --launch <emulator-id>

# iOS Simulator (macOS only)
open -a Simulator
xcrun simctl boot <device-id>
```

**If no emulator exists**, create one:
```bash
# Create Android emulator (requires Android SDK)
avdmanager create avd -n "LG_Test_Device" -k "system-images;android-34;google_apis;arm64-v8a" --device "pixel_6"
```

## Phase 3: Run App on Emulator
```bash
# Run in debug mode (hot reload enabled)
cd flutter_client && flutter run -d <device-id>

# Run in release mode (for demo evidence)
flutter run --release -d <device-id>
```

## Phase 4: Screenshots for Documentation
```bash
# Android
adb exec-out screencap -p > docs/screenshots/screen_$(date +%s).png

# iOS
xcrun simctl io booted screenshot docs/screenshots/screen_$(date +%s).png
```

### Task 2 Required Screenshots
Capture each of these for the contest submission:
```bash
mkdir -p docs/screenshots
# Navigate to each screen and capture:
adb exec-out screencap -p > docs/screenshots/splash.png
adb exec-out screencap -p > docs/screenshots/connection.png
adb exec-out screencap -p > docs/screenshots/home_dashboard.png
adb exec-out screencap -p > docs/screenshots/settings.png
adb exec-out screencap -p > docs/screenshots/help.png
```

## Phase 5: Screen Recording
```bash
# Android (max 3 minutes by default)
adb shell screenrecord --time-limit 60 /sdcard/demo.mp4
adb pull /sdcard/demo.mp4 docs/recordings/demo.mp4
adb shell rm /sdcard/demo.mp4

# iOS
xcrun simctl io booted recordVideo docs/recordings/demo.mp4
```

## Phase 6: Visual Debugging
- Flutter DevTools: `flutter run` → press 'd' for DevTools URL
- Layout Inspector: highlight widget boundaries
- Network Inspector: monitor API calls
- Performance overlay: check for jank (`flutter run --profile`)

## Phase 7: Automated UI Testing
```bash
# Run integration tests on emulator
flutter test integration_test/app_test.dart -d <device-id>
```

## Handoff
- **Screenshots captured** → return to `lg-exec` or `lg-demo-recorder`
- **Visual issue found** → `lg-debugger` for troubleshooting
- **App won't run** → `lg-dependency-resolver` for build errors
