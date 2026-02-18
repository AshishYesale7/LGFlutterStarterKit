# LG Flutter Starter Kit

> **Build your first Liquid Galaxy app — guided step-by-step by an AI mentor.**

A production-ready Flutter starter template for building **Gemini Summer of Code 2026** projects that control the **Liquid Galaxy** multi-screen Google Earth system. Ships with **Antigravity**, an AI engineering mentor powered by 33 agent skills that teaches you while you build.

---

## What Is This?

Liquid Galaxy is an open-source system that runs Google Earth across 3, 5, or 7 synchronized screens to create a panoramic visualization wall. Your Flutter app acts as a **remote control** — it sends KML files and SSH commands from your phone to the LG rig, and Google Earth renders them across all screens.

This starter kit gives you:

| What You Get | Why It Matters |
|-------------|---------------|
| **Working Flutter app** with SSH, KML, and LG services | Skip weeks of boilerplate — start building features immediately |
| **Antigravity AI mentor** (33 skills, 5 rules, 4 workflows) | Guided learning pipeline that teaches LG architecture while you code |
| **Conversational auto-chain** | The AI automatically walks you through each stage — no manual prompting needed |
| **CI/CD pipelines** | GitHub Actions for build, lint, test, and security scanning |
| **Node.js companion server** | Optional backend for data processing and WebSocket communication |
| **Complete documentation** | Plans, reviews, and learning journals generated as you build |

---

## Who Is This For?

- **GSoC students** building a Liquid Galaxy app for the first time
- **Contest participants** in the Gemini Summer of Code 2026 — Agentic Programming Contest
- **Anyone** who wants to learn Flutter + SSH + KML + Google Earth integration with AI-guided mentorship

**No prior LG experience required.** The Antigravity agent teaches you the architecture from scratch.

---

## How It Works — The Big Picture

```
┌──────────────────────┐          SSH (port 22)          ┌──────────────────────┐
│   Your Phone/Tablet  │ ──────────────────────────────▶ │     LG Rig (3-7 PCs) │
│                      │                                  │                      │
│   Flutter App        │    Sends KML files + commands    │   Google Earth        │
│   (Remote Control)   │ ◀────────────────────────────── │   (The Display)       │
│                      │          Status responses        │                      │
└──────────────────────┘                                  └──────────────────────┘
```

**Key concept**: Your Flutter app runs on a phone. It does NOT render across multiple screens. Google Earth handles that. Your app sends:
- **KML files** → Placemarks, tours, overlays, 3D objects appear on the rig
- **SSH commands** → Camera flies to locations, orbits, resets

---

## Quick Start (5 Minutes)

### 1. Clone & Run the Template

```bash
git clone https://github.com/<your-username>/LGFlutterStarterKit.git
cd LGFlutterStarterKit/flutter_client
flutter pub get
flutter run
```

### 2. Start the AI Mentor

Open the project in your IDE with Gemini Code Assist (or any agent that reads `.agent/` files).

**The agent says:**

> *"Welcome to Antigravity 🚀 — your AI engineering mentor for Liquid Galaxy development. Let's start with Stage 0: Environment Doctor. What operating system are you on?"*

From here, the agent guides you through **11 stages** automatically. You don't need to know what to ask — it offers the next step after each checkpoint.

### 3. Build Your App

The agent creates your app in a **separate sibling directory** (the starter kit stays untouched):

```
parent/
├── LGFlutterStarterKit/    ← Template (read-only reference)
│   └── .agent/             ← 33 AI skills live here
└── LG-Task2-Demo/          ← YOUR app (own Git repo, pushed to GitHub)
    ├── flutter_client/
    ├── server/
    ├── docs/
    └── README.md
```

---

## The 11-Stage Pipeline

Antigravity guides you through every stage with **mandatory checkpoints** — it asks questions, waits for your answers, and won't proceed until you understand what's being built.

```
┌──────────┐   ┌──────────┐   ┌──────┐   ┌──────────┐   ┌──────┐   ┌──────────┐
│   Env    │──▶│  Shield  │──▶│ Init │──▶│  Brain-  │──▶│ Viz  │──▶│   Plan   │
│  Doctor  │   │  (pre)   │   │      │   │  storm   │   │ Arch │   │          │
└──────────┘   └──────────┘   └──────┘   └──────────┘   └──────┘   └──────────┘
                                                                          │
┌──────────┐   ┌──────────┐   ┌──────┐   ┌──────────┐   ┌──────────────┐  │
│   Quiz   │◀──│  Shield  │◀──│  Re- │◀──│ Execute  │◀──│ UI Scaffold  │◀─┘
│ (Finale) │   │  (post)  │   │ view │   │+KML Craft│   │ +Data Pipe   │
└──────────┘   └──────────┘   └──────┘   └──────────┘   └──────────────┘
```

