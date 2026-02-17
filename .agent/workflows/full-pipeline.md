---
name: Full Pipeline
description: The complete 10-stage educational pipeline from security pre-flight through graduation, with mandatory student interaction checkpoints between stages.
---

# Full Pipeline Workflow

## Overview
Executes the complete LG educational pipeline in order. This is the recommended workflow for students going through the full learning experience. The pipeline includes environment validation, security bookends, strict layer boundary enforcement, and automatic resume on interruption.

**CRITICAL**: This pipeline is designed for the **Gemini Summer of Code 2026 — Agentic Programming Contest**. The generated app follows the `LG-<TaskName>` naming convention and is created in a **separate directory** from the starter kit.

---

## ⛔️ MANDATORY: Student Interaction Policy

> **The agent MUST pause and wait for the student's response between EVERY stage.**
> DO NOT chain stages together automatically.
> Each stage transition includes a **Student Checkpoint** (marked with ⛔️).
> If the student says "just do it all" or "skip ahead," trigger the Critical Advisor.

---

## The 11 Stages

```
+--------+   +--------+   +------+   +--------+   +------+   +---------+
|  Env   |-->| Shield |-->| Init |-->| Brain- |-->| Viz  |-->|  Plan   |
| Doctor |   | (pre)  |   |      |   | storm  |   | Arch |   |         |
+--------+   +--------+   +------+   +--------+   +------+   +---------+
                                                                   |
+---------+   +--------+   +------+   +---------+   +-----------+  |
|  Quiz   |<--| Shield |<--| Re-  |<--|Execute +|<--| UI Scaff  |<-+
|         |   | (post) |   | view |   |KML Craft|   | +Data Pipe|
+---------+   +--------+   +------+   +---------+   +-----------+

Cross-cutting (active at ALL stages):
  +-------------------+   +------------------+   +-----------------+
  | Critical Advisor  |   | Dependency       |   | Resume Pipeline |
  | (rigor, security) |   | Resolver (fixes) |   | (checkpoints)   |
  +-------------------+   +------------------+   +-----------------+
```

### Pre-Stage: Environment Doctor
**Skill**: `.agent/skills/lg-env-doctor/SKILL.md`
- Detect host OS (macOS / Linux distro / Windows WSL)
- Check all required tools: Flutter, Dart, Git, JDK 17, Android SDK, SSH, Node.js
- Produce health report table (PASS / WARN / MISSING per tool)
- **If MISSING required tools** → hand off to `.agent/skills/lg-setup-guide/SKILL.md`
- Setup Guide provides OS-specific install commands with multiple methods per tool
- After install → re-run doctor to confirm all PASS
- **BLOCKS pipeline if required tools are missing**
- Saves checkpoint to `docs/pipeline-checkpoint.yaml` via `.agent/skills/lg-resume-pipeline/SKILL.md`

### Stage 0: Security Pre-Flight
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Scan for hardcoded secrets, exposed API keys
- Validate `.gitignore` covers credentials and build artifacts
- Verify `flutter_secure_storage` present if app handles credentials
- Check layer boundary compliance on existing code
- **BLOCKS pipeline if critical issues found**

### Stage 1: Init
**Skill**: `.agent/skills/lg-init/SKILL.md` + `.agent/skills/lg-flutter-init/SKILL.md`
- **Enforce LG-<TaskName> naming convention** (e.g., `LG-Task2-Demo`)
- **Create new app in a SEPARATE sibling directory** (NOT inside LGFlutterStarterKit)
- Gather requirements (project name, screens, platforms, APIs) — one question at a time
- **Recommend logo/assets** via `lg-nanobanana-sprite`
- Copy starter kit scaffolding into new directory
- Initialize Git repo + create GitHub repo via `lg-github-agent`
- Scaffold directory structure with layered architecture
- Install dependencies
- Verify toolchain
- All subsequent stages operate in the NEW app directory

> ⛔️ **Student Checkpoint**: *"The project is scaffolded. Explain: What is the relationship between the Flutter app on your phone and Google Earth on the LG rig?"*

