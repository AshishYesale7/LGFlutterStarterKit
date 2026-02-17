---
name: lg-flutter-init
description: 'Bootstrap a new Liquid Galaxy Flutter controller application. Enforces LG-<TaskName> naming, recommends logo/assets, configures LG rig connection, and follows the contest 3-repository workflow.'
---

# Liquid Galaxy Flutter Project Initializer

Use this skill when starting a **new** Liquid Galaxy Flutter application from the starter kit. This is the first step in the 6-stage pipeline: **Init** -> **Brainstorm** -> **Plan** -> **Execute** -> **Review** -> **Quiz (Finale)**.

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) and **LG Shield** (.agent/skills/lg-shield/SKILL.md) are active at all times.

---

## Contest: 3-Repository Workflow

**Gemini Summer of Code 2026 — Agentic Programming Contest** requires 3 deliverables:

| # | Repository | Description |
|---|-----------|-------------|
| 1 | **LGFlutterStarterKit** | The starter kit template + `.agent/` system (this repo) |
| 2 | **Student's App** (e.g., `LG-Task2-Demo`) | The generated Flutter LG controller app (separate repo) |
| 3 | **Agent System** | The `.agent/` directory (skills + rules + workflows) — part of repo #1 |

---

## CRITICAL: Separate Directory Rule

> **The new app is ALWAYS created in a separate sibling directory.**
> The `LGFlutterStarterKit` is a read-only template. The student's new app gets its own folder and its own GitHub repo.

```
parent/
├── LGFlutterStarterKit/    ← Template (read-only reference)
└── LG-Task2-Demo/          ← Student's app (own Git repo, pushed to GitHub)
    ├── flutter_client/
    │   └── lib/
    ├── server/
    ├── docs/
    ├── .github/workflows/
    └── README.md
```

See `lg-init` Phase 0 for the directory creation commands.

---

## CRITICAL: LG App Naming Convention

**All generated apps MUST follow:**

```
LG-<TaskName>
```

| Good Name | Bad Name |
|-----------|----------|
| `LG-Task2-Demo` | `my_app` |
| `LG-Earthquake-Viz` | `flutter_test` |
| `LG-Satellite-Tracker` | `earthquake_app` |
| `LG-Historic-Tours` | `lg_demo` |

**Rules:**
- Always prefix with `LG-`
- PascalCase after the prefix
- Descriptive of the visualization/task
- Flutter package name = snake_case version: `lg_task2_demo`

---

## Phase 0: Repository & Version Control Setup

1. **Verify starter kit location**: `ls .agent/` should show skills/ rules/ workflows/.
2. **Create new app directory** (sibling to starter kit):
   ```bash
   APP_NAME="LG-Task2-Demo"  # Gathered in Phase 1, MUST follow LG-<TaskName>
   APP_DIR="$(dirname $(pwd))/$APP_NAME"
   mkdir -p "$APP_DIR"
   ```
3. **Copy scaffolding** from starter kit into the new directory.
4. **Init Git**: `cd "$APP_DIR" && git init`
5. **Create GitHub repo**: Hand off to `lg-github-agent` for remote setup.
6. **Initial commit**: `git add . && git commit -m "init: project scaffolding from LGFlutterStarterKit"`.

---

## Phase 1: Interactive Requirement Gathering

Before writing any code, you **MUST** ask the student these questions **ONE AT A TIME**, waiting for each response:

1. **Project Name**: *"What should we name this app? Convention is `LG-<TaskName>`. For the basic contest task, I'd suggest `LG-Task2-Demo`. What's yours?"*

2. **LG Rig Config**:
   - **Screen Count**: (Task 2 uses 3. Common are 3, 5, or 7).
   - **Note**: Liquid Galaxy rigs use **identical screens**. No heterogeneous sizes.

3. **App Type**:
   - `Task 2 Demo`: Minimum required features (logo, pyramid, flyTo, clean).
   - `Data Visualization`: Maps, KML overlays, API data on Google Earth.
   - `Educational`: Interactive tours, guided explorations, information balloons.
   - `Controller`: Rig management, Google Earth navigation, multi-purpose dashboard.

4. **Target Platforms** (multiple allowed):
   - `Android` (primary for phone controller — required for Task 2 APK)
   - `iOS` (optional phone controller)
   - `Linux/macOS` (for development and testing)

5. **External APIs**: Which data sources? (None for Task 2, or USGS, NASA, OpenWeather, custom for advanced).

6. **Confirm Tooling**: `flutter analyze`, `flutter test`, `dart format`.

---

## Phase 1.5: Logo & Asset Recommendations

**After gathering requirements, ALWAYS recommend visual assets:**

> *"Every LG app needs visual assets. Let me recommend what you need and how to generate them."*

