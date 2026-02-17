````skill
---
name: lg-env-doctor
description: Detects the user's host OS and scans for all required SDKs, tools, and software. Produces a health report with pass/fail/missing status for every dependency needed to build and run an LG Flutter app.
---

# Environment Doctor

## Overview

This skill is the **first thing that runs** before any pipeline stage. It detects the student's host operating system and systematically checks whether every required tool is installed, accessible on `$PATH`, and at a compatible version. It produces a clear health report and hands off to `lg-setup-guide` for any missing items.

**Announce at start:** "Running Environment Doctor — checking your machine for all required tools..."

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active. If the student wants to skip setup, the advisor intervenes — you cannot build an LG app without the correct toolchain.

## Phase 0: Detect Host OS

Run the appropriate detection command:

```bash
# macOS
sw_vers 2>/dev/null && echo "DETECTED: macOS $(sw_vers -productVersion)"

# Linux (Ubuntu/Debian/Fedora/Arch)
cat /etc/os-release 2>/dev/null | grep -E "^(NAME|VERSION)="

# Windows (WSL or native)
systeminfo 2>/dev/null | head -5 || cat /proc/version 2>/dev/null
```

Record:
- **OS Name**: macOS / Ubuntu / Fedora / Arch / Windows (WSL) / Windows (native)
- **OS Version**: e.g., macOS 15.2, Ubuntu 24.04
- **Architecture**: `uname -m` → arm64 / x86_64

## Phase 1: Required Tool Checklist

Run **all checks in parallel** where possible. For each tool, record: `PASS`, `WARN` (wrong version), or `MISSING`.

### 1.1 Flutter SDK
```bash
flutter --version 2>/dev/null
flutter doctor -v 2>/dev/null
```
- **Required**: >= 3.0.0
- **Check**: `flutter doctor` should show no critical errors
- **Note**: Also verifies Dart SDK (bundled with Flutter)

### 1.2 Dart SDK
```bash
dart --version 2>/dev/null
```
- **Required**: >= 3.0.0 (bundled with Flutter, but verify standalone if needed)

### 1.3 Git
```bash
git --version 2>/dev/null
```
- **Required**: >= 2.0

### 1.4 Java / JDK (for Android builds)
```bash
java -version 2>&1
javac -version 2>&1
echo $JAVA_HOME
```
- **Required**: JDK 17 (recommended for modern Android Gradle)
- **Warn**: JDK 8 or 11 may cause Gradle issues with newer AGP

### 1.5 Android SDK & Tools
```bash
# Check for Android SDK
echo $ANDROID_HOME
echo $ANDROID_SDK_ROOT
# Check for platform-tools
adb --version 2>/dev/null
# Check for build-tools
ls $ANDROID_HOME/build-tools/ 2>/dev/null
# Check for cmdline-tools
sdkmanager --version 2>/dev/null
```
- **Required**: Android SDK with API 33+ platform
- **Required**: Android build-tools
- **Required**: `adb` for device deployment

### 1.6 Android Studio / VS Code
```bash
# Android Studio (provides SDK Manager, AVD Manager)
# macOS:
ls /Applications/Android\ Studio.app 2>/dev/null
# Linux:
which android-studio 2>/dev/null || ls /opt/android-studio/bin/ 2>/dev/null

# VS Code
code --version 2>/dev/null
```
- **Recommended**: Android Studio for SDK management + emulators
- **Alternative**: VS Code with Flutter/Dart extensions

### 1.7 Xcode (macOS only — iOS builds)
```bash
xcode-select -p 2>/dev/null
xcodebuild -version 2>/dev/null
# CocoaPods for iOS dependencies
pod --version 2>/dev/null
```
- **Required only if**: targeting iOS
- **Requires**: Xcode 15+ with iOS 17 SDK

### 1.8 Node.js & npm (for node_server)
```bash
node --version 2>/dev/null
npm --version 2>/dev/null
```
- **Required**: Node.js >= 18 (for the optional Express node_server)
- **Optional**: Only needed if using the node_server/ component

