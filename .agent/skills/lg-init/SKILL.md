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

**The new app MUST be created as a sibling directory inside the Antigravity workspace, NOT inside `LGFlutterStarterKit`.**

The starter kit is a **template/reference** — it stays untouched. The new app gets its own directory and its own Git repo, but BOTH live inside the same workspace so the student can see them side-by-side in their IDE.

```
~/.gemini/antigravity/scratch/            ← ANTIGRAVITY WORKSPACE ROOT
├── LGFlutterStarterKit/                  ← THIS STAYS UNTOUCHED (template)
│   ├── .agent/                            ← Agent skills, rules, workflows
│   ├── flutter_client/                    ← Reference implementation
│   └── ...
└── LG-Task2-Demo/                        ← NEW APP GOES HERE (separate repo)
    ├── flutter_client/
    ├── docs/
    ├── .github/
    ├── README.md
    └── ...
```

**After creating the app directory, add it to the IDE workspace** so the student sees both repos in the file explorer.

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

### ⛔ WITHIN-PHASE INTERACTION RULES

> **DO NOT silently create the project directory and all files.**
> Explain WHAT you're about to create and WHY before doing it.
> Pause after each significant step for student acknowledgment.

### Step 1: Explain and Confirm Project Location

**First, explain to the student what will happen:**
> *"I'm going to create your LG app as a sibling directory next to the starter kit — inside the same Antigravity workspace. Both repos will be visible in your IDE side-by-side. Here's the layout:"*

```bash
# The Antigravity workspace root
WORKSPACE_ROOT=$(dirname "$STARTER_KIT")   # ~/.gemini/antigravity/scratch/

# The starter kit location
STARTER_KIT=$(pwd)   # e.g., ~/.gemini/antigravity/scratch/LGFlutterStarterKit

# New app goes as a SIBLING inside the same workspace
APP_NAME="LG-Task2-Demo"   # Must follow LG-<TaskName> convention
APP_DIR="$WORKSPACE_ROOT/$APP_NAME"
```

**Tell the student the exact path:**
> *"Your new project will live at: `~/.gemini/antigravity/scratch/LG-Task2-Demo/`"*
> *"The starter kit stays untouched at: `~/.gemini/antigravity/scratch/LGFlutterStarterKit/`"*
> *"Both will be visible in your IDE workspace."*

Ask: *"This means your app code and the mentor's skills live side-by-side. Does this workspace layout make sense? Any questions about why we keep them separate but within reach?"*

⛔ **STOP and WAIT** for the student's response.

### Step 2: Create the New App Directory
```bash
mkdir -p "$APP_DIR"
cd "$APP_DIR"
```

**Tell the student:**
> *"📂 Created directory: `~/.gemini/antigravity/scratch/LG-Task2-Demo/`"*
> *"To navigate here yourself: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo`"*

### Step 3: Copy Starter Kit Scaffolding

**Explain what's being copied:**
> *"I'm copying the Flutter client template, docs structure, GitHub workflows, and server as a starting point. I'll walk you through the structure after."*

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

**After copying, show the student exactly what was created with full paths:**

```
📁 Files created:
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client/  (Flutter app template)
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/server/          (Node.js backend)
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/docs/plans/      (Design & plan docs)
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/docs/screenshots/ (Demo evidence)
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/.github/          (CI/CD workflows)
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/README.md
  ✅ ~/.gemini/antigravity/scratch/LG-Task2-Demo/DEVELOPMENT_LOG.md
```

> *"Here's what we just created. `flutter_client/` is your main app code, `docs/` is where plans and reviews go, `server/` is the Node.js backend. Each folder has a specific purpose."*

Ask: *"Can you guess which folder your SSH service code will go in? Which folder will your screen widgets live in?"*

⛔ **STOP and WAIT** for the student's answer. This confirms they understand the project structure.

### Step 4: Initialize Git
```bash
cd "$APP_DIR"
git init
git add .
git commit -m "init: project scaffolding from LGFlutterStarterKit"
```

**Tell the student:**
> *"💻 Terminal command: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo && git init && git add . && git commit -m 'init: project scaffolding from LGFlutterStarterKit'`"*
> *"Git repo initialized with your first commit. To check status: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo && git log --oneline`"*

### Step 5: Add to IDE Workspace

**CRITICAL: Make both repos visible in the IDE.**

> *"I'm adding your new app to the current workspace so you can see both repos in the file explorer:"*
> *"📂 Workspace now contains:"*
> *"  1. `LGFlutterStarterKit/` — The template + agent skills"*
> *"  2. `LG-Task2-Demo/` — Your app (this is where we'll work)"*

If using VS Code, add the folder to the workspace. If using another IDE, tell the student how to open both directories.

### Step 6: Create GitHub Repo
Hand off to `.agent/skills/lg-github-agent/SKILL.md` to:
1. Create a new GitHub repo with the app name
2. Set origin remote
3. Push initial commit
4. Set up branch protection and templates

**Tell the student the GitHub URL:**
> *"GitHub repo created: `https://github.com/<username>/LG-Task2-Demo`"*
> *"To push manually: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo && git push -u origin main`"*

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

**First, explain the layered architecture:**

> *"Your Flutter app uses a layered architecture — each folder has a specific responsibility. Let me walk you through it:"*

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

