---
name: lg-flutter-init
description: Flutter-specific project initialization for LG apps
---

# LG Flutter Init

Handles Flutter-specific initialization for Liquid Galaxy projects.

## CRITICAL: Separate Directory Rule

> **NEVER generate a new app inside `LGFlutterStarterKit/`.**
> The starter kit is a READ-ONLY template. All new apps go in a sibling directory.

## Phase 0: Separate Directory Setup

1. Determine the new app name from student
2. Create `../<app-name>/` as a sibling to `LGFlutterStarterKit/`
3. Copy starter kit files as a scaffold
4. Initialize new Git repo
5. See `lg-init` Phase 0 for full details

## Phase 1: Flutter Project Setup
- Create Flutter project with `flutter create --org com.liquidgalaxy <name>`
- Configure `pubspec.yaml`:
  - dartssh2, provider, http, xml
  - shared_preferences, flutter_secure_storage, path_provider
- Set up Material 3 theme
- Configure Android SDK versions (minSdk 21, targetSdk 34)

## Phase 2: Architecture Setup
- Create `config.dart` with LG connection defaults
- Set up `main.dart` with MultiProvider
- Create route table (splash → connection → main → settings → help)

## Phase 3: Base Services
- SSHService with dartssh2
- LGService wrapping SSH for LG commands
- KMLService for KML generation

## Phase 4: Base Screens
Following Lucia's LG Master Web App pattern:
- SplashScreen (2s delay → connection)
- ConnectionScreen (host/port/user/pass fields)
- MainScreen (LG control actions)
- SettingsScreen (connection + theme settings)
- HelpScreen (usage guide + architecture overview)
