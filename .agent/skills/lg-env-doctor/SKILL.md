---
name: lg-env-doctor
description: Diagnose development environment and report tool health
---

# LG Env Doctor

Scans the development environment for all required tools and reports health status.

## Scan Protocol
1. **OS Detection**: macOS, Ubuntu, Windows (via `uname` or equivalent)
2. **Flutter SDK**: `flutter --version`, check PATH
3. **Dart SDK**: `dart --version`
4. **Android SDK**: `ANDROID_HOME` env var, `adb --version`
5. **Git**: `git --version`
6. **Node.js** (optional): `node --version`, `npm --version`
7. **GitHub CLI** (optional): `gh --version`
8. **SSH Client**: `ssh -V`
9. **ADB**: `adb devices`
10. **Emulator**: `emulator -list-avds`

## Health Report Format
```
╔══════════════════════════════════╗
║   LG Environment Health Report   ║
╠══════════════════════════════════╣
║ Flutter    ✅ 3.x.x             ║
║ Dart       ✅ 3.x.x             ║
║ Android    ✅ SDK 34             ║
║ Git        ✅ 2.x.x             ║
║ Node.js    ⚠️  Not found         ║
║ ADB        ✅ Connected          ║
║ Emulator   ✅ Pixel_6_API_34    ║
╚══════════════════════════════════╝
```

## Missing Tool → Handoff
If any required tool is MISSING, hand off to `lg-setup-guide` with OS + tool name.
