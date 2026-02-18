# Architecture Map

## System Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        FLUTTER APP                              │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  PRESENTATION LAYER                                       │  │
│  │  screens/  widgets/                                       │  │
│  │  ❌ Cannot import: dartssh2, http, kml_service            │  │
│  └──────────────────┬───────────────────────────────────────┘  │
│                     │ calls                                     │
│  ┌──────────────────▼───────────────────────────────────────┐  │
│  │  ORCHESTRATION LAYER                                      │  │
│  │  services/lg_service.dart                                 │  │
│  │  Facade: sendLogo(), sendPyramid(), flyToHomeCity(),      │  │
│  │          cleanLogos(), cleanKMLs(), orbit()               │  │
│  └──────┬───────────────────────────────────┬───────────────┘  │
│         │ generates                         │ executes          │
│  ┌──────▼───────────────────┐  ┌───────────▼────────────────┐  │
│  │  KML GENERATION LAYER    │  │  TRANSPORT LAYER            │  │
│  │  services/kml_service    │  │  services/ssh_service       │  │
│  │  Pure functions, no I/O  │  │  dartssh2 SSH + SFTP        │  │
│  │  ❌ Cannot import: ssh   │  │  ❌ Cannot import: kml      │  │
│  └──────────────────────────┘  └───────────┬────────────────┘  │
│                                             │ SSH (port 22)     │
└─────────────────────────────────────────────┼───────────────────┘
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
                         │  /var/www/html/kml_slave_N.kml (slaves)│
                         └─────────────────────────────────────────┘
```

## 5-Layer Import Matrix

| Layer | Files | Can Import | Cannot Import |
|-------|-------|-----------|---------------|
| **Presentation** | `screens/`, `widgets/` | `lg_service`, `providers`, `models`, `config` | `dartssh2`, `http`, `kml_service`, `ssh_service` |
| **Orchestration** | `services/lg_service.dart` | `kml_service`, `ssh_service`, `config`, `models` | `dartssh2` directly |
| **Data Providers** | `providers/`, `*_service.dart` | `http`, `models`, `config` | `dartssh2`, `ssh_service` |
| **KML Generation** | `services/kml_service.dart` | `dart:core` only (pure functions) | `dartssh2`, `ssh_service`, `http` |
| **Transport** | `services/ssh_service.dart` | `dartssh2`, `config` | `kml_service`, `models` |

## Data Flow (One Direction)

```
User Tap → Screen → LGService.sendPyramid()
                        │
                        ├─► KMLService.generatePyramid() → KML string
                        │
                        └─► SSHService.uploadKML(kml, 'pyramid.kml')
                                │
                                └─► SSH → LG Master → Google Earth renders
                                         on all screens simultaneously
```

## State Management

```
MultiProvider
  ├── SettingsProvider    (SharedPreferences + flutter_secure_storage)
  │     └── host, port, username, totalScreens
  ├── ThemeProvider       (SharedPreferences)
  │     └── themeMode (system/light/dark)
  └── LGService          (ChangeNotifier)
        └── isConnected, SSHService, KMLService
```

## File Map

```
flutter_client/lib/
├── config.dart                    # Rig defaults, home city, screen geometry
├── main.dart                      # MultiProvider setup, routes
├── models/
│   ├── connection_status.dart     # ConnectionStatus enum
│   └── flow_node.dart             # Workflow visualizer data
├── providers/
│   ├── settings_provider.dart     # Persistent rig settings
│   └── theme_provider.dart        # Theme mode persistence
├── screens/
│   ├── splash_screen.dart         # Branding, auto-navigate
│   ├── connection_screen.dart     # Credentials input, connect/skip
│   ├── main_screen.dart           # 5 core actions + extras
│   ├── settings_screen.dart       # Rig config, theme toggle
│   ├── help_screen.dart           # Instructions, architecture overview
│   └── workflow_flow_screen.dart  # Interactive pipeline visualizer
├── services/
│   ├── lg_service.dart            # Orchestration facade (5 core ops)
│   ├── kml_service.dart           # Pure KML XML generation
│   ├── ssh_service.dart           # SSH connection + SFTP upload
│   ├── socket_service.dart        # WebSocket to Node.js server
│   └── earthquake_service.dart    # Example API integration
└── widgets/
    ├── flow_node_card.dart        # Workflow node UI
    └── flow_edge_painter.dart     # Workflow edge painter
```

## 5 Core Task 2 Operations

| # | Operation | Service Method | KML Element | Target |
|---|-----------|---------------|-------------|--------|
| 1 | **Send Logo** | `lgService.sendLogo()` | `<ScreenOverlay>` | Left slave screen |
| 2 | **Send Pyramid** | `lgService.sendPyramid()` | `<Polygon>` extruded | Master screen |
| 3 | **Fly to Home City** | `lgService.flyToHomeCity()` | `<LookAt>` via query.txt | Master camera |
| 4 | **Clean Logos** | `lgService.cleanLogos()` | Empty KML | All slave screens |
| 5 | **Clean KMLs** | `lgService.cleanKMLs()` | Empty KML + query | All screens |

## Communication Protocol

**App → Rig** (SSH over port 22):
- **Camera control**: `echo "flytoview=<LookAt>..." > /tmp/query.txt`
- **KML upload**: SFTP to `/var/www/html/` (with echo fallback)
- **KML registry**: `echo "http://localhost/file.kml" >> /var/www/html/kmls.txt`
- **Slave overlays**: Write to `/var/www/html/kml_slave_N.kml`

**Rig internal** (Google Earth handles automatically):
- Master reads `/tmp/query.txt` for camera commands
- All screens poll KML files and render synchronized views
- No code runs on the rig — you send data, GE does the rest
