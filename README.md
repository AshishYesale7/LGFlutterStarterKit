# LG Flutter Starter Kit

A professional, production-grade starter kit for building **Liquid Galaxy** applications using **Flutter**, **Dart**, **SSH/KML**, and **Node.js**.

This project provides everything you need to build, test, and deploy Flutter apps that interact with the Liquid Galaxy multi-screen Google Earth system — from earthquake visualizers and satellite trackers to guided tours and interactive dashboards. It ships with **Antigravity**, a 33-skill AI engineering mentor that teaches you the full stack while you build.

## 🚀 Key Features

- **Flutter + LG Integration**: Pre-wired Flutter app with SSH, KML generation, and LG rig communication out of the box. Connect your phone to a 3/5/7-screen Google Earth rig in minutes.
- **Complete Service Layer**:
  - **LG Service**: High-level facade — `sendLogo()`, `flyTo()`, `sendPyramid()`, `cleanKML()`, `orbit()`
  - **SSH Service**: Raw SSH command execution to the LG master machine via `dartssh2`
  - **KML Service**: Stateless KML XML generator — placemarks, tours, overlays, 3D objects, time animations
  - **API Services**: Example data integrations (USGS earthquakes) ready for extension
- **5-Layer Enforced Architecture**: Strict import boundaries between Presentation → Orchestration → Providers → KML → Transport. Violations are blocked automatically.
- **Material 3 UI**: Modern Flutter design with light/dark themes, Provider state management, responsive layouts, and an interactive workflow visualizer.
- **Antigravity AI Mentor**: 33 agent skills, 5 architecture rules, 4 workflows — a conversational 11-stage pipeline that guides you from zero to deployed APK.
- **Dynamic Rig Configuration**: Configurable for any screen count (3, 5, 7) via `config.dart`. Screen numbering, logo placement, and KML targeting adjust automatically.
- **Node.js Companion Server**: Optional backend with Express + WebSocket for data processing, API proxying, and real-time communication.
- **CI/CD Ready**: 3 GitHub Actions workflows — continuous integration, APK builds, and security scanning.

## 🛠️ Installation

1. **Clone the repository**
2. **Install dependencies**:
   ```bash
   cd flutter_client
   flutter pub get
   ```

## 🏁 Running the Project

### Standard Start (3-Screen Rig)

The default mode assumes a standard 3-screen Liquid Galaxy rig at `192.168.56.101`.

```bash
cd flutter_client
flutter run
```

### Custom Rig Configuration

Edit `lib/config.dart` to match your rig:

```dart
class Config {
  static const String lgHost = '192.168.56.101';  // Your LG master IP
  static const int lgPort = 22;
  static const int totalScreens = 3;              // 3, 5, or 7
  static const String lgUser = 'lg';
  static const String lgPassword = 'lg';
}
```

### Screen Mapping (3-Screen Rig)

```
┌──────────┐  ┌──────────┐  ┌──────────┐
│ Screen 3 │  │ Screen 1 │  │ Screen 2 │
│  (Left)  │  │ (Master) │  │  (Right) │
│  Logo ◄  │  │  Center  │  │          │
└──────────┘  └──────────┘  └──────────┘
```

- **Screen 1** (Master): Primary Google Earth display, receives camera commands via `/tmp/query.txt`
- **Screen 3** (Left Slave): App logo displayed as `<ScreenOverlay>` KML
- **Screen 2** (Right Slave): Additional overlays and legends

### Building for Release

```bash
# Debug APK
flutter build apk --debug

# Release APK (contest submission)
flutter build apk --release

# With custom LG host override
flutter build apk --dart-define=LG_HOST=192.168.56.101
```

### Node.js Server (Optional)

```bash
cd server
npm install
npm start
# Server runs on http://localhost:3000
```

## 🏗️ Architecture Overview

The project follows a **Client-to-Rig** model. Your Flutter app communicates with the LG rig over SSH, sending KML data and camera commands. Google Earth on the rig handles all multi-screen rendering.