| # | Stage | What Happens | What You Learn |
|---|-------|-------------|----------------|
| Pre | **Environment Doctor** | Checks Flutter, Dart, Git, JDK, Android SDK, SSH | Your dev environment is ready |
| 0 | **Security Pre-Flight** | Scans for secrets, validates `.gitignore` | Security hygiene from day one |
| 1 | **Init** | Creates your app directory, Git repo, GitHub repo, scaffolding | Project structure & LG naming conventions |
| 2 | **Brainstorm** | Collaborative design of features with trade-offs | Architectural thinking & LG data visualization |
| 3 | **Viz Architect** | Designs the multi-screen Google Earth experience | KML storyboarding, camera tours, multi-screen layout |
| 4 | **Plan Writer** | Breaks design into 5-10 min coding tasks | Engineering planning & task decomposition |
| 5 | **Data Pipeline + UI Scaffold** | Wires API → Model → KML → SSH pipeline + generates phone screens | Clean architecture, layer separation, Provider pattern |
| 6 | **Execute** | Builds features in batches of 2-3 tasks, stops for questions | Hands-on coding with verification at every step |
| 7 | **Code Review** | Professional OSS-quality audit (SOLID, DRY, tests, coverage) | Code quality & real-world review practices |
| 8 | **Security Post-Flight** | Final security scan on completed code | Ensuring no regressions before release |
| 9 | **Quiz Show Finale** | 5-question TV-show-style quiz covering everything you built | Proving you understand every layer |

**After each stage**, the agent conversationally offers the next one:

> *"Project scaffolded! Now let's brainstorm features — what should your LG app visualize on Google Earth? Ready? 🧠"*

You say "ready" and it continues. No manual skill-hunting required.

---

## What You'll Build (Task 2 Minimum)

Every student must implement these 5 LG operations as a baseline:

| # | Operation | What It Does on the Rig |
|---|-----------|------------------------|
| 1 | **Send Logo** | Displays your app logo on the left slave screen as a KML ScreenOverlay |
| 2 | **Send 3D Pyramid** | Renders a colored extruded polygon on the master screen |
| 3 | **FlyTo Home City** | Camera smoothly flies to your chosen coordinates |
| 4 | **Clean Logos** | Removes overlays from slave screens |
| 5 | **Clean KMLs** | Clears all KML data from the entire rig |

**Plus**: Release APK, README with screenshots, and a demo video/GIF.

**Mandatory screens**: Splash → Connection → Main Dashboard → Settings → Help/About

Beyond the minimum, you can build: earthquake visualizers, satellite trackers, historical tours, AI-generated travel itineraries, and more.

---

## Project Structure

```
LGFlutterStarterKit/
├── flutter_client/                 # Flutter app (your starting point)
│   ├── lib/
│   │   ├── main.dart              # Entry point with MultiProvider setup
│   │   ├── config.dart            # LG rig connection configuration
│   │   ├── models/                # Immutable domain data classes
│   │   ├── providers/             # State management (SettingsProvider, ThemeProvider)
│   │   ├── screens/               # Phone controller UI
│   │   │   ├── splash_screen.dart
│   │   │   ├── connection_screen.dart
│   │   │   ├── main_screen.dart
│   │   │   ├── home_screen.dart
│   │   │   ├── settings_screen.dart
│   │   │   ├── help_screen.dart
│   │   │   └── workflow_flow_screen.dart
│   │   ├── services/              # Business logic layer
│   │   │   ├── lg_service.dart    # High-level LG facade (sendLogo, flyTo, etc.)
│   │   │   ├── ssh_service.dart   # Raw SSH commands to the rig
│   │   │   ├── kml_service.dart   # KML XML generation
│   │   │   ├── earthquake_service.dart  # Example API integration
│   │   │   └── socket_service.dart      # WebSocket to Node.js server
│   │   └── modules/              # Optional feature modules
│   └── pubspec.yaml
│
├── server/                        # Node.js companion server (optional)
│   ├── index.js                   # Express + WebSocket server
│   └── package.json
│
├── .agent/                        # Antigravity AI mentor system
│   ├── PROMPT.md                  # System instruction (paste into Gemini)
│   ├── skills/                    # 33 development skills (see below)
│   ├── workflows/                 # 4 pipeline workflows
│   └── rules/                     # 5 coding rules (enforced by the agent)
│
├── .github/workflows/             # CI/CD
│   ├── flutter-ci.yml             # Lint + test on every push
│   ├── flutter-build.yml          # Build APK on release
│   └── security-scan.yml          # Automated security scanning
│
├── docs/                          # Generated documentation
│   ├── plans/                     # Design docs & implementation plans
│   ├── reviews/                   # Code reviews & quiz reports
│   └── aimentor/                  # Advisory session logs
│
├── DEVELOPMENT_LOG.md             # Decision log
└── README.md                      # This file
```

