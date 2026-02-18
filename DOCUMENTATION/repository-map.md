# Repository Map

> Complete file tree with descriptions of every directory and file in the project.

---

## Table of Contents

- [Root Level](#root-level)
- [Flutter Client (`flutter_client/`)](#flutter-client-flutter_client)
- [Agent System (`.agent/`)](#agent-system-agent)
- [CI/CD (`.github/`)](#cicd-github)
- [Node.js Server (`server/`)](#nodejs-server-server)
- [Documentation (`docs/` & `DOCUMENTATION/`)](#documentation-docs--documentation)
- [Demo (`demo/`)](#demo-demo)

---

## Root Level

```
LGFlutterStarterKit/
├── README.md                    # Project overview, contest info, quickstart
├── CONTRIBUTING.md              # Contribution guidelines, PR checklist, architecture rules
├── CHANGELOG.md                 # Version history (Keep a Changelog format)
├── DEVELOPMENT_LOG.md           # Architecture decisions and session notes
├── LICENSE                      # MIT License (Copyright 2026 Ashish Yesale)
└── LGFlutterStarterKit.code-workspace  # VS Code multi-root workspace config
```

---

## Flutter Client (`flutter_client/`)

```
flutter_client/
├── pubspec.yaml                 # Package metadata + dependencies
├── analysis_options.yaml        # Lint rules (flutter_lints + 18 custom rules)
└── lib/
    ├── config.dart              # Centralized configuration
    ├── main.dart                # App entry point, MultiProvider, routes
    │
    ├── models/                  # Data models (pure, no I/O)
    │   ├── connection_status.dart   # Re-export ConnectionStatus from ssh_service
    │   └── flow_node.dart           # FlowNode + FlowEdge + enums for workflow viz
    │
    ├── providers/               # State management (ChangeNotifier)
    │   ├── settings_provider.dart   # Persistent settings (SharedPrefs + SecureStorage)
    │   └── theme_provider.dart      # Light/dark/system theme toggle
    │
    ├── screens/                 # UI layer (Presentation)
    │   ├── splash_screen.dart       # Branding, 2s auto-navigate to /connection
    │   ├── connection_screen.dart   # Credential input, secure persist, connect
    │   ├── main_screen.dart         # Dashboard: 5 Task 2 buttons + extras
    │   ├── settings_screen.dart     # Read-only config, theme radio, reset
    │   ├── help_screen.dart         # SSH commands, KML basics, architecture
    │   ├── workflow_flow_screen.dart # n8n-style interactive pipeline visualizer
    │   └── optional_files/          # Template screens (not routed by default)
    │       ├── orbit.dart           # 360° camera orbit demo
    │       ├── earthquake.dart      # USGS earthquake visualization
    │       ├── kml_viewer.dart      # KML file browser/viewer
    │       ├── balloon.dart         # Balloon animation demo
    │       └── nodejs.dart          # Node.js server integration demo
    │
    ├── services/                # Business logic layer
    │   ├── lg_service.dart          # Orchestration facade (15 methods)
    │   ├── kml_service.dart         # Pure KML XML generation (8 methods)
    │   ├── ssh_service.dart         # SSH + SFTP transport (6 methods)
    │   ├── earthquake_service.dart  # USGS API integration example
    │   └── socket_service.dart      # WebSocket client
    │
    └── widgets/                 # Reusable UI components
        ├── flow_node_card.dart      # Pipeline node card (200×80px)
        └── flow_edge_painter.dart   # Bezier edge painter (CustomPainter)
```

### Key Files Explained

#### `config.dart`
Central configuration with `--dart-define` support. Contains all connection defaults, rig geometry, home city coordinates, and app metadata. Every configurable value lives here.

#### `main.dart`
App entry point. Sets up `WidgetsFlutterBinding.ensureInitialized()`, creates `MultiProvider` with 3 providers (SettingsProvider, ThemeProvider, LGService), configures Material 3 theme, and defines 6 routes.

#### `services/lg_service.dart`
The **orchestration facade** — the most important file. Wraps `KMLService` and `SSHService` behind simple method calls. Screens interact with this service exclusively. 15 public methods including all 5 Task 2 operations.

#### `services/kml_service.dart`
**Pure KML generation** — zero imports, zero I/O, zero state. Takes parameters, returns KML XML strings. 8 methods covering placemarks, overlays, line strings, orbits, pyramids, fly-to, empty KML, and slave wrapping.

#### `services/ssh_service.dart`
**Transport layer** — owns the SSH connection via `dartssh2`. Also defines the `ConnectionStatus` enum. Handles SFTP uploads with `printf` fallback. Throws `StateError` on failures (no silent swallowing).

#### `providers/settings_provider.dart`
Split storage strategy: `SharedPreferences` for non-sensitive settings (host, port, screens), `FlutterSecureStorage` for sensitive data (username, password). Loads on init, persists on update.

#### `screens/workflow_flow_screen.dart`
The interactive pipeline visualizer. 20 nodes, 16 edges, pinch-to-zoom, tap-to-detail. Shows the complete agent pipeline flow including checkpoints and helper skills.

---

## Agent System (`.agent/`)

```
.agent/
├── PROMPT.md                    # Master system prompt for the Antigravity agent
├── skills/                      # 33 YAML + Markdown skill definitions
│   ├── lg-env-doctor.*          # Environment validation
│   ├── lg-setup-guide.*         # Setup instructions
│   ├── lg-shield.*              # Security scanning
│   ├── lg-init.*                # Project scaffolding
│   ├── lg-flutter-init.*        # Flutter-specific init
│   ├── lg-brainstormer.*        # Design ideation
│   ├── lg-viz-architect.*       # Visualization design
│   ├── lg-plan-writer.*         # Implementation roadmap
│   ├── lg-exec.*                # Guided implementation
│   ├── lg-code-reviewer.*       # Code audit
│   ├── lg-quiz-master.*         # Graduation quiz
│   ├── lg-data-pipeline.*       # API→Model→KML→SSH wiring
│   ├── lg-ui-scaffolder.*       # Screen generation
│   ├── lg-kml-craftsman.*       # Advanced KML
│   ├── lg-kml-writer.*          # KML formatting
│   ├── lg-logic-builder.*       # Business logic
│   ├── lg-file-generator.*      # File scaffolding
│   ├── lg-ssh-controller.*      # SSH patterns
│   ├── lg-critical-advisor.*    # Guardrail (always active)
│   ├── lg-tester.*              # Test writing
│   ├── lg-debugger.*            # Debug assistance
│   ├── lg-dependency-resolver.* # Package conflicts
│   ├── lg-github-agent.*        # GitHub management
│   ├── lg-flutter-build.*       # APK optimization
│   ├── lg-devops-agent.*        # CI/CD setup
│   ├── lg-emulator-manager.*    # Emulator management
│   ├── lg-demo-recorder.*       # Video recording guide
│   ├── lg-api-integrator.*      # API integration
│   ├── lg-dart-converter.*      # Data serialization
│   ├── lg-code-converter.*      # Code migration
│   ├── lg-learning-resources.*  # Learning materials
│   ├── lg-resume-pipeline.*     # Pipeline resume
│   └── lg-nanobanana-sprite.*   # Morale/encouragement
│
├── rules/                       # 5 architecture enforcement rules
│   ├── lg-architecture.md       # Client-to-Rig model, service patterns
│   ├── flutter-best-practices.md # Provider, widgets, const
│   ├── layer-boundaries.md      # 5-layer import matrix
│   ├── kml-standards.md         # KML 2.2, coordinate order
│   └── dart-style.md            # Effective Dart, formatting
│
└── workflows/                   # 4 orchestration workflows
    ├── main-pipeline.*          # Full 11-stage sequence
    ├── quick-start.*            # Abbreviated for experienced devs
    ├── resume.*                 # Resume from checkpoint
    └── review-only.*            # Code review + security only
```

---

## CI/CD (`.github/`)

```
.github/
└── workflows/
    ├── flutter-ci.yml           # Analyze → Format → Test (on push/PR)
    ├── flutter-build.yml        # Debug + Release APK build (on push to main)
    └── security-scan.yml        # Secret detection + dependency audit (PR + weekly)
```

---

## Node.js Server (`server/`)

```
server/
├── index.js                     # Express app + WebSocket server
└── package.json                 # Dependencies (express, cors, ws, nodemon)
```

**5 endpoints:** `/`, `/health`, `/api/status`, `/api/kml/generate`, `/api/data`  
**WebSocket:** Echo server with timestamps on `ws://localhost:3000`

---

## Documentation (`docs/` & `DOCUMENTATION/`)

```
docs/                            # Working documentation
├── architecture-map.md          # System diagram, import matrix, data flow (133 lines)
├── learning-journal.md          # Session notes and learnings
├── tech-debt.md                 # Known issues (5 open, 10 resolved)
├── aimentor/                    # AI mentor session data
├── plans/                       # Design documents
│   ├── 2026-02-17-task2-design.md
│   └── 2026-02-17-task2-viz-design.md
└── reviews/                     # Code reviews and reports
    ├── 2026-02-17-final-quiz-report.md
    ├── 2026-02-17-task2-review.md
    └── shield-report.md

DOCUMENTATION/                   # Comprehensive technical documentation
├── architecture.md              # 5-layer architecture deep dive
├── service-api-reference.md     # Complete API reference (all methods)
├── setup-and-configuration.md   # Installation, build, config guide
├── agent-system.md              # 33-skill agent system docs
├── screens-and-ui.md            # Every screen documented
├── cicd-and-quality.md          # CI/CD workflows + quality standards
├── nodejs-server.md             # Companion server docs
└── repository-map.md            # This file — complete file tree
```

---

## Demo (`demo/`)

```
demo/                            # Demo app output (separate repository)
```

The demo app is created by running the Antigravity agent pipeline against this starter kit. It lives in a **separate repository** — this directory may contain references or links to the demo repo.
