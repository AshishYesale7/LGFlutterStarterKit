# Liquid Galaxy Architecture Rules

## LG Rig Model
- A Liquid Galaxy rig consists of 3, 5, or 7 identical Linux machines running Google Earth.
- Screen numbering: Master is always screen 1 (center). Other screens wrap around.
- For a 3-screen rig: Screen 3 (left) | Screen 1 (center/master) | Screen 2 (right).
- All screens form a unified panoramic display controlled by Google Earth.

## Communication Architecture
```
Flutter App (smartphone/tablet)
    |
    v  SSH (port 22)
LG Master (screen 1)
    |
    +-- /var/www/html/kml/slave_0.kml  -> Master KML overlay (center)
    +-- /var/www/html/kml/slave_2.kml  -> Right screen
    +-- /var/www/html/kml/slave_3.kml  -> Left screen (logo goes here)
    +-- /tmp/query.txt                  -> Camera control (flyto, tour)
```

**KEY CONCEPT**: The Flutter app runs on the user's phone as a remote control.
Google Earth on the rig handles all multi-screen rendering automatically.

## App Naming Convention

**All apps MUST follow the `LG-<TaskName>` naming convention:**
- `LG-Task2-Demo` — Contest Task 2 basic deliverable
- `LG-Earthquake-Viz` — Earthquake data visualizer
- `LG-Satellite-Tracker` — Real-time satellite tracking
- Flutter package name = snake_case: `lg_task2_demo`

## Reference Implementation

**Lucia's LG Master Web App** is the canonical reference for LG Flutter apps:
- Repository: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- README: https://raw.githubusercontent.com/LiquidGalaxyLAB/LG-Master-Web-App/refs/heads/FlutterNodejs/README.md
- Architecture: Flutter client + Node.js server, communicates with LG rig via SSH
- Key files to study: `lg_service.dart`, `kml_service.dart`, `ssh_service.dart`

### Lucia's Mandatory Screens
All LG Flutter apps should include these screens (from Lucia's reference):

| Screen | Purpose | Required? |
|--------|---------|-----------|
| **Splash Screen** | App branding on startup | Yes |
| **Connection Screen** | LG rig IP/port/credentials input | Yes |
| **Main/Home Screen** | Primary controller dashboard | Yes |
| **Settings Screen** | Rig config, screen count, defaults | Yes |
| **Help/About Screen** | App info, usage instructions | Yes |

## Flutter App Architecture (Task 2 Reference)
```
lib/
+-- main.dart                 # Entry point, Provider registration
+-- config.dart               # LG rig IP, home city, pyramid config, logo URL
+-- screens/
|   +-- splash_screen.dart    # App branding splash
|   +-- connection_screen.dart # LG rig connection input
|   +-- home_screen.dart      # Task 2 dashboard: action cards + connection status
|   +-- settings_screen.dart  # Rig configuration
|   +-- help_screen.dart      # Usage instructions
+-- services/
|   +-- lg_service.dart       # HIGH-LEVEL facade: sendLogo(), sendPyramid(), flyToHomeCity()
|   +-- ssh_service.dart      # LOW-LEVEL SSH: connects to rig, writes KML files
|   +-- kml_service.dart      # KML generator: pyramid, logo overlay, placemarks
+-- providers/                # External API contracts (for advanced apps)
+-- models/                   # Domain models (for advanced apps)
+-- widgets/                  # Reusable UI components
```

## Task 2 Requirements (Contest Minimum)

The basic Task 2 deliverable must implement these 5 LG operations:

| # | Operation | Service Method | What Happens |
|---|-----------|---------------|--------------|
| 1 | **Send Logo** | `lgService.sendLogo()` | ScreenOverlay KML to left slave screen |
| 2 | **Send 3D Pyramid** | `lgService.sendPyramid()` | Colored 3D extruded polygon KML to master |
| 3 | **FlyTo Home City** | `lgService.flyToHomeCity()` | Camera flies to student's city coordinates |
| 4 | **Clean Logos** | `lgService.cleanLogos()` | Clear ScreenOverlay from slave screens |
| 5 | **Clean KMLs** | `lgService.cleanKMLs()` | Clear all KML files from rig |

Plus: Build a **release APK** via `flutter build apk --release`.

## Service Layer Rules
1. **LGService** is the FACADE -- UI should mostly use this, not SSH/KML directly.
2. **SSHService** handles raw SSH commands only. No KML generation logic.
3. **KMLService** generates KML strings only. No network or SSH calls.
4. **API services** fetch data and return models. No KML or SSH logic.
5. Each service is a `ChangeNotifier` registered in `MultiProvider`.
6. Services expose state via getters and notify via `notifyListeners()`.

## Connection Lifecycle
1. User enters LG master IP/port/user/password in ConnectionScreen.
2. SSHService.connect() establishes an SSH tunnel.
3. LGService uses SSH to send KML and camera commands.
4. On disconnect, clean up KML overlays before closing the SSH tunnel.

## File Paths on LG Rig
| Path | Purpose |
|---|---|
| `/var/www/html/kml/slave_0.kml` | Master screen KML overlay |
| `/var/www/html/kml/slave_<N>.kml` | Slave N KML overlay |
| `/tmp/query.txt` | Camera control (flytoview, playtour, exittour) |
| `/opt/google/earth/pro/` | Google Earth Pro installation |

## LG Official Resources
| Resource | URL |
|----------|-----|
| LG Master Web App (Lucia) | https://github.com/LiquidGalaxyLAB/LG-Master-Web-App |
| All LG Projects | https://github.com/LiquidGalaxyLAB |
| GSoC 2026 Ideas | https://www.liquidgalaxy.eu/2025/11/GSoC2026.html |
| LG Mobile Apps | https://www.liquidgalaxy.eu/2018/06/mobile-applications.html |
| LG App Store | https://store.liquidgalaxy.eu/ |
| LG Core Installation | https://github.com/LiquidGalaxyLAB/liquid-galaxy |