---

## Layer Architecture (Strictly Enforced)

The agent enforces a 5-layer architecture. Every import is validated — violations block the pipeline.

```
┌─────────────────────────────────────────────────────┐
│  PRESENTATION   screens/, widgets/                   │
│  Reads state from Provider. Dispatches user actions. │
│  ❌ Cannot import: dartssh2, http, kml_service       │
├─────────────────────────────────────────────────────┤
│  ORCHESTRATION  services/lg_service.dart             │
│  Facade: coordinates KML + SSH + API operations.     │
├─────────────────────────────────────────────────────┤
│  DATA PROVIDERS services/*_service.dart, providers/  │
│  Fetch external data. Return domain models only.     │
├─────────────────────────────────────────────────────┤
│  KML GENERATION services/kml_service.dart            │
│  Produce KML XML from domain models. Stateless.      │
│  ❌ Cannot import: dartssh2, ssh_service              │
├─────────────────────────────────────────────────────┤
│  TRANSPORT      services/ssh_service.dart            │
│  Execute SSH commands to LG rig. No data logic.      │
│  ❌ Cannot import: kml_service, models/               │
└─────────────────────────────────────────────────────┘

Data flows ONE direction:
API → Provider → Domain Model → KML Generator → SSH Transport → LG Rig
```

---

## The 33 Agent Skills

### Pipeline Core (11 skills — the main learning path)
| Skill | Purpose |
|-------|---------|
| `lg-env-doctor` | Validates dev environment (Flutter, Dart, Git, JDK, etc.) |
| `lg-setup-guide` | OS-specific install commands for missing tools |
| `lg-shield` | Security scanner — pre-flight & post-flight |
| `lg-init` | Project initializer with naming conventions |
| `lg-flutter-init` | Flutter-specific bootstrapping |
| `lg-brainstormer` | Collaborative feature design |
| `lg-viz-architect` | Multi-screen visualization experience designer |
| `lg-plan-writer` | Implementation plan with 5-10 min tasks |
| `lg-exec` | Batch executor with mandatory student interaction |
| `lg-code-reviewer` | Professional OSS code review |
| `lg-quiz-master` | TV-show-style graduation quiz |

### Architecture & Building (7 skills)
| Skill | Purpose |
|-------|---------|
| `lg-data-pipeline` | API → Domain → KML → SSH pipeline generator |
| `lg-ui-scaffolder` | Flutter screen generator with Provider wiring |
| `lg-kml-craftsman` | Artistic KML composition (tours, 3D, animations) |
| `lg-kml-writer` | KML template writing & validation |
| `lg-logic-builder` | Service-layer logic implementation |
| `lg-file-generator` | Scaffolding file creation |
| `lg-ssh-controller` | SSH connection management & commands |

### Quality & Security (4 skills)
| Skill | Purpose |
|-------|---------|
| `lg-critical-advisor` | Global guardrail — challenges assumptions, prevents rushing |
| `lg-tester` | Unit/widget/integration test generation |
| `lg-debugger` | Diagnostic & troubleshooting |
| `lg-dependency-resolver` | Package conflict resolution |

### DevOps & Deployment (5 skills)
| Skill | Purpose |
|-------|---------|
| `lg-github-agent` | GitHub repo creation, branches, releases |
| `lg-flutter-build` | APK/IPA build management |
| `lg-devops-agent` | CI/CD pipeline setup |
| `lg-emulator-manager` | Android emulator launch & management |
| `lg-demo-recorder` | Screenshots, video, GIF capture for README |

### Converters & Integrations (3 skills)
| Skill | Purpose |
|-------|---------|
| `lg-api-integrator` | External API integration (USGS, NASA, etc.) |
| `lg-dart-converter` | JSON/XML to Dart model conversion |
| `lg-code-converter` | Language/framework translation |

### Teaching & Recovery (3 skills)
| Skill | Purpose |
|-------|---------|
| `lg-learning-resources` | Curated tutorials, docs, and YouTube videos per topic |
| `lg-resume-pipeline` | Session recovery — picks up where you left off |
| `lg-nanobanana-sprite` | AI image generation for logos & assets |