### 1.9 SSH Client
```bash
ssh -V 2>/dev/null
```
- **Required**: OpenSSH client (for manual rig debugging)
- **Note**: The Flutter app uses `dartssh2` (pure Dart), but terminal SSH is essential for debugging

### 1.10 Google Earth Pro (Desktop — for KML testing)
```bash
# macOS
ls /Applications/Google\ Earth\ Pro.app 2>/dev/null
# Linux
which google-earth-pro 2>/dev/null || ls /opt/google/earth/pro/ 2>/dev/null
```
- **Recommended**: For visually testing KML files without a physical rig

### 1.11 Chrome (for Flutter Web debugging)
```bash
# macOS
ls "/Applications/Google Chrome.app" 2>/dev/null
# Linux
which google-chrome 2>/dev/null || which chromium-browser 2>/dev/null
```
- **Optional**: Only for web target development

## Phase 2: Generate Health Report

Produce a clear table:

```
╔══════════════════════╦═════════╦══════════════════════════════╗
║ Tool                 ║ Status  ║ Details                      ║
╠══════════════════════╬═════════╬══════════════════════════════╣
║ Host OS              ║ INFO    ║ macOS 15.2 (arm64)           ║
║ Flutter SDK          ║ PASS    ║ 3.24.0 (stable)              ║
║ Dart SDK             ║ PASS    ║ 3.5.0                        ║
║ Git                  ║ PASS    ║ 2.43.0                       ║
║ Java / JDK           ║ WARN    ║ JDK 11 (need 17)             ║
║ Android SDK          ║ PASS    ║ API 34, build-tools 34.0.0   ║
║ Android Studio       ║ PASS    ║ Hedgehog 2023.1.1            ║
║ Xcode                ║ SKIP    ║ Not targeting iOS             ║
║ Node.js              ║ MISSING ║ Not found on PATH             ║
║ SSH Client           ║ PASS    ║ OpenSSH 9.6                  ║
║ Google Earth Pro     ║ MISSING ║ Not installed                 ║
║ Chrome               ║ PASS    ║ Available                    ║
╚══════════════════════╩═════════╩══════════════════════════════╝

Summary: 8 PASS | 1 WARN | 2 MISSING | 1 SKIP
```

## Phase 3: Decision Gate

| Result | Action |
|--------|--------|
| All PASS | Proceed to pipeline Stage 0 (Shield pre-flight) |
| Any WARN | Show warning, suggest upgrade. Proceed if non-critical. |
| Any MISSING (required) | **BLOCK** — hand off to `lg-setup-guide` for installation guidance |
| Any MISSING (optional) | Note it, proceed. Student can install later. |

## Phase 4: Handoff

- **All clear** → Continue to `lg-shield` (pre-flight) or `lg-init` (Stage 1).
- **Missing required tools** → Hand off to `.agent/skills/lg-setup-guide/SKILL.md` with the list of missing tools and the detected OS.
- **After setup completes** → Hand off to `.agent/skills/lg-resume-pipeline/SKILL.md` to continue from the interrupted stage.

## Quick Run (Single Command)

For fast diagnostics, run this one-liner:

```bash
echo "=== ENV DOCTOR ===" && \
echo "OS: $(uname -s) $(uname -m)" && \
echo "Flutter: $(flutter --version 2>/dev/null | head -1 || echo 'MISSING')" && \
echo "Dart: $(dart --version 2>/dev/null || echo 'MISSING')" && \
echo "Git: $(git --version 2>/dev/null || echo 'MISSING')" && \
echo "Java: $(java -version 2>&1 | head -1 || echo 'MISSING')" && \
echo "ADB: $(adb --version 2>/dev/null | head -1 || echo 'MISSING')" && \
echo "Node: $(node --version 2>/dev/null || echo 'MISSING')" && \
echo "SSH: $(ssh -V 2>&1 || echo 'MISSING')" && \
echo "=== DONE ==="
```

````
