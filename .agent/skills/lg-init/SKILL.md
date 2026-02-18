---
name: lg-init
description: Helps students bootstrap a new Liquid Galaxy Flutter project. Enforces LG naming convention, recommends logo/assets via Nano Banana, configures rig connection, and creates the app in a separate directory with its own Git repo.
---

# Liquid Galaxy Project Initializer

First step in the pipeline: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**.

**⚠️ PROMINENT GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) and **LG Shield** (.agent/skills/lg-shield/SKILL.md) are always active. If the student rushes or can't explain the LG architecture, STOP and invoke the Critical Advisor.

---

## Contest: 3-Repository Workflow

This starter kit supports the **Gemini Summer of Code 2026 — Agentic Programming Contest** structure:

| Repository | Purpose | Who Owns It |
|-----------|---------|-------------|
| **LGFlutterStarterKit** | Template + `.agent/` agent system | Contest organizer / team |
| **Student's Demo App** (e.g., `LG-Task2-Demo`) | The actual LG Flutter app | Student's GitHub account |
| **Agent System** (`.agent/` inside StarterKit) | Skills, rules, workflows that power Antigravity | Submitted as part of StarterKit |

The student's generated app is **deliverable #2**. It must be in its own repo, buildable, and demonstrate LG control.

---

## CRITICAL: Separate Directory Rule

**The new app MUST be created in a separate directory, NOT inside `LGFlutterStarterKit`.**

The starter kit is a **template/reference** — it stays untouched. The new app gets its own directory and its own Git repo.

```
parent_directory/
├── LGFlutterStarterKit/          ← THIS STAYS UNTOUCHED (template)
│   ├── .agent/                    ← Agent skills, rules, workflows
│   ├── flutter_client/            ← Reference implementation
│   └── ...
└── LG-Task2-Demo/                ← NEW APP GOES HERE (separate repo)
    ├── flutter_client/
    ├── docs/
    ├── .github/
    ├── README.md
    └── ...
```

---

## CRITICAL: LG App Naming Convention

**All generated apps MUST follow this naming pattern:**

```
LG-<TaskName>
```

**Examples:**
- `LG-Task2-Demo` — For the basic Task 2 deliverable
- `LG-Earthquake-Viz` — For an earthquake visualizer
- `LG-Satellite-Tracker` — For a satellite tracking app
- `LG-Historic-Tours` — For a historical exploration app

**Rules:**
1. **Always prefix with `LG-`** — identifies it as a Liquid Galaxy app
2. **Use PascalCase** after the prefix (no underscores, no spaces)
3. **Be descriptive** — the name should tell you what the app does
4. **NOT acceptable**: `my_app`, `flutter_test`, `earthquake_app`, `lg_demo`
5. The Flutter package name in `pubspec.yaml` should be snake_case: `lg_task2_demo`

---

## Phase 0: Repository Setup

### Step 1: Determine Project Location
```bash
# The starter kit location
STARTER_KIT=$(pwd)   # e.g., /Users/user/.gemini/antigravity/scratch/LGFlutterStarterKit

# New app goes in a SIBLING directory
PARENT_DIR=$(dirname "$STARTER_KIT")
APP_NAME="LG-Task2-Demo"   # Must follow LG-<TaskName> convention
APP_DIR="$PARENT_DIR/$APP_NAME"
```

### Step 2: Create the New App Directory
```bash
mkdir -p "$APP_DIR"
cd "$APP_DIR"
```

### Step 3: Copy Starter Kit Scaffolding
```bash
# Copy the Flutter client as a starting point
cp -r "$STARTER_KIT/flutter_client" "$APP_DIR/flutter_client"

# Copy docs structure
mkdir -p docs/plans docs/reviews docs/aimentor docs/screenshots docs/recordings docs/gifs

# Copy workflow files for CI/CD
cp -r "$STARTER_KIT/.github" "$APP_DIR/.github"

# Copy .gitignore
cp "$STARTER_KIT/.gitignore" "$APP_DIR/.gitignore"

# Copy node_server if needed
cp -r "$STARTER_KIT/server" "$APP_DIR/server" 2>/dev/null || true

# Create fresh README and DEVELOPMENT_LOG
touch README.md DEVELOPMENT_LOG.md
```

### Step 4: Initialize Git
```bash
cd "$APP_DIR"
git init
git add .
git commit -m "init: project scaffolding from LGFlutterStarterKit"
```

### Step 5: Create GitHub Repo
Hand off to `.agent/skills/lg-github-agent/SKILL.md` to:
1. Create a new GitHub repo with the app name
2. Set origin remote
3. Push initial commit
4. Set up branch protection and templates