### 5 Enforced Rules
| Rule | What It Enforces |
|------|-----------------|
| `lg-architecture.md` | LG rig model, SSH communication, service layer |
| `flutter-best-practices.md` | Provider patterns, widget decomposition, const constructors |
| `layer-boundaries.md` | 5-layer import matrix, one-direction data flow |
| `kml-standards.md` | Valid KML structure, coordinate format, tour conventions |
| `dart-style.md` | Effective Dart naming, documentation, formatting |

---

## LG Rig Configuration

Default connection settings in `config.dart`:

| Setting | Default | Description |
|---------|---------|-------------|
| Host | `192.168.56.101` | LG Master machine IP |
| Port | `22` | SSH port |
| Username | `lg` | SSH username |
| Password | `lg` | SSH password |
| Screens | `3` | Total rig screens |

**Screen layout (3-screen rig)**:

```
┌──────────┐  ┌──────────┐  ┌──────────┐
│ Screen 3 │  │ Screen 1 │  │ Screen 2 │
│  (Left)  │  │ (Master) │  │  (Right) │
│  Logo ◄  │  │  Center  │  │          │
└──────────┘  └──────────┘  └──────────┘
```

---

## Dependencies

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

---

## Node.js Server (Optional)

A companion backend for data processing, API proxying, or WebSocket communication.

```bash
cd server
npm install
node index.js
# Server runs on http://localhost:3000
```

---

## Building & Deployment

```bash
# Debug APK (development)
cd flutter_client
flutter build apk --debug

# Release APK (contest submission)
flutter build apk --release

# With custom LG host
flutter build apk --dart-define=LG_HOST=192.168.56.101

# Run on connected device or emulator
flutter run
```

---

## How Does It Help Students?

### Problem: LG Development Is Hard to Start
Building a Liquid Galaxy app requires understanding SSH, KML, multi-screen rendering, Flutter state management, and a specific controller architecture. Most students spend weeks just getting the basics right.

### Solution: Guided Learning While Building
Antigravity doesn't just generate code — it **teaches** as it builds:

1. **Asks before doing** — Every stage starts with questions to check understanding
2. **Stops for checkpoints** — Won't proceed until you can explain what was built
3. **Links to resources** — Missed a quiz question? Get targeted tutorials and docs
4. **Enforces architecture** — The 5-layer boundary rules prevent bad habits from day one
5. **Catches rushing** — Says "just build it"? The Critical Advisor intervenes
6. **Generates documentation** — Plans, reviews, and a learning journal are created automatically
7. **Recovers from interruptions** — Session died? The resume skill picks up exactly where you stopped

### What You'll Know After Completing the Pipeline
- How SSH commands flow from your phone to Google Earth on the rig
- How to generate KML placemarks, tours, overlays, and 3D objects
- Clean Flutter architecture with Provider, service layer, and strict boundaries
- Professional code review practices (SOLID, DRY, testing, formatting)
- How to build and deploy a release APK with CI/CD

---

## Contest: 3-Repository Workflow

The **Gemini Summer of Code 2026 — Agentic Programming Contest** requires 3 deliverables:

| # | Repository | Description |
|---|-----------|-------------|
| 1 | **LGFlutterStarterKit** | This repo — template + `.agent/` system |
| 2 | **Student's App** (e.g., `LG-Task2-Demo`) | Your generated Flutter LG app (separate repo) |
| 3 | **Agent System** | The `.agent/` directory (skills + rules + workflows) — part of repo #1 |

**App Naming Convention**: All apps must follow `LG-<TaskName>` (e.g., `LG-Task2-Demo`, `LG-Earthquake-Viz`).

---

## Reference Implementations & Resources

| Resource | Link |
|----------|------|
| Lucia's LG Master Web App (reference controller) | [GitHub](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) |
| All Liquid Galaxy Lab Projects | [GitHub](https://github.com/LiquidGalaxyLAB) |
| GSoC 2026 Ideas | [liquidgalaxy.eu](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html) |
| LG Mobile Applications | [liquidgalaxy.eu](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html) |
| LG App Store | [store.liquidgalaxy.eu](https://store.liquidgalaxy.eu/) |
| LG Core Installation | [GitHub](https://github.com/LiquidGalaxyLAB/liquid-galaxy) |
| KML Reference (Google) | [developers.google.com](https://developers.google.com/kml/documentation/kmlreference) |
| Flutter Architecture | [docs.flutter.dev](https://docs.flutter.dev/app-architecture) |

---

## License

This project is part of the Liquid Galaxy GSoC initiative.