### Stage 2: Brainstorm
**Skill**: `.agent/skills/lg-brainstormer/SKILL.md`
- Explore the idea collaboratively
- Reference real LG projects: [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App), [LG LAB repos](https://github.com/LiquidGalaxyLAB)
- Propose 2-3 approaches with trade-offs
- Apply SOLID and DRY principles to design choices
- Select optimal design
- Document in `docs/plans/`

> ⛔️ **Student Checkpoint**: *"Describe the data flow in your own words: where does data come from, how becomes KML, how reaches Google Earth?"*

### Stage 3: Visualization Design
**Skill**: `.agent/skills/lg-viz-architect/SKILL.md`
- Design the multi-screen experience storyboard
- Map data to KML elements (placemarks, tours, overlays, time animations)
- Define phone-to-rig interaction mapping
- Set performance budget (max placemarks, KML size, tour duration)
- Document in `docs/plans/`

### Stage 4: Plan
**Skill**: `.agent/skills/lg-plan-writer/SKILL.md`
- Break design into bite-sized tasks
- Define file paths and code patterns per layer
- **MANDATORY**: Educational Verification Phase
- Save plan to `docs/plans/`

> ⛔️ **Student Checkpoint**: *"Before we start coding — why does SSH logic belong in a service and not in a widget? What principle is that?"*

### Stage 5: Data Pipeline Setup
**Skill**: `.agent/skills/lg-data-pipeline/SKILL.md`
- Define provider contracts for external APIs
- Create domain models (immutable, no side effects)
- Wire API -> Domain -> KML -> Transport flow
- Validate boundary compliance

### Stage 6: UI Scaffolding + KML Crafting
**Skills**: `.agent/skills/lg-ui-scaffolder/SKILL.md` + `.agent/skills/lg-kml-craftsman/SKILL.md`
- Generate controller screens (no network/KML/SSH imports in UI)
- Compose artistic KML visualizations (3D extrusions, time animations, tours)
- Wire screens to services via Provider

### Stage 7: Execute
**Skill**: `.agent/skills/lg-exec/SKILL.md`
- Execute tasks in batches of 2-3 **MAX**
- **MANDATORY**: Stop after each batch for student verification question
- **DO NOT auto-continue** — wait for student's answer before next batch
- Verify after each batch: `flutter analyze`, `flutter test`
- **Launch emulator** via `lg-emulator-manager` to visually validate each batch
- Learning journal after each batch
- Commit after each task
- Push to GitHub remote after each batch

> ⛔️ **Student Checkpoint (per batch)**: Verification question about what was just built. See lg-exec for the full interaction protocol.

### Stage 8: Review
**Skill**: `.agent/skills/lg-code-reviewer/SKILL.md`
- Holistic quality check (SOLID, DRY, naming, widget decomposition)
- Tooling audit (analysis, format, tests, coverage 80%+)
- LG-specific audit (KML validity, SSH lifecycle, service layer boundaries)
- Write review report
- If REVISIONS NEEDED -> return to Stage 7

### Stage 9: Security Post-Flight
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Re-run full security and boundary scan on final code
- Verify no regressions from execution phase
- Generate shield report in `docs/reviews/`
- **BLOCKS graduation if critical issues found**

### Stage 10: Quiz & Graduation
**Skill**: `.agent/skills/lg-quiz-master/SKILL.md`
- 5-question assessment
- Categories: Command Flow, KML, Engineering, Layer Boundaries, Security
- **Run app on emulator** via `lg-emulator-manager` for live demonstration
- **Capture demo evidence** via `lg-demo-recorder` (screenshots, screen recording, GIF)
- Generate graduation report with links to learning resources
- If 3+ wrong -> Critical Advisor coaching session + Learning Resources

## Cross-Cutting: Critical Advisor
**Skill**: `.agent/skills/lg-critical-advisor/SKILL.md`
- Active at ALL stages
- Triggers on: rushing, over-delegating, boundary violations, security issues, silent passenger
- Enforces layer boundary rules (`.agent/rules/layer-boundaries.md`)
- Documents sessions in `docs/aimentor/`

## Cross-Cutting: Helper Skills (active on-demand)

| Skill | Trigger | What It Does |
|-------|---------|--------------|
| `lg-env-doctor` | Pipeline start, or "check my setup" | Scans OS for all required tools, produces health report |
| `lg-setup-guide` | Doctor finds MISSING tools | OS-specific install commands (2-3 methods per tool) |
| `lg-dependency-resolver` | `flutter pub get` or Gradle fails | Classifies error → targeted fix (not just "flutter clean") |
| `lg-resume-pipeline` | Session reconnect, or "continue" | Reads checkpoint file → resumes from exact interrupted stage |
| `lg-emulator-manager` | Execute/Test/Demo stages | Launches emulators, runs app, captures screenshots/recordings |
| `lg-demo-recorder` | Documentation/Graduation stage | Captures full demo evidence (screenshots, video, GIF for README) |
| `lg-learning-resources` | Quiz wrong answers or knowledge gaps | Links to LG official sources, YouTube tutorials, docs |

**Interruption handling**: Any stage can be interrupted by missing tools, errors, or session disconnect. The pipeline saves a checkpoint to `docs/pipeline-checkpoint.yaml` and resumes cleanly.

## Documents Generated
| Stage | Document |
|-------|----------|
| Shield (pre) | `docs/reviews/YYYY-MM-DD-shield-preflight.md` |
| Brainstorm | `docs/plans/YYYY-MM-DD-<topic>-design.md` |
| Viz Design | `docs/plans/YYYY-MM-DD-<topic>-viz-design.md` |
| Plan | `docs/plans/YYYY-MM-DD-<feature>-plan.md` |
| Execute | `docs/learning-journal.md` (appended) |
| Review | `docs/reviews/YYYY-MM-DD-<feature>-review.md` |
| Shield (post) | `docs/reviews/YYYY-MM-DD-shield-postflight.md` |
| Quiz | `docs/reviews/YYYY-MM-DD-final-quiz-report.md` |
| Advisor | `docs/aimentor/YYYY-MM-DD-advisor-session.md` |
| Env Doctor | `docs/pipeline-checkpoint.yaml` (auto-maintained) |

## Design Principles (Enforced)
- **Strict layer separation** — see `.agent/rules/layer-boundaries.md`
- **DRY and SOLID** — no duplicated logic, single-responsibility services
- **Agent-driven planning and generation** — reproducible workflows
- **Security by default** — secrets in secure storage, not source code
- **Minimal and extensible skeleton** — easy to add new APIs and visualizations