---

## Phase 1: Requirement Gathering

**Ask the student these questions ONE AT A TIME.** Wait for each answer before asking the next.

1. **Project Name**: *"What should we name this app? It must follow the `LG-<TaskName>` convention. For Task 2, I'd recommend `LG-Task2-Demo`. For a custom project, describe what it visualizes."*

2. **LG Rig Config**: *"How many screens does your target LG rig have? (3 is the default for Task 2)"*

3. **App Type**: *"What kind of LG app are you building?"*
   - `Task 2 Demo`: Minimum features (logo, pyramid, flyTo, clean) — contest requirement
   - `Data Visualization`: Live data on Google Earth (earthquakes, weather, satellites)
   - `Educational`: Guided tours, historical explorations, information balloons
   - `Controller`: Rig management dashboard

4. **Platforms**: Android (primary — required for release APK), plus optionally iOS, Linux, macOS.

5. **External APIs**: USGS, NASA, OpenWeather, custom, or none (Task 2 = none).

6. **Tooling confirm**: `flutter analyze`, `flutter test`, `dart format`.

---

## Phase 1.5: Logo & Asset Guidance

**After requirements, recommend visual assets:**

> *"Every LG app needs a logo for the ScreenOverlay on the slave screen and an app icon. I recommend using the **Nano Banana Asset Master** to generate these. Here's what we need:"*

| Asset | Purpose | Spec |
|-------|---------|------|
| **App Logo** | ScreenOverlay on left slave screen | 1024×512 PNG, transparent background |
| **Placemark Icon** | Custom marker for data points | 512×512 PNG, transparent background |
| **App Icon** | Android launcher icon | 1024×1024, follows Android adaptive icon spec |

**For Task 2**: The logo is sent to the left slave screen (screen 3 in a 3-screen rig) as a `<ScreenOverlay>` KML element. It should include the project name and optionally the LG logo.

**Generation**: Use `.agent/skills/lg-nanobanana-sprite/SKILL.md` — it provides prompts with green-screen background removal for clean transparent PNGs.

**Reference**: See how Lucia handles the logo overlay in [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App).

---

## Phase 2: Scaffolding

```
flutter_client/lib/
├── main.dart         # Provider setup, entry point
├── config.dart       # LG rig connection config
├── constants/        # App-wide constants
├── models/           # Data models
├── screens/          # UI screens (phone controller UI)
├── services/         # Business logic (SSH, KML, API)
├── widgets/          # Reusable components
└── modules/          # Feature modules
```

### Actions:
1. Create missing directories + `test/`, `assets/`.
2. `flutter pub get`
3. `flutter doctor`
4. If platforms missing: `flutter create --platforms=android,ios,linux,macos .`

## Phase 3: Configuration
Update `config.dart` with LG connection defaults. Update `pubspec.yaml` with:
- `provider`, `http`, `dartssh2`, `xml`, `path_provider`, `shared_preferences`

## Phase 4: Golden Rules

Explain these to the student:

1. **App is Controller** — Flutter app runs on the phone, controls the LG rig via SSH.
2. **Google Earth is Display** — KML renders across all rig screens automatically.
3. **Service Layer** — All SSH/KML/API logic in services, not in widgets.

**Reference Architecture**: [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) by Lucia — the reference implementation for all LG controller apps.

**LG Official Resources**:
- [Liquid Galaxy LAB](https://github.com/LiquidGalaxyLAB) — All GSoC LG projects
- [LG Mobile Applications](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html) — Official app showcase
- [GSoC 2026 Ideas](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html) — Current project ideas

## Execution
1. Gather requirements.
2. Recommend logo/assets via Nano Banana.
3. Create/modify files.
4. `flutter pub get && flutter analyze`.
5. Commit: `init: LG Flutter project scaffolding`.
6. **Ask the student**: *"The project is scaffolded. Before we brainstorm features, can you explain: What is the relationship between the Flutter app on your phone and Google Earth on the LG rig?"*
7. If the student cannot answer, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md) — Architecture topic.
8. Hand to **Brainstormer** (.agent/skills/lg-brainstormer/SKILL.md).

## 🔗 Skill Chain

After scaffolding is complete and the student passes the checkpoint, **automatically offer the next stage**:

> *"Project scaffolded and committed! You clearly understand the Controller-to-Rig model. Now let's brainstorm features — what should your LG app visualize on Google Earth? Ready to brainstorm? 🧠"*

If student says "ready" → activate `.agent/skills/lg-brainstormer/SKILL.md`.