### 1. The Flutter App (`flutter_client/lib/`)

- **Screens**: UI for rig interaction — Splash, Connection, Dashboard, Settings, Help, Workflow Visualizer. Actions trigger KML/SSH operations on the rig.
- **Services**: All business logic. `LGService` is the facade that coordinates SSH + KML. Screens never touch SSH or KML directly.
- **Providers**: State management via `ChangeNotifier` + `MultiProvider`. Settings, themes, and connection state.
- **Models**: Immutable domain data classes. Pure data — no I/O, no side effects.

### 2. The LG Rig

- **LG Master** (Screen 1): Receives SSH commands from your app. Writes KML files to `/var/www/html/kml/` and camera commands to `/tmp/query.txt`.
- **Slave Screens**: Google Earth instances that poll the KML files and render synchronized visualizations across all screens automatically.
- **No Code Runs on the Rig**: You don't deploy anything to the rig. You send KML over SSH, and Google Earth handles the rest.

### 3. The "Magic" (App → Rig Communication)

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

**This is the core concept every student must understand.** Your Flutter app sends data to the rig — Google Earth handles all multi-screen rendering.

### 4. The 5-Layer Import Matrix

```
┌─────────────────────────────────────────────────────┐
│  PRESENTATION   screens/, widgets/                   │
│  ❌ Cannot import: dartssh2, http, kml_service       │
├─────────────────────────────────────────────────────┤
│  ORCHESTRATION  services/lg_service.dart             │
├─────────────────────────────────────────────────────┤
│  DATA PROVIDERS services/*_service.dart, providers/  │
├─────────────────────────────────────────────────────┤
│  KML GENERATION services/kml_service.dart            │
│  ❌ Cannot import: dartssh2, ssh_service              │
├─────────────────────────────────────────────────────┤
│  TRANSPORT      services/ssh_service.dart            │
│  ❌ Cannot import: kml_service, models/               │
└─────────────────────────────────────────────────────┘
```

Data flows **one direction**: API → Provider → Domain Model → KML Generator → SSH Transport → LG Rig

## 📱 What Can You Build?

This starter kit supports **any** type of Liquid Galaxy application:

| App Type | Example | Data Source |
|----------|---------|-------------|
| **Data Visualization** | Earthquake heatmaps, volcano activity, weather patterns | USGS, NASA, OpenWeather APIs |
| **Educational Tours** | Historical city tours, museum walkthroughs, geography lessons | Static data, Wikipedia, custom |
| **Satellite Tracking** | ISS tracker, Starlink constellation visualizer | NASA TLE, CelesTrak |
| **AI-Powered** | AI travel itinerary generator, smart city explorer | Gemini API, OpenAI, custom ML |
| **Rig Management** | Dashboard for controlling Google Earth navigation | Direct SSH commands |
| **Contest Task 2** | Basic LG operations (logo, pyramid, flyTo, clean) | None (built-in) |