Ask: *"Looking at this structure — which folder do you think handles SSH communication to the rig? Which folder should NEVER import SSH or KML code directly?"*

⛔ **STOP and WAIT** for the student's answer. This tests layer boundary understanding early.

### Actions:
1. Create missing directories + `test/`, `assets/`.
2. `flutter pub get`
3. `flutter doctor`
4. If platforms missing: `flutter create --platforms=android,ios,linux,macos .`

**After running the commands**, report the results and ask:
> *"Flutter is set up. `flutter doctor` shows [summary]. Any issues you notice that we should fix before moving on?"*

⛔ **STOP and WAIT.**

## Phase 3: Configuration

**Explain before configuring:**
> *"Now I'll set up the LG rig connection defaults in `config.dart` and add the packages we need in `pubspec.yaml`. These packages are:"*
> - `dartssh2` — SSH to communicate with the LG rig master (pure Dart)
> - `xml` — KML generation and parsing
> - `google_maps_flutter` — In-app map for location picking and flyTo targets
> - `provider` — State management (UI reads state from providers)
> - `shared_preferences` — Persistent connection settings (rig IP, port, user)
> - `flutter_secure_storage` — Encrypted password storage
> - `path_provider` — File system access for KML temp files
> - `http` — API calls for external data
> - `web_socket_channel` — WebSocket for Node.js server

**📋 REFERENCE**: See `demo/DEPENDENCIES.md` in the starter kit for the full verified plugin stack with exact versions, platform compatibility matrix, and a ready-to-use `pubspec.yaml` template.

Ask: *"Can you guess which of these packages our SSH service will use? And which one will the KML service use? (Hint: think about layer boundaries)"*

⛔ **STOP and WAIT.** This validates the student understands which service uses which dependency.

Update `config.dart` with LG connection defaults. Update `pubspec.yaml` using the versions from `demo/DEPENDENCIES.md`.

## Phase 4: Golden Rules (CONVERSATIONAL — NOT A LECTURE)

⛔ **DO NOT dump all 3 rules in one message.** Present each rule as a conversation:

**Rule 1 — App is Controller:**
> *"The most important concept: your Flutter app is a REMOTE CONTROL. It runs on your phone. Google Earth runs on the rig. Your app sends COMMANDS, the rig DISPLAYS."*

Ask: *"If the app is just a remote control, what does the app NOT need to do? What heavy lifting does Google Earth handle?"*

⛔ **STOP and WAIT.**

**Rule 2 — Google Earth is Display:**
> *"When you send a KML file to the rig, Google Earth automatically renders it across ALL screens. You don't need to manage multi-screen layout — Google Earth does that for you."*

Ask: *"So if we want something to appear on the left screen vs. the center screen — how do we control that? (Hint: it's about which slave file you write to)"*

⛔ **STOP and WAIT.**

**Rule 3 — Service Layer:**
> *"All SSH, KML, and API logic lives in the `services/` folder — NEVER in widgets or screens. This is called separation of concerns."*

Ask: *"Why is this important? What would go wrong if we put SSH code directly in a button's onPressed handler?"*

⛔ **STOP and WAIT.**

**Reference Architecture**: [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) by Lucia — the reference implementation for all LG controller apps.

**LG Official Resources**:
- [Liquid Galaxy LAB](https://github.com/LiquidGalaxyLAB) — All GSoC LG projects
- [LG Mobile Applications](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html) — Official app showcase
- [GSoC 2026 Ideas](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html) — Current project ideas

## Execution
1. Gather requirements.
2. Recommend logo/assets via Nano Banana.
3. Create/modify files — **show full paths for every file created**.
4. `flutter pub get && flutter analyze`.
   > *"🖥️ Terminal: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client && flutter pub get && flutter analyze`"*
5. Commit: `init: LG Flutter project scaffolding`.
   > *"🖥️ Terminal: `cd ~/.gemini/antigravity/scratch/LG-Task2-Demo && git add . && git commit -m 'init: LG Flutter project scaffolding'`"*
6. **Summary block — show everything created:**
   ```
   📁 Project created at: ~/.gemini/antigravity/scratch/LG-Task2-Demo/
   📂 Flutter app: ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client/
   📂 Docs: ~/.gemini/antigravity/scratch/LG-Task2-Demo/docs/
   📂 Server: ~/.gemini/antigravity/scratch/LG-Task2-Demo/server/
   🌐 GitHub: https://github.com/<user>/LG-Task2-Demo
   🖥️ To run: cd ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client && flutter run
   ```
7. **Ask the student**: *"The project is scaffolded. Before we brainstorm features, can you explain: What is the relationship between the Flutter app on your phone and Google Earth on the LG rig?"*
8. If the student cannot answer, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md) — Architecture topic.
9. Hand to **Brainstormer** (.agent/skills/lg-brainstormer/SKILL.md).

## 🔗 Skill Chain

After scaffolding is complete and the student passes the checkpoint, **automatically offer the next stage**:

> *"Project scaffolded and committed! You clearly understand the Controller-to-Rig model. Now let's brainstorm features — what should your LG app visualize on Google Earth? Ready to brainstorm? 🧠"*

If student says "ready" → activate `.agent/skills/lg-brainstormer/SKILL.md`.
