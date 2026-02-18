# Architecture

> Complete architectural reference for the LG Flutter Starter Kit.

---

## Table of Contents

- [System Overview](#system-overview)
- [App → Rig Communication](#app--rig-communication)
- [5-Layer Architecture](#5-layer-architecture)
- [Import Matrix](#import-matrix)
- [Data Flow](#data-flow)
- [State Management](#state-management)
- [Screen Mapping](#screen-mapping)
- [Communication Protocol](#communication-protocol)
- [Design Principles](#design-principles)

---

## System Overview

```
┌───────────────────────────────────────────────────────────────────┐
│                         FLUTTER APP                               │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │  PRESENTATION    screens/  widgets/                         │  │
│  │  ❌ Cannot import: dartssh2, http, kml_service              │  │
│  └───────────────────────┬────────────────────────────────────┘  │
│                          │ calls                                  │
│  ┌───────────────────────▼────────────────────────────────────┐  │
│  │  ORCHESTRATION   services/lg_service.dart                   │  │
│  │  Facade: sendLogo(), sendPyramid(), flyToHomeCity(),        │  │
│  │          cleanLogos(), cleanKMLs(), sendOrbit()             │  │
│  └────────┬──────────────────────────────────┬────────────────┘  │
│           │ generates                        │ executes           │
│  ┌────────▼──────────────────┐  ┌────────────▼────────────────┐  │
│  │  KML GENERATION           │  │  TRANSPORT                  │  │
│  │  services/kml_service     │  │  services/ssh_service       │  │
│  │  Pure functions, no I/O   │  │  dartssh2, SFTP             │  │
│  │  ❌ Cannot import: ssh    │  │  ❌ Cannot import: kml      │  │
│  └───────────────────────────┘  └────────────┬────────────────┘  │
│                                              │ SSH (port 22)      │
└──────────────────────────────────────────────┼────────────────────┘
                                               │
                          ┌────────────────────▼────────────────────┐
                          │           LIQUID GALAXY RIG             │
                          │                                         │
                          │  ┌─────────┐ ┌─────────┐ ┌─────────┐  │
                          │  │Screen 3 │ │Screen 1 │ │Screen 2 │  │
                          │  │ (Left)  │ │(Master) │ │ (Right) │  │
                          │  │  Logo◄  │ │ Center  │ │         │  │
                          │  └─────────┘ └─────────┘ └─────────┘  │
                          │                                         │
                          │  /var/www/html/kmls.txt  (KML registry)│
                          │  /tmp/query.txt          (camera cmds) │
                          └─────────────────────────────────────────┘
```

**The core concept:** Your Flutter app sends KML data and camera commands to the LG rig over SSH. Google Earth on the rig handles all multi-screen rendering. No code runs on the rig itself.

---

## App → Rig Communication

```
User taps "FlyTo" in the app
  → Screen dispatches action to LGService (facade)
  → LGService calls KMLService.generateFlyTo(lat, lon, alt)
  → KMLService returns a KML XML string (pure, no side effects)
  → LGService calls SSHService.execute("echo '$kml' > /tmp/query.txt")
  → SSH sends command to LG Master at 192.168.56.101:22
  → Google Earth reads /tmp/query.txt and flies the camera
  → All 3+ screens update simultaneously (Google Earth handles sync)
```

**This is the fundamental pattern.** Every operation in the app follows this flow — screens call LGService, which generates KML and sends it via SSH. Screens never touch SSH or KML directly.

---

## 5-Layer Architecture

The codebase is organized into 5 strict layers. Each layer has explicit rules about what it can and cannot import.

### Layer 1 — Presentation

**Files:** `screens/`, `widgets/`

- Contains all UI code (Flutter widgets, screens, painters)
- Calls `LGService` methods via `Provider.of<LGService>(context)`
- **Can import:** `lg_service`, `providers`, `models`, `config`
- **Cannot import:** `dartssh2`, `http`, `kml_service`, `ssh_service`

### Layer 2 — Orchestration

**Files:** `services/lg_service.dart`

- The **facade** that coordinates KML generation and SSH execution
- Single entry point for all LG operations
- **Can import:** `kml_service`, `ssh_service`, `config`, `models`
- **Cannot import:** `dartssh2` directly (only through `SSHService`)

### Layer 3 — Data Providers

**Files:** `providers/`, `services/earthquake_service.dart`, `services/socket_service.dart`

- State management and external API integration
- **Can import:** `http`, `models`, `config`
- **Cannot import:** `dartssh2`, `ssh_service`

### Layer 4 — KML Generation

**Files:** `services/kml_service.dart`

- **Pure functions only** — no I/O, no state, no side effects
- Takes parameters, returns KML XML strings
- Fully testable in isolation
- **Can import:** `dart:core` only
- **Cannot import:** `dartssh2`, `ssh_service`, `http`

### Layer 5 — Transport

**Files:** `services/ssh_service.dart`

- Owns the SSH connection lifecycle
- Handles SFTP uploads and command execution
- **Can import:** `dartssh2`, `config`
- **Cannot import:** `kml_service`, `models`

---

## Import Matrix

| Layer | Files | Can Import | Cannot Import |
|-------|-------|-----------|---------------|
| **Presentation** | `screens/`, `widgets/` | `lg_service`, `providers`, `models`, `config` | `dartssh2`, `http`, `kml_service`, `ssh_service` |
| **Orchestration** | `lg_service.dart` | `kml_service`, `ssh_service`, `config`, `models` | `dartssh2` directly |
| **Data Providers** | `providers/`, API services | `http`, `models`, `config` | `dartssh2`, `ssh_service` |
| **KML Generation** | `kml_service.dart` | `dart:core` only | Everything else |
| **Transport** | `ssh_service.dart` | `dartssh2`, `config` | `kml_service`, `models` |

These boundaries are enforced by:
1. The agent's `layer-boundaries.md` rule
2. The `lg-shield` security skill (pre-flight and post-flight scans)
3. The `lg-code-reviewer` skill during code review

---

## Data Flow

Data flows in **one direction** — from user action to rig display:

```
┌─────────┐    ┌───────────┐    ┌────────────┐    ┌────────────┐    ┌────────┐
│  User   │───►│  Screen   │───►│ LGService  │───►│ KMLService │    │        │
│  Tap    │    │ (Layer 1) │    │ (Layer 2)  │    │ (Layer 4)  │    │   LG   │
└─────────┘    └───────────┘    │            │◄───│ KML string │    │  Rig   │
                                │            │    └────────────┘    │        │
                                │            │───►┌────────────┐───►│        │
                                │            │    │ SSHService │    │        │
                                └────────────┘    │ (Layer 5)  │    │        │
                                                  └────────────┘    └────────┘
```

### Example: Sending a 3D Pyramid

1. User taps "Send Pyramid" on `MainScreen`
2. Screen calls `lgService.sendPyramid()`
3. `LGService` generates KML via `_kmlService.generatePyramid(lat, lon, height)`
4. `LGService` uploads via `_sshService.uploadKML(kml, 'pyramid.kml')`
5. SSH writes file to `/var/www/html/pyramid.kml` on the rig
6. `LGService` registers in `kmls.txt` via SSH echo command
7. Google Earth picks up the KML and renders the pyramid

### Example: Flying to Home City

1. User taps "Fly to Home City" on `MainScreen`
2. Screen calls `lgService.flyToHomeCity()`
3. `LGService` generates `<LookAt>` via `_kmlService.generateFlyTo(lat, lon, ...)`
4. `LGService` writes to `/tmp/query.txt` via SSH echo
5. Google Earth reads the query and animates the camera flight

---

## State Management

```
MultiProvider (main.dart)
  │
  ├── SettingsProvider (ChangeNotifier)
  │     ├── host: String         (SharedPreferences)
  │     ├── port: int            (SharedPreferences)
  │     ├── totalScreens: int    (SharedPreferences)
  │     ├── username: String     (FlutterSecureStorage — encrypted)
  │     └── password: String     (FlutterSecureStorage — encrypted)
  │
  ├── ThemeProvider (ChangeNotifier)
  │     └── themeMode: ThemeMode (SharedPreferences)
  │
  └── LGService (ChangeNotifier)
        ├── isConnected: bool
        ├── _sshService: SSHService
        └── _kmlService: KMLService
```

### Storage Strategy

| Data Type | Storage | Encryption |
|-----------|---------|------------|
| Host, Port, Screen Count | `SharedPreferences` | None (non-sensitive) |
| Theme Preference | `SharedPreferences` | None (non-sensitive) |
| Username | `FlutterSecureStorage` | AES-256 (Android Keystore) |
| Password | `FlutterSecureStorage` | AES-256 (Android Keystore / iOS Keychain) |

---

## Screen Mapping

### 3-Screen Rig (Default)

```
┌──────────┐  ┌──────────┐  ┌──────────┐
│ Screen 3 │  │ Screen 1 │  │ Screen 2 │
│  (Left)  │  │ (Master) │  │  (Right) │
│  Logo ◄  │  │  Center  │  │          │
└──────────┘  └──────────┘  └──────────┘
```

| Screen | Role | Control |
|--------|------|---------|
| **Screen 1** (Master) | Primary Google Earth display | Camera via `/tmp/query.txt` |
| **Screen 3** (Left) | Logo overlay | KML via `logo_slave_3.kml` |
| **Screen 2** (Right) | Additional overlays | KML via `kml_slave_2.kml` |

### Numbering Formula

```dart
leftScreen  = totalScreens  // Always the last screen
rightScreen = 2             // Always screen 2
masterScreen = 1            // Always screen 1
```

This formula adapts automatically to 5-screen and 7-screen rigs via `Config.totalScreens`.

---

## Communication Protocol

| Operation | Method | Target on Rig |
|-----------|--------|--------------|
| **Camera control** | `echo "flytoview=<LookAt>..." > /tmp/query.txt` | Google Earth camera |
| **Search** | `echo "search=query" > /tmp/query.txt` | Google Earth search |
| **KML upload** | SFTP to `/var/www/html/filename.kml` | Google Earth data |
| **KML registry** | `echo "http://localhost/file.kml" >> /var/www/html/kmls.txt` | KML loader |
| **Slave overlay** | SFTP to `/var/www/html/logo_slave_N.kml` | Slave screen overlay |
| **Clean** | Write empty KML to all slave files + clear `query.txt` + clear `kmls.txt` | All screens |
| **Reboot** | `sshpass -p lgPassword ssh lg@lgHost "sudo reboot"` per machine | All rig machines |
| **Shutdown** | `sshpass -p lgPassword ssh lg@lgHost "sudo poweroff"` per machine | All rig machines |

---

## Design Principles

| Principle | Implementation |
|-----------|---------------|
| **Single Responsibility** | Each service has one job: `KMLService` generates XML, `SSHService` transports, `LGService` orchestrates |
| **Open/Closed** | `Config` supports `--dart-define` overrides; `KMLService` methods can be extended without modifying existing ones |
| **Dependency Inversion** | Screens depend on `LGService` abstraction, not on `dartssh2` or KML internals |
| **Facade Pattern** | `LGService` hides the complexity of KML generation + SSH transport behind simple method calls |
| **Pure Functions** | `KMLService` has zero side effects — takes parameters, returns strings. Fully testable. |
| **Resource Lifecycle** | `dispose()` on `LGService` and `SSHService` ensures SSH connections are properly closed |
| **Error Propagation** | `SSHService.execute()` throws `StateError` on failure — no silent error swallowing |
| **Secure by Default** | Passwords use encrypted storage; no plaintext secrets in code or SharedPreferences |
