# Changelog

All notable changes to the LG Flutter Starter Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-02-18

### Added
- `sendPyramid()` — 3D extruded polygon KML generation and upload to rig
- `flyToHomeCity()` — fly camera to configured home city coordinates
- `cleanLogos()` — remove logo overlays from all slave screens
- `cleanKMLs()` — clear all KML files and queries from the rig
- `generatePyramid()` in KMLService — 4-sided pyramid with 5 faces (4 sides + base)
- `generateFlyTo()` in KMLService — reusable LookAt KML string builder
- `generateEmptyKml()` in KMLService — empty document for cleaning
- Home city configuration (`homeCityLat`, `homeCityLng`, `homeCityName`) in Config
- `flutter_secure_storage` integration for credential persistence
- `CONTRIBUTING.md` with architecture rules and PR checklist
- `docs/architecture-map.md` with full system diagram and import matrix
- LGService registered in MultiProvider (was missing)

### Changed
- Renamed `showLogo()` → `sendLogo()` to match documented API
- Renamed `cleanLogo()` → split into `cleanLogos()` + `cleanKMLs()` (separate concerns)
- `flyTo()` now delegates KML generation to `KMLService.generateFlyTo()` (proper layering)
- MainScreen now shows all 5 core Task 2 operations as primary actions
- SettingsProvider uses `flutter_secure_storage` for username/password (sensitive data)
- ConnectionScreen loads and persists credentials via secure storage

### Fixed
- LGService was not provided via MultiProvider — screens using `context.watch<LGService>()` would crash

## [1.0.0] - 2026-02-17

### Added
- Initial release of LG Flutter Starter Kit
- 5-layer enforced architecture (Presentation → Orchestration → Providers → KML → Transport)
- SSHService with dartssh2 for rig communication
- KMLService for placemark, overlay, line, and orbit generation
- LGService facade for high-level rig operations
- 6 screens: Splash, Connection, Main, Settings, Help, Workflow Flow
- Provider state management with SettingsProvider and ThemeProvider
- Material 3 UI with light/dark theme support
- Node.js companion server (Express + WebSocket)
- 3 GitHub Actions workflows (CI, Build, Security)
- Antigravity AI mentor system (33 skills, 5 rules, 4 workflows)