### Required Assets for LG Apps

| Asset | Purpose | Where It Goes | Spec |
|-------|---------|--------------|------|
| **App Logo Overlay** | Displayed on slave screen (ScreenOverlay) | Left slave screen (screen 3 in 3-rig) | 1024×512 PNG, transparent |
| **App Icon** | Android launcher icon | `android/app/src/main/res/` | 1024×1024, adaptive icon |
| **Placemark Icon** (if data viz) | Custom marker for data points on GE | KML `<Icon><href>` | 512×512 PNG, transparent |

### How to Generate

Use **Nano Banana Asset Master** (`.agent/skills/lg-nanobanana-sprite/SKILL.md`):
- Generates with green-screen background → processes to transparent PNG
- Recommended prompt for LG logo: *"Modern sleek logo for [App Name], Liquid Galaxy themed, blue and white tones, text '[LG-TaskName]'. Background: Solid bright neon green (#00FF00). 4k."*

### Reference
See how Lucia handles the logo overlay in [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App). The logo is sent as a `<ScreenOverlay>` KML to the left slave screen.

---

## Phase 2: Structural Scaffolding

Standard Liquid Galaxy Flutter architecture (matches [Lucia's LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App)):

```
flutter_client/lib/
  main.dart          # App entry point with Provider setup
  config.dart        # LG rig connection config (IP, screens, home city)
  constants/         # App-wide constants
  models/            # Data models (KML, API responses)
  screens/           # Phone controller UI screens
  services/          # Business logic (SSH, KML, LG facade, API)
  widgets/           # Reusable UI components
  modules/           # Feature modules (each self-contained)
```

### Action: Dependency & Directory Check

1. **Create directories**: `docs/plans`, `docs/reviews`, `docs/aimentor`, `flutter_client/lib/models`, `flutter_client/lib/widgets`, `flutter_client/lib/constants`, `flutter_client/test`, `flutter_client/assets`.
2. **Run**: `cd flutter_client && flutter pub get` to resolve dependencies.
3. **Platform check**: `flutter doctor` to verify toolchain.

---

## Phase 3: Configuration

### `flutter_client/lib/config.dart`

Apply the LG rig connection defaults:

```dart
class Config {
  // LG naming convention — matches the app repo name
  static const String appName = 'LG-Task2-Demo';

  // LG Rig Connection
  static const int totalScreens = 3;
  static const String lgHost = '192.168.56.101';
  static const int lgPort = 22;
  static const String lgUser = 'lg';
  static const String lgPassword = 'lg';

  // Camera defaults
  static const double defaultTilt = 60.0;
  static const double defaultRange = 15000.0;

  // Home city (student's city for flyTo demo)
  static const double homeLat = 0.0;   // Student fills this in
  static const double homeLon = 0.0;   // Student fills this in
  static const String homeCity = '';    // Student fills this in
}
```

### `flutter_client/pubspec.yaml`

Core LG dependencies:
- `provider` (state management)
- `http` (REST API calls)
- `dartssh2` (SSH to LG rig)
- `xml` (KML XML generation)
- `path_provider` (file system access)
- `shared_preferences` (persistent connection settings)

---

## Phase 4: Best Practices & Reminders

Explain these **3 Golden Rules** to the student:

1. **App is Controller**: The Flutter app runs on your phone. It is a remote control for the Liquid Galaxy rig. You send commands via SSH, and Google Earth on the rig displays the visualization.
2. **Service Layer**: All SSH, KML, and API logic lives in services, never in widgets. Widgets read state from Provider and render UI.
3. **KML is King**: Everything displayed on the LG rig is KML sent to Google Earth. Learn KML constructs: Placemarks, FlyTo, Tours, ScreenOverlays, Balloons.

**Reference**: Study [Lucia's LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) — it's the canonical reference for LG Flutter apps.

**LG Official Pages**:
- [GSoC 2026 Ideas](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html)
- [LG Mobile Applications](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html)
- [LG App Store](https://store.liquidgalaxy.eu/)
- [All LG Projects](https://github.com/LiquidGalaxyLAB)

---

## Execution

1. Ask the questions (one at a time, wait for answers).
2. Recommend logo/assets via Nano Banana.
3. Plan file creations/modifications.
4. Run `flutter pub get`.
5. Run `flutter analyze` to verify zero errors.
6. Commit: `git add . && git commit -m "init: LG Flutter project scaffolding"`.
7. **Student checkpoint**: *"The project is scaffolded. Can you explain: What happens when your Flutter app sends a KML file to the LG rig? Which machine receives it and what happens next?"*
8. If the student cannot answer, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md) — SSH & LG Communication topic.
9. Hand off to **Brainstormer** (.agent/skills/lg-brainstormer/SKILL.md).
