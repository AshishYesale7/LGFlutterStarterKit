# Test iOS Emulator Workflow

Guide for testing LG Flutter apps on iOS Simulator (macOS only).

## Prerequisites
- macOS with Xcode installed
- Xcode Command Line Tools: `xcode-select --install`
- CocoaPods: `sudo gem install cocoapods`

## Setup
1. Open Xcode → Preferences → Platforms → Install iOS Simulator
2. List available simulators: `xcrun simctl list devices available`
3. Boot a simulator: `open -a Simulator`

## Running the App
```bash
cd flutter_client
flutter pub get
cd ios && pod install && cd ..
flutter run -d <simulator-id>
```

## Testing
1. Verify all screens render correctly on iOS
2. Check iOS-specific UI differences (navigation, safe area)
3. Test connection flow (will work with VM/Docker mock)
4. Verify KML generation (KML is platform-agnostic)

## Screenshots
```bash
xcrun simctl io booted screenshot ios_screenshot.png
```

## Screen Recording
```bash
xcrun simctl io booted recordVideo ios_demo.mp4
# Press Ctrl+C to stop recording
```

## Common iOS Issues
| Issue | Fix |
|-------|-----|
| Pod install fails | `cd ios && rm Podfile.lock && pod install --repo-update` |
| Signing error | Set team in Xcode → Runner → Signing & Capabilities |
| Simulator not found | `xcrun simctl list` to find correct ID |
