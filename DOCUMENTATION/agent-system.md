# Agent System

> Complete reference for the 33-skill Antigravity agent system, 11-stage pipeline, 5 architecture rules, and 4 workflows.

---

## Table of Contents

- [Overview](#overview)
- [11-Stage Pipeline](#11-stage-pipeline)
- [Pipeline Stages in Detail](#pipeline-stages-in-detail)
- [Full Skill Roster (33 Skills)](#full-skill-roster-33-skills)
- [5 Architecture Rules](#5-architecture-rules)
- [4 Workflows](#4-workflows)
- [Critical Advisor — The Guardrail](#critical-advisor--the-guardrail)
- [Conversational Auto-Chain](#conversational-auto-chain)
- [Workflow Visualizer](#workflow-visualizer)

---

## Overview

The agent system is the core of this Antigravity package. It's a **33-skill AI mentor** powered by Google Gemini that guides students through the entire LG application development lifecycle — from environment setup to graduation quiz.

**Key principle:** The agent doesn't just generate code — it **teaches**. Every stage includes verification questions, architectural explanations, and mandatory checkpoints. Students must demonstrate understanding before the pipeline advances.

**Location:** `.agent/` directory containing:
- `PROMPT.md` — Master system prompt
- `skills/` — 33 YAML + Markdown skill definitions
- `rules/` — 5 architecture enforcement rules
- `workflows/` — 4 orchestration workflows

---

## 11-Stage Pipeline

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  Stage 1 │───►│  Stage 2 │───►│  Stage 3 │───►│  Stage 4 │───►│  Stage 5 │
│ Env      │    │ Shield   │    │ Init     │    │Brainstorm│    │ Viz      │
│ Doctor   │    │ (Pre)    │    │          │    │          │    │ Architect│
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
      │                                                               │
      ▼                                                               ▼
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Stage 11 │◄───│ Stage 10 │◄───│  Stage 9 │◄───│  Stage 8 │◄───│  Stage 6 │
│ Quiz     │    │ Shield   │    │ Code     │    │ Execute  │    │ Plan     │
│ (Finale) │    │ (Post)   │    │ Review   │    │          │    │ Writer   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
                                      │               ▲
                                      └──── revisions ┘
                                        needed (loop)

                    ┌──────────┐
                    │  Stage 7 │  (Data Pipeline + UI Scaffold)
                    │ Build    │
                    └──────────┘
```

**Helper skills** (Critical Advisor, Dependency Resolver, Resume Pipeline, Learning Resources, Demo Recorder) are active throughout the entire pipeline.

---

## Pipeline Stages in Detail

### Stage 1 — Environment Doctor (`lg-env-doctor`)

**Purpose:** Validates the developer's environment before any code is written.

**Checks:**
- Flutter SDK installed and on PATH
- Dart SDK version ≥ 3.0.0
- Git installed and configured
- JDK 17 installed
- Android SDK configured
- SSH client available
- Connected device / emulator

**Behavior:** Blocks the pipeline until all checks pass. Provides fix instructions for each failure.

---

### Stage 2 — Security Pre-Flight (`lg-shield`)

**Purpose:** Scans the project for security issues before development begins.

**Checks:**
- No hardcoded secrets (passwords, API keys, tokens)
- `.gitignore` properly configured
- `flutter_secure_storage` used for sensitive data
- No private keys in version control

**Behavior:** Reports issues as warnings or blockers. Critical issues block the pipeline.

---

### Stage 3 — Initialize (`lg-init`)

**Purpose:** Scaffolds a new LG application from the starter kit template.

**Actions:**
- Creates app in a **separate directory** (`LG-<TaskName>`)
- Runs `flutter create .` to generate platform directories
- Scaffolds the 5-layer architecture
- Initializes Git repository
- Creates GitHub remote via `lg-github-agent`

**Key point:** The app is created *outside* the starter kit repo — the template stays clean.

---

### Stage 4 — Brainstorm (`lg-brainstormer`)

**Purpose:** Collaborative design session focusing on the LG experience.

**Explores:**
- What data will be visualized on Google Earth?
- Which external APIs provide the data?
- What KML elements are needed (placemarks, tours, overlays, 3D)?
- How will it look across 3/5/7 screens?
- Architectural tradeoffs and performance considerations

**Checkpoint:** Student must articulate their app's core value proposition and data flow.

---

### Stage 5 — Viz Architect (`lg-viz-architect`)

**Purpose:** Designs the multi-screen Google Earth experience.

**Outputs:**
- Screen storyboard (which screen shows what)
- KML element inventory
- Camera tour sequence
- Performance budget (KML complexity limits)
- Data refresh strategy

---

### Stage 6 — Plan Writer (`lg-plan-writer`)

**Purpose:** Creates a detailed implementation roadmap.

**Format:**
- Tasks broken into 5-10 minute chunks
- Each task has clear start/end criteria
- Educational checkpoints embedded between tasks
- Dependencies mapped

---

### Stage 7 — Data Pipeline + UI Scaffold (`lg-data-pipeline` + `lg-ui-scaffolder`)

**Purpose:** Wires the full data pipeline and generates Flutter screens.

**Data Pipeline:**
- API client → model class → KML generation method → SSH upload wrapper
- Demonstrates the API → Model → KML → SSH pattern

**UI Scaffold:**
- Generates Flutter screens with Provider wiring
- Pre-connects screens to LGService methods
- Follows Material 3 design guidelines

---

### Stage 8 — Execute (`lg-exec`)

**Purpose:** Guided implementation in batches of 2-3 tasks.

**Behavior:**
- Implements 2-3 tasks, then **stops**
- Asks a verification question about what was just built
- **Will not auto-continue** — student must answer correctly
- If the answer shows misunderstanding → explains and re-asks

This is the largest stage and produces most of the application code.

---

### Stage 9 — Code Review (`lg-code-reviewer`)

**Purpose:** Professional OSS-grade code audit.

**Checks:**
- SOLID principles compliance
- DRY — no duplicated logic
- `flutter analyze` — zero errors/warnings
- `dart format` — consistent formatting
- 80%+ test coverage target
- Documentation completeness

**Behavior:** May loop back to Stage 8 if revisions are needed.

---

### Stage 10 — Security Post-Flight (`lg-shield`)

**Purpose:** Final security scan on the completed codebase.

**Same checks as Stage 2**, plus:
- Verifies all user-entered secrets use `FlutterSecureStorage`
- No API keys leaked in committed code
- No `print()` statements exposing sensitive data

**Behavior:** Blocks graduation if critical issues are found.

---

### Stage 11 — Quiz (`lg-quiz-master`)

**Purpose:** The "TV Show" finale — 5 high-stakes questions.

**Topics:**
1. SSH pipeline (how data flows from Flutter to the rig)
2. KML constructs (coordinate order, element types)
3. Engineering principles (SOLID, service layer pattern)
4. Performance (KML complexity, refresh strategies)
5. Architecture (5-layer boundaries, import rules)

**Scoring:** Must pass to "graduate" — the agent celebrates success with a summary of what was learned.

---

## Full Skill Roster (33 Skills)

### Pipeline Core (11 skills)

| Skill | Purpose |
|-------|---------|
| `lg-env-doctor` | Environment validation (Flutter, Dart, Git, JDK, Android SDK) |
| `lg-setup-guide` | Step-by-step setup instructions for missing tools |
| `lg-shield` | Security scanning (pre-flight and post-flight) |
| `lg-init` | Project scaffolding from starter kit template |
| `lg-flutter-init` | Flutter-specific initialization (pubspec, analysis options) |
| `lg-brainstormer` | Collaborative design and ideation |
| `lg-viz-architect` | Multi-screen visualization design |
| `lg-plan-writer` | Implementation roadmap with checkpoints |
| `lg-exec` | Guided implementation in batches |
| `lg-code-reviewer` | Professional code audit |
| `lg-quiz-master` | Graduation quiz (5 questions) |

### Architecture (7 skills)

| Skill | Purpose |
|-------|---------|
| `lg-data-pipeline` | API → Model → KML → SSH pipeline wiring |
| `lg-ui-scaffolder` | Flutter screen generation with Provider wiring |
| `lg-kml-craftsman` | Advanced KML element creation |
| `lg-kml-writer` | KML file writing and formatting |
| `lg-logic-builder` | Business logic implementation |
| `lg-file-generator` | File scaffolding and boilerplate generation |
| `lg-ssh-controller` | SSH command patterns and lifecycle |

### Quality (4 skills)

| Skill | Purpose |
|-------|---------|
| `lg-critical-advisor` | **Guardrail** — intervenes if student rushes or skips learning |
| `lg-tester` | Test writing (unit, widget, integration) |
| `lg-debugger` | Debugging assistance and error analysis |
| `lg-dependency-resolver` | Package version conflicts and compatibility |

### DevOps (5 skills)

| Skill | Purpose |
|-------|---------|
| `lg-github-agent` | GitHub repo creation, branching, PR management |
| `lg-flutter-build` | APK build optimization and signing |
| `lg-devops-agent` | CI/CD pipeline setup (GitHub Actions) |
| `lg-emulator-manager` | Android emulator setup and management |
| `lg-demo-recorder` | Demo video recording guidance |

### Converters (3 skills)

| Skill | Purpose |
|-------|---------|
| `lg-api-integrator` | External API integration patterns |
| `lg-dart-converter` | Data model serialization (JSON ↔ Dart) |
| `lg-code-converter` | Code pattern migration and refactoring |

### Teaching (3 skills)

| Skill | Purpose |
|-------|---------|
| `lg-learning-resources` | Curated learning materials and references |
| `lg-resume-pipeline` | Resume pipeline from saved state |
| `lg-nanobanana-sprite` | Creative encouragement and morale |

---

## 5 Architecture Rules

Rules are enforced **at all times** during agent operation. Any code generated by the agent must comply.

### 1. `lg-architecture.md`

**Enforces:**
- Client-to-Rig model (app sends data, rig renders)
- SSH as the sole communication channel
- Service layer pattern (screens never touch SSH/KML)
- Proper resource lifecycle (connect/disconnect/dispose)

### 2. `flutter-best-practices.md`

**Enforces:**
- Provider + ChangeNotifier state management
- Widget decomposition (no monolithic build methods)
- `const` constructors where possible
- Material 3 design compliance

### 3. `layer-boundaries.md`

**Enforces:**
- 5-layer import matrix (no cross-layer imports)
- One-direction data flow
- KML layer has zero dependencies
- Transport layer has zero domain knowledge

### 4. `kml-standards.md`

**Enforces:**
- Valid KML 2.2 structure
- `longitude,latitude,altitude` coordinate order (not `lat,lon`)
- Standard tour conventions (`<gx:Tour>`, `<gx:FlyTo>`)
- Empty KML for clearing (not file deletion)

### 5. `dart-style.md`

**Enforces:**
- Effective Dart naming conventions
- `///` documentation comments on all public APIs
- `dart format` compliance
- Meaningful variable and method names

---

## 4 Workflows

| Workflow | Purpose |
|----------|---------|
| **Main Pipeline** | The 11-stage sequence from env setup to graduation |
| **Quick Start** | Abbreviated pipeline for experienced developers |
| **Resume** | Picks up from the last checkpoint after interruption |
| **Review Only** | Code review + security scan without full pipeline |

---

## Critical Advisor — The Guardrail

The `lg-critical-advisor` skill is **always active** throughout every stage. It monitors for:

- **Rushing:** Asking to skip stages or "just build it"
- **Copy-pasting:** Accepting code without understanding
- **Skipping checkpoints:** Trying to advance without answering verification questions
- **Architecture violations:** Attempting to bypass layer boundaries

**When triggered:**
> *"⚠️ Hold on — before we move forward, can you explain why LGService calls KMLService.generateFlyTo() instead of creating the KML XML directly in the screen? This is a core architectural concept."*

The student must demonstrate understanding before the pipeline resumes.

---

## Conversational Auto-Chain

After each stage completes, the agent **automatically offers** the next one:

> *"✅ Environment validated! All tools detected.*
> *Next: Security Pre-Flight — I'll scan for any hardcoded secrets before we start coding.*
> *Ready? 🛡️"*

The student just says **"ready"** and the pipeline flows. No manual skill selection required.

If the student asks an unrelated question mid-pipeline, the agent answers it, then gently steers back:

> *"Great question about KML coordinates! Remember, Google Earth uses longitude,latitude,altitude — not lat,lon.*
> *Now, shall we continue with the Brainstorm stage?"*

---

## Workflow Visualizer

The starter kit includes an interactive **n8n-style pipeline visualizer** accessible from the app's Workflow screen (`/workflow` route).

**Features:**
- 20 nodes across 5 rows (pipeline stages + checkpoints + helper skills)
- 16 edges with bezier curves (forward flow + 1 conditional feedback loop)
- Pinch-to-zoom (0.15x – 2.5x)
- Tap any node → bottom sheet with: icon, tag, description, skill path, checkpoint question, "Next →" chips
- Color-coded legend: Stage (blue) / Checkpoint (purple) / Helper (grey) / Trigger (green)

This visualizer shows students exactly where they are in the pipeline and what comes next.
