# Setup & Configuration

> Prerequisites, installation, build options, rig configuration, and secure credential storage.

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Building for Release](#building-for-release)
- [Rig Configuration](#rig-configuration)
- [Build-Time Overrides (--dart-define)](#build-time-overrides---dart-define)
- [Secure Credential Storage](#secure-credential-storage)
- [Node.js Server Setup](#nodejs-server-setup)
- [Template vs App](#template-vs-app)

---

## Prerequisites

| Tool | Version | Purpose | Install |
|------|---------|---------|---------|
| Flutter SDK | ≥ 3.0.0 | App framework | [flutter.dev/get-started](https://flutter.dev/docs/get-started/install) |
| Dart SDK | ≥ 3.0.0 | Language (bundled with Flutter) | Included in Flutter |
| Git | Any | Version control | `brew install git` / `apt install git` |
| Android Studio | Any | Android SDK + emulator | [developer.android.com](https://developer.android.com/studio) |
| VS Code (optional) | Any | Editor with Flutter extension | [code.visualstudio.com](https://code.visualstudio.com) |
| JDK | 17 | Android builds | `brew install openjdk@17` |
| Node.js | ≥ 18 (optional) | Companion server | [nodejs.org](https://nodejs.org) |

Verify your environment:

```bash
flutter doctor -v
```

All checks should pass (or show only iOS-related warnings on non-macOS systems).

---

## Installation

```bash
# Clone the repository
git clone https://github.com/<your-username>/LGFlutterStarterKit.git
cd LGFlutterStarterKit

# Install Flutter dependencies
cd flutter_client
flutter pub get
```

### Verify Clean Analysis

```bash
dart format --set-exit-if-changed .
flutter analyze --no-fatal-infos
```

Both commands should exit with code 0 (zero warnings, zero errors).

---

## Running the App

### Standard Start

```bash
cd flutter_client
flutter run
```

The app launches with:
1. **Splash Screen** — 2-second branding display
2. **Connection Screen** — Enter rig IP, port, username, password
3. Click **"Connect"** to establish SSH connection, or **"Skip (Demo Mode)"** to explore the UI without a rig

### With Emulator

```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

---

## Building for Release

### Debug APK

```bash
flutter build apk --debug
```

Output: `build/app/outputs/flutter-apk/app-debug.apk`

### Release APK (Contest Submission)

```bash
flutter build apk --release --split-per-abi
```

Output: `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` (and arm64, x86_64)

### Release with Custom Config

```bash
flutter build apk --release --split-per-abi \
  --dart-define=LG_HOST=10.0.0.5 \
  --dart-define=LG_PORT=22 \
  --dart-define=LG_USER=myuser \
  --dart-define=LG_PASSWORD=mypass
```

---

## Rig Configuration

All connection and rig constants are centralized in `flutter_client/lib/config.dart`:

```dart
class Config {
  // Connection (overrideable via --dart-define)
  static const String lgHost     = String.fromEnvironment('LG_HOST', defaultValue: '192.168.56.101');
  static const int    lgPort     = int.fromEnvironment('LG_PORT', defaultValue: 22);
  static const String lgUser     = String.fromEnvironment('LG_USER', defaultValue: 'lg');
  static const String lgPassword = String.fromEnvironment('LG_PASSWORD', defaultValue: 'lg');

  // Rig geometry
  static const int totalScreens  = 3;        // 3, 5, or 7
  static const int masterScreen  = 1;
  static int get leftScreen      => totalScreens;  // Logo screen
  static int get rightScreen     => 2;

  // Home city (Task 2: Fly to Home City)
  static const double homeCityLat  = 41.6176;   // Lleida, Spain
  static const double homeCityLng  = 0.6200;
  static const String homeCityName = 'Lleida';

  // App metadata
  static const String appName    = 'LG Flutter Starter Kit';
  static const String appVersion = '1.0.0';

  // Server
  static const String serverUrl = 'http://localhost:3000';

  // Timeouts
  static const int connectionTimeout  = 10;  // seconds
  static const int kmlRefreshInterval = 2;   // seconds
}
```

### Customizing for Your Rig

1. **Change the IP:** Update `defaultValue` in `lgHost` or use `--dart-define=LG_HOST=your.ip`
2. **Change screen count:** Set `totalScreens` to `5` or `7` — logo placement and slave numbering adapt automatically
3. **Change home city:** Update `homeCityLat`, `homeCityLng`, and `homeCityName` to your city's coordinates

---

## Build-Time Overrides (--dart-define)

All four connection parameters support compile-time overrides via `--dart-define`. This allows building APKs for different rigs without modifying any source code.

| Flag | Config Field | Default |
|------|-------------|---------|
| `--dart-define=LG_HOST=x` | `Config.lgHost` | `192.168.56.101` |
| `--dart-define=LG_PORT=x` | `Config.lgPort` | `22` |
| `--dart-define=LG_USER=x` | `Config.lgUser` | `lg` |
| `--dart-define=LG_PASSWORD=x` | `Config.lgPassword` | `lg` |

### How It Works

`Config` uses `String.fromEnvironment()` and `int.fromEnvironment()` which are resolved **at compile time** by the Dart compiler:

```dart
static const String lgHost = String.fromEnvironment('LG_HOST', defaultValue: '192.168.56.101');
```

If `--dart-define=LG_HOST=10.0.0.5` is passed during build, `lgHost` becomes `'10.0.0.5'`. Otherwise, it uses the default.

### CI/CD Integration

The `flutter-build.yml` workflow accepts a `lg_host` input and passes it to the build:

```yaml
- run: flutter build apk --debug --dart-define=LG_HOST=${{ inputs.lg_host }}
```

---

## Secure Credential Storage

### Split Storage Strategy

| Data | Storage Backend | Encrypted? | Access |
|------|----------------|------------|--------|
| Host IP | `SharedPreferences` | No | `settings.host` |
| Port | `SharedPreferences` | No | `settings.port` |
| Screen Count | `SharedPreferences` | No | `settings.totalScreens` |
| Username | `FlutterSecureStorage` | **Yes** (AES-256) | `settings.username` |
| Password | `FlutterSecureStorage` | **Yes** (AES-256) | `settings.password` |
| Theme Mode | `SharedPreferences` | No | `themeProvider.themeMode` |

### How Credentials Are Managed

1. **On app start:** `SettingsProvider._loadSettings()` reads credentials from secure storage
2. **Connection Screen** pre-fills text fields with stored values
3. **On connect:** `SettingsProvider.updateSettings()` saves credentials before `LGService.connect()`
4. **On reset:** `SettingsProvider.resetToDefaults()` clears both secure and shared storage

### Encryption Details

- **Android:** AES-256 with keys stored in the Android Keystore
- **iOS:** Values stored in the iOS Keychain
- **Package:** `flutter_secure_storage ^9.0.0`

### Security Rules

- Passwords and API keys **must** use `FlutterSecureStorage` — never `SharedPreferences`
- The `lg-shield` agent skill scans for violations of this rule
- No secrets should appear in source code, config files, or version control

---

## Node.js Server Setup

The companion server is **optional** — the Flutter app works independently via SSH.

```bash
cd server
npm install
npm start
```

**Default port:** `3000` (configurable via `PORT` environment variable)

```bash
# Custom port
PORT=8080 npm start

# Development mode (auto-reload)
npm run dev
```

**Verify:** `curl http://localhost:3000/health`

---

## Template vs App

This repository is a **template** — it intentionally does **not** contain platform-specific directories.

| Directory | In Template? | Generated When? |
|-----------|-------------|----------------|
| `android/` | ❌ No | `flutter create .` in demo app |
| `ios/` | ❌ No | `flutter create .` in demo app |
| `web/` | ❌ No | `flutter create .` in demo app |
| `linux/` | ❌ No | `flutter create .` in demo app |
| `macos/` | ❌ No | `flutter create .` in demo app |
| `windows/` | ❌ No | `flutter create .` in demo app |
| `test/` | ❌ No | `flutter create .` in demo app |

The Antigravity `lg-init` skill generates a new app from this template and runs `flutter create .` to produce platform directories. **Do not** run `flutter create` in this repository.