Browse [100+ past GSoC LG projects](https://github.com/LiquidGalaxyLAB) for inspiration.

## 📲 App Screens & Controls

| Screen | Purpose |
|--------|---------|
| **Splash** | App branding, auto-navigates to Connection |
| **Connection** | Enter LG rig IP, port, credentials. Test connection. |
| **Main Dashboard** | Action cards: FlyTo, Send Logo, Send Pyramid, Orbit, Clean |
| **Settings** | Rig config, screen count, home city coordinates |
| **Help/About** | Usage instructions and LG architecture overview |
| **Workflow Flow** | Interactive n8n-style visualization of the 11-stage agent pipeline |

All screens are starting points — extend, replace, or add new ones for your project.

### 5 Core LG Operations (Task 2 Minimum)

| Operation | Service Method | Effect on Rig |
|-----------|---------------|---------------|
| **Send Logo** | `lgService.sendLogo()` | ScreenOverlay KML → left slave screen |
| **Send 3D Pyramid** | `lgService.sendPyramid()` | Extruded colored polygon → master screen |
| **FlyTo Home City** | `lgService.flyToHomeCity()` | Smooth camera flight to your coordinates |
| **Clean Logos** | `lgService.cleanLogos()` | Remove overlays from slave screens |
| **Clean KMLs** | `lgService.cleanKMLs()` | Clear all KML files from the rig |

## 🤖 Expert Agent Pipeline

This repository is **"Agent-Hardened"** with a built-in 11-stage mentoring system designed to guide you from zero to a "Wow-Factor" graduation.

```
Env Doctor → Shield (pre) → Init → Brainstorm → Viz Architect →
Plan Writer → Data Pipeline → UI Scaffold → Execute →
Code Review → Shield (post) → Quiz (Finale)
```

1. **Environment Doctor (`lg-env-doctor`)**: Validates Flutter, Dart, Git, JDK, Android SDK, SSH — blocks pipeline until everything passes.
2. **Security Pre-Flight (`lg-shield`)**: Scans for hardcoded secrets, validates `.gitignore`, checks `flutter_secure_storage`.
3. **Initialize (`lg-init`)**: Creates your app in a separate directory with `LG-<TaskName>` naming, scaffolds architecture, inits Git + GitHub.
4. **Brainstorm (`lg-brainstormer`)**: Collaborative design focusing on visual impact on the LG rig, data sources, and architectural tradeoffs.
5. **Viz Architect (`lg-viz-architect`)**: Designs the multi-screen Google Earth experience — storyboards, KML elements, camera tours, performance budgets.
6. **Plan (`lg-plan-writer`)**: Detailed implementation roadmap with 5-10 minute tasks and built-in educational checkpoints.
7. **Data Pipeline + UI Scaffold (`lg-data-pipeline` + `lg-ui-scaffolder`)**: Wires API → Model → KML → SSH pipeline. Generates Flutter screens with Provider wiring.
8. **Execute (`lg-exec`)**: Guided implementation in batches of 2-3 tasks. Stops after every batch for a verification question. **Will not auto-continue.**
9. **Code Review (`lg-code-reviewer`)**: Professional OSS-grade audit — SOLID, DRY, `flutter analyze`, `dart format`, 80%+ test coverage.
10. **Security Post-Flight (`lg-shield`)**: Final scan on completed code. Blocks graduation if critical issues found.
11. **Quiz (`lg-quiz-master`)**: The "TV Show" finale! 5 high-stakes questions covering SSH pipelines, KML constructs, engineering principles, performance, and architecture.

**⚠️ PROMINENT GUARDRAIL**: The **Critical Advisor** (`lg-critical-advisor`) is active throughout the entire journey. If you rush, skip explanations, or say "just build it" — it intervenes immediately. You must demonstrate understanding at every checkpoint.

### Conversational Auto-Chain

After each stage, the agent **automatically offers** the next one:

> *"Project scaffolded! Now let's brainstorm features — what should your LG app visualize on Google Earth? Ready? 🧠"*

No manual skill-hunting required. Say "ready" and the pipeline flows.

### Full Skill Roster (33 Skills)

| Category | Skills |
|----------|--------|
| **Pipeline Core** | `lg-env-doctor`, `lg-setup-guide`, `lg-shield`, `lg-init`, `lg-flutter-init`, `lg-brainstormer`, `lg-viz-architect`, `lg-plan-writer`, `lg-exec`, `lg-code-reviewer`, `lg-quiz-master` |
| **Architecture** | `lg-data-pipeline`, `lg-ui-scaffolder`, `lg-kml-craftsman`, `lg-kml-writer`, `lg-logic-builder`, `lg-file-generator`, `lg-ssh-controller` |
| **Quality** | `lg-critical-advisor`, `lg-tester`, `lg-debugger`, `lg-dependency-resolver` |
| **DevOps** | `lg-github-agent`, `lg-flutter-build`, `lg-devops-agent`, `lg-emulator-manager`, `lg-demo-recorder` |
| **Converters** | `lg-api-integrator`, `lg-dart-converter`, `lg-code-converter` |
| **Teaching** | `lg-learning-resources`, `lg-resume-pipeline`, `lg-nanobanana-sprite` |

### 5 Enforced Architecture Rules

| Rule | Enforces |
|------|----------|
| `lg-architecture.md` | LG rig model, SSH communication, service layer patterns |
| `flutter-best-practices.md` | Provider patterns, widget decomposition, const constructors |
| `layer-boundaries.md` | 5-layer import matrix, one-direction data flow |
| `kml-standards.md` | Valid KML 2.2 structure, `lon,lat,alt` coordinate order, tour conventions |
| `dart-style.md` | Effective Dart naming, `///` documentation, formatting standards |

## 🎓 Educational Notes

- **No Free Code**: The agent explains every architectural decision before writing code. If you can't explain it, the pipeline stops.
- **Service Layer Pattern**: All SSH, KML, and API logic lives in services — never in screens or widgets. This matches how [Lucia's LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) structures the reference implementation.
- **KML Coordinate Order**: Google Earth uses `longitude,latitude,altitude` — not `lat,lon`. Getting this wrong is the #1 beginner mistake.
- **SSH Lifecycle**: Connections must be properly opened, verified, and disposed. The agent enforces `dispose()` methods on services to prevent resource leaks.
- **Secure Storage**: Passwords and API keys **must** use `flutter_secure_storage` — never `SharedPreferences`. The Shield skill scans for this.

### 🛠️ Professional Quality Tools

This starter kit comes pre-configured with the same tools used by professional Flutter teams:

- **`flutter analyze`**: Static analysis — zero errors/warnings required at all times.
- **`dart format`**: Consistent code formatting enforced via `--set-exit-if-changed`.
- **`flutter test`**: Unit and widget tests with 80%+ coverage target.
- **GitHub Actions CI/CD**: `flutter-ci.yml` (lint + test), `flutter-build.yml` (APK build), `security-scan.yml` (automated scanning).
- **Provider + ChangeNotifier**: Google-recommended state management for medium-complexity apps.

Students are expected to keep `flutter analyze` passing at all times!

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `dartssh2` | ^2.9.0 | SSH communication with LG rig |
| `provider` | ^6.1.1 | State management (ChangeNotifier) |
| `http` | ^1.2.0 | REST API calls to external data sources |
| `xml` | ^6.3.0 | KML XML generation & validation |
| `shared_preferences` | ^2.2.2 | Persistent settings (non-sensitive) |
| `flutter_secure_storage` | ^9.0.0 | Encrypted credential storage |
| `path_provider` | ^2.1.1 | File system access |
| `web_socket_channel` | ^3.0.1 | WebSocket to Node.js server |

## 🔗 Reference Implementations & Resources

| Resource | Link |
|----------|------|
| Lucia's LG Master Web App (reference implementation) | [GitHub](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) |
| All Liquid Galaxy Lab Projects (100+ GSoC repos) | [GitHub](https://github.com/LiquidGalaxyLAB) |
| GSoC 2026 Ideas Page | [liquidgalaxy.eu](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html) |
| LG Mobile Applications Showcase | [liquidgalaxy.eu](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html) |
| LG App Store | [store.liquidgalaxy.eu](https://store.liquidgalaxy.eu/) |
| LG Core Installation | [GitHub](https://github.com/LiquidGalaxyLAB/liquid-galaxy) |
| KML Reference (Google) | [developers.google.com](https://developers.google.com/kml/documentation/kmlreference) |
| Flutter App Architecture (Google) | [docs.flutter.dev](https://docs.flutter.dev/app-architecture) |

## 📄 License

This project is licensed under the [MIT License](LICENSE).
