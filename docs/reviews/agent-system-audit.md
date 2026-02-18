# `.agent/` Directory — Comprehensive Audit Report

> **Scope**: READ-ONLY audit of `/Users/ashishyesale/.gemini/antigravity/scratch/LGFlutterStarterKit/.agent/`
> **Date**: 2026-02-17
> **Status**: Complete

---

## Table of Contents

1. [Directory Structure](#1-directory-structure)
2. [Orchestrator & Entry Point](#2-orchestrator--entry-point)
3. [Per-Skill Reports](#3-per-skill-reports)
4. [Rules Summary](#4-rules-summary)
5. [Workflows Summary](#5-workflows-summary)
6. [Skill Chain Graph](#6-skill-chain-graph)
7. [Orphan Skills](#7-orphan-skills)
8. [Doc Save Matrix](#8-doc-save-matrix)
9. [Broken References & Gaps](#9-broken-references--gaps)

---

## 1. Directory Structure

```
.agent/
├── PROMPT.md                              (643 lines — master system prompt)
├── app_templates/
│   └── flutter/
│       ├── app_config.yaml
│       └── boilerplate/
│           └── (project template files)
├── rules/                                 (5 files)
│   ├── dart-style.md
│   ├── flutter-best-practices.md
│   ├── kml-standards.md
│   ├── layer-boundaries.md
│   └── lg-architecture.md
├── skills/                                (33 subdirectories)
│   ├── lg-api-integrator/SKILL.md         (209 lines)
│   ├── lg-brainstormer/SKILL.md           (155 lines)
│   ├── lg-code-converter/SKILL.md         (130 lines)
│   ├── lg-code-reviewer/SKILL.md          (114 lines)
│   ├── lg-critical-advisor/SKILL.md       (144 lines)
│   ├── lg-dart-converter/SKILL.md         (295 lines)
│   ├── lg-data-pipeline/SKILL.md          (186 lines)
│   ├── lg-debugger/SKILL.md               (133 lines)
│   ├── lg-demo-recorder/SKILL.md          (197 lines)
│   ├── lg-dependency-resolver/SKILL.md    (327 lines)
│   ├── lg-devops-agent/SKILL.md           (187 lines)
│   ├── lg-emulator-manager/SKILL.md       (99 lines)
│   ├── lg-env-doctor/SKILL.md             (210 lines)
│   ├── lg-exec/SKILL.md                   (170 lines)
│   ├── lg-file-generator/SKILL.md         (255 lines)
│   ├── lg-flutter-build/SKILL.md          (198 lines)
│   ├── lg-flutter-init/SKILL.md           (245 lines)
│   ├── lg-github-agent/SKILL.md           (229 lines)
│   ├── lg-init/SKILL.md                   (355 lines)
│   ├── lg-kml-craftsman/SKILL.md          (201 lines)
│   ├── lg-kml-writer/SKILL.md             (226 lines)
│   ├── lg-learning-resources/SKILL.md     (251 lines)
│   ├── lg-logic-builder/SKILL.md          (260 lines)
│   ├── lg-nanobanana-sprite/SKILL.md      (90 lines)
│   ├── lg-plan-writer/SKILL.md            (131 lines)
│   ├── lg-quiz-master/SKILL.md            (106 lines)
│   ├── lg-resume-pipeline/SKILL.md        (189 lines)
│   ├── lg-setup-guide/SKILL.md            (439 lines)
│   ├── lg-shield/SKILL.md                 (107 lines)
│   ├── lg-ssh-controller/SKILL.md         (163 lines)
│   ├── lg-tester/SKILL.md                 (323 lines)
│   ├── lg-ui-scaffolder/SKILL.md          (165 lines)
│   └── lg-viz-architect/SKILL.md          (195 lines)
└── workflows/                             (4 files)
    ├── full-pipeline.md                   (347 lines)
    ├── generate-flutter-app.md            (230 lines)
    ├── test-ios-emulator.md
    └── test-rig-flutter.md                (104 lines)
```

**Total**: 1 prompt + 5 rules + 33 skills + 4 workflows = **43 files**, ~6,679 lines of skill content alone.

---

## 2. Orchestrator & Entry Point

### PROMPT.md — The Master Orchestrator

`PROMPT.md` (643 lines) is the **system-level identity prompt** for the "Antigravity" AI mentor. Key facts:

| Aspect | Detail |
|--------|--------|
| **Identity** | "Antigravity" — AI engineering mentor for Liquid Galaxy Flutter development |
| **Contest** | Gemini Summer of Code 2026 — Agentic Programming Contest |
| **3-Repo Model** | (1) LGFlutterStarterKit, (2) Student's LG-<TaskName> app, (3) Agent System |
| **Pipeline** | 6-stage: Init → Brainstorm → Plan → Execute → Review → Quiz |
| **Conversational Brain** | Seamlessly invokes skills without exposing skill names to the student |
| **Path Transparency** | Must show which SKILL.md is active and which doc paths are being written |
| **Guardrails** | Critical Advisor and Shield always active |

### full-pipeline.md — The Practical Orchestrator

`workflows/full-pipeline.md` (347 lines) defines the 11-stage execution pipeline:

```
Pre-Stage: Env Doctor
Stage 0:   Shield (pre-flight)
Stage 1:   Init
Stage 2:   Brainstorm
Stage 3:   Viz Design
Stage 4:   Plan
Stage 5:   Data Pipeline
Stage 6:   UI Scaffolding + KML Crafting
Stage 7:   Execute
Stage 8:   Review
Stage 9:   Shield (post-flight)
Stage 10:  Quiz & Graduation
```

Cross-cutting: Critical Advisor, Dependency Resolver, Resume Pipeline (always available).

---

## 3. Per-Skill Reports

### 3.1 lg-api-integrator

| Field | Value |
|-------|-------|
| **Description** | Integrates external REST/WebSocket APIs into LG apps |
| **INTERACTIONS** | STOP after integrating each API — asks about caching/fallback strategy |
| **Interaction Type** | Free text questions |
| **CHAINS TO** | lg-kml-writer, lg-ssh-controller, lg-learning-resources |
| **CHAINED FROM** | lg-data-pipeline (implicit — API integration during data pipeline stage) |
| **SAVES TO DOCS** | None |
| **GAPS** | No formal `## Skill Chain` section. No explicit doc saves. |

---

### 3.2 lg-brainstormer

| Field | Value |
|-------|-------|
| **Description** | Interactive brainstorming for LG visualization ideas |
| **INTERACTIONS** | STOP after each Phase 1 question, STOP between each approach (Phase 2), STOP between each design section (Phase 3). Extensive interaction. |
| **Interaction Type** | Multiple choice preferred, free text, validation questions |
| **CHAINS TO** | lg-viz-architect (explicit chain), lg-critical-advisor (guardrail), lg-shield (guardrail), lg-learning-resources |
| **CHAINED FROM** | lg-init, lg-flutter-init, lg-quiz-master (new feature cycle) |
| **SAVES TO DOCS** | `docs/plans/YYYY-MM-DD-<topic>-design.md`, `docs/architecture-map.md` |
| **GAPS** | None — well-structured with explicit chain section. |

---

### 3.3 lg-code-converter

| Field | Value |
|-------|-------|
| **Description** | Converts code between languages/frameworks for LG context |
| **INTERACTIONS** | None explicit — guardrail trigger only |
| **Interaction Type** | Guardrail trigger if student doesn't understand conversion |
| **CHAINS TO** | lg-critical-advisor (guardrail), lg-code-reviewer (handoff) |
| **CHAINED FROM** | None explicit — on-demand utility |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. No STOP/WAIT points. No doc saves. Minimal interaction. |

---

### 3.4 lg-code-reviewer

| Field | Value |
|-------|-------|
| **Description** | Reviews generated/student code for quality, architecture, LG patterns |
| **INTERACTIONS** | STOP before final verdict — discusses findings with student |
| **Interaction Type** | Free text ("Which issues do you understand?") |
| **CHAINS TO** | lg-shield (post-flight), lg-quiz-master (chain), lg-critical-advisor, lg-learning-resources |
| **CHAINED FROM** | lg-exec, lg-kml-writer, lg-ssh-controller, lg-tester, lg-code-converter, lg-kml-craftsman |
| **SAVES TO DOCS** | `docs/reviews/YYYY-MM-DD-<feature>-review.md` |
| **GAPS** | None — well-connected, clear chain. |

---

### 3.5 lg-critical-advisor

| Field | Value |
|-------|-------|
| **Description** | Global guardrail — halts execution when student can't explain what's happening |
| **INTERACTIONS** | Halts execution on trigger, asks targeted questions, architectural trace exercises |
| **Interaction Type** | Free text questions, trace exercises |
| **CHAINS TO** | lg-learning-resources, lg-resume-pipeline |
| **CHAINED FROM** | Almost all skills (global guardrail) — lg-brainstormer, lg-code-converter, lg-data-pipeline, lg-debugger, lg-exec, lg-flutter-init, lg-init, lg-kml-craftsman, lg-plan-writer, lg-quiz-master, lg-shield, lg-tester, lg-ui-scaffolder, lg-viz-architect, lg-logic-builder, lg-setup-guide, lg-dependency-resolver, lg-code-reviewer |
| **SAVES TO DOCS** | `docs/aimentor/YYYY-MM-DD-advisor-session.md`, `docs/tech-debt.md` |
| **GAPS** | None — correctly positioned as always-active cross-cutting concern. |

---

### 3.6 lg-dart-converter

| Field | Value |
|-------|-------|
| **Description** | Converts JavaScript/Python/other code to Dart for LG Flutter apps |
| **INTERACTIONS** | None explicit |
| **Interaction Type** | None specified |
| **CHAINS TO** | lg-kml-writer, lg-file-generator, lg-ssh-controller (handoff) |
| **CHAINED FROM** | None explicit — on-demand utility |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. No STOP/WAIT interaction points. No doc saves. Missing student interaction section. |

---

### 3.7 lg-data-pipeline

| Field | Value |
|-------|-------|
| **Description** | Builds the data flow: API → domain model → KML → transport |
| **INTERACTIONS** | STOP after building each pipeline stage |
| **Interaction Type** | Free text questions about separation of concerns |
| **CHAINS TO** | lg-ui-scaffolder (chain), lg-critical-advisor, lg-shield, lg-learning-resources, lg-code-reviewer |
| **CHAINED FROM** | lg-plan-writer |
| **SAVES TO DOCS** | Entry in `docs/plans/` |
| **GAPS** | None — well-structured with explicit chain. |

---

### 3.8 lg-debugger

| Field | Value |
|-------|-------|
| **Description** | Diagnoses and fixes Flutter/Dart/SSH/KML bugs |
| **INTERACTIONS** | Guardrail trigger if student skips root cause analysis |
| **Interaction Type** | Guardrail trigger |
| **CHAINS TO** | lg-critical-advisor (guardrail), lg-code-reviewer (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-dependency-resolver, lg-resume-pipeline, lg-learning-resources, lg-setup-guide |
| **SAVES TO DOCS** | `docs/tech-debt.md` for systemic issues |
| **GAPS** | No formal STOP/WAIT for student explanation. No `## Skill Chain` section. |

---

### 3.9 lg-demo-recorder

| Field | Value |
|-------|-------|
| **Description** | Records demos, screenshots, GIFs of LG app for documentation/submission |
| **INTERACTIONS** | None — procedural skill |
| **Interaction Type** | None |
| **CHAINS TO** | lg-critical-advisor (guardrail), lg-emulator-manager, lg-setup-guide, lg-tester |
| **CHAINED FROM** | lg-quiz-master (graduation) |
| **SAVES TO DOCS** | `docs/screenshots/`, `docs/recordings/`, `docs/gifs/` |
| **GAPS** | No student interaction section. No `## Skill Chain` section. |

---

### 3.10 lg-dependency-resolver

| Field | Value |
|-------|-------|
| **Description** | Resolves Flutter/Dart dependency conflicts, version issues, platform incompatibilities |
| **INTERACTIONS** | None explicit |
| **Interaction Type** | Guardrail reference only |
| **CHAINS TO** | lg-resume-pipeline, lg-debugger, lg-critical-advisor |
| **CHAINED FROM** | lg-resume-pipeline (error recovery) |
| **SAVES TO DOCS** | None |
| **GAPS** | No STOP/WAIT interaction. No doc saves. No `## Skill Chain` section. |

---

### 3.11 lg-devops-agent

| Field | Value |
|-------|-------|
| **Description** | Manages CI/CD, GitHub Actions, build automation |
| **INTERACTIONS** | None |
| **Interaction Type** | None |
| **CHAINS TO** | lg-learning-resources, lg-exec, lg-flutter-build (handoff) |
| **CHAINED FROM** | None explicit — on-demand utility |
| **SAVES TO DOCS** | None |
| **GAPS** | No student interaction. No STOP/WAIT. No doc saves. No `## Skill Chain` section. Potentially orphaned. |

---

### 3.12 lg-emulator-manager

| Field | Value |
|-------|-------|
| **Description** | Manages Android/iOS emulators and simulators for testing |
| **INTERACTIONS** | None — utility skill |
| **Interaction Type** | None |
| **CHAINS TO** | lg-exec, lg-demo-recorder, lg-debugger, lg-dependency-resolver (handoff) |
| **CHAINED FROM** | lg-demo-recorder |
| **SAVES TO DOCS** | `docs/screenshots/`, `docs/recordings/` |
| **GAPS** | No student interaction. No STOP/WAIT. No `## Skill Chain` section. |

---

### 3.13 lg-env-doctor

| Field | Value |
|-------|-------|
| **Description** | Pre-flight environment scanner — detects OS, checks all required tools |
| **INTERACTIONS** | None — automated scanning |
| **Interaction Type** | None (procedural) |
| **CHAINS TO** | lg-shield (chain), lg-setup-guide, lg-resume-pipeline, lg-critical-advisor |
| **CHAINED FROM** | Start of pipeline (Pre-Stage in full-pipeline.md) |
| **SAVES TO DOCS** | Initializes `docs/pipeline-checkpoint.yaml` |
| **GAPS** | None — properly positioned as pipeline entry point. |

---

### 3.14 lg-exec

| Field | Value |
|-------|-------|
| **Description** | Executes planned tasks in batches of 2-3, with mandatory student verification |
| **INTERACTIONS** | **MANDATORY** STOP after every batch of 2-3 tasks. Most interaction-heavy execution skill. |
| **Interaction Type** | Free text verification questions. Critical advisor triggers on "Go on" / "Continue" (anti-rubber-stamp) |
| **CHAINS TO** | lg-code-reviewer (chain), lg-learning-resources, lg-critical-advisor, lg-shield |
| **CHAINED FROM** | lg-ui-scaffolder, lg-plan-writer, lg-logic-builder, lg-file-generator, lg-emulator-manager |
| **SAVES TO DOCS** | `docs/plans/` (updates), `docs/learning-journal.md`, `docs/screenshots/batch_N.png` |
| **GAPS** | None — well-defined chain and heavy interaction. |

---

### 3.15 lg-file-generator

| Field | Value |
|-------|-------|
| **Description** | Generates Dart source files from templates/specifications |
| **INTERACTIONS** | STOP after generating each file |
| **Interaction Type** | Free text ("Can you explain what this file does?") |
| **CHAINS TO** | lg-exec (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-dart-converter, lg-logic-builder |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. |

---

### 3.16 lg-flutter-build

| Field | Value |
|-------|-------|
| **Description** | Builds, tests, and packages Flutter apps for all target platforms |
| **INTERACTIONS** | Stops if any pre-build check fails |
| **Interaction Type** | None specified in detail |
| **CHAINS TO** | lg-learning-resources, lg-code-reviewer (handoff mention) |
| **CHAINED FROM** | lg-devops-agent |
| **SAVES TO DOCS** | None |
| **GAPS** | No formal STOP/WAIT for student understanding. No explicit `## Skill Chain` section. Limited student interaction. |

---

### 3.17 lg-flutter-init

| Field | Value |
|-------|-------|
| **Description** | Bootstraps a new LG Flutter app — enforces LG-<TaskName> naming, 3-repo workflow |
| **INTERACTIONS** | Questions asked ONE AT A TIME, waits for each response |
| **Interaction Type** | Multiple choice, free text |
| **CHAINS TO** | lg-brainstormer (chain), lg-nanobanana-sprite, lg-learning-resources, lg-critical-advisor, lg-shield |
| **CHAINED FROM** | None explicit — alternative init to lg-init (used by generate-flutter-app workflow) |
| **SAVES TO DOCS** | Creates `docs/plans`, `docs/reviews`, `docs/aimentor` directories |
| **GAPS** | Overlaps significantly with lg-init. Unclear when to use one vs the other. |

---

### 3.18 lg-github-agent

| Field | Value |
|-------|-------|
| **Description** | Manages GitHub repo operations — branching, PRs, issues, releases, OSS practices |
| **INTERACTIONS** | STOP if name doesn't start with `LG-` |
| **Interaction Type** | Validation/confirm |
| **CHAINS TO** | lg-learning-resources |
| **CHAINED FROM** | lg-init (Phase 0), lg-flutter-init |
| **SAVES TO DOCS** | None |
| **GAPS** | Limited student interaction beyond naming validation. |

---

### 3.19 lg-init

| Field | Value |
|-------|-------|
| **Description** | Full project initialization — directory scaffolding, Golden Rules, architecture introduction |
| **INTERACTIONS** | **Extensive**: STOP after explaining project location, after scaffolding, after each Golden Rule, after each requirement question |
| **Interaction Type** | Free text questions, yes/no confirm, architectural questions |
| **CHAINS TO** | lg-brainstormer (chain), lg-github-agent, lg-nanobanana-sprite, lg-learning-resources, lg-critical-advisor, lg-shield |
| **CHAINED FROM** | lg-shield (pre-flight) |
| **SAVES TO DOCS** | Creates `docs/` directory structure, `docs/pipeline-checkpoint.yaml` |
| **GAPS** | Overlaps with lg-flutter-init. |

---

### 3.20 lg-kml-craftsman

| Field | Value |
|-------|-------|
| **Description** | Artistic KML composition — 3D extrusions, time animations, gradient styling, panoramic tours |
| **INTERACTIONS** | STOP after crafting each KML composition — explain and quiz student |
| **Interaction Type** | Free text questions about KML modifications, color format, coordinate order |
| **CHAINS TO** | lg-data-pipeline (handoff), lg-code-reviewer (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-viz-architect (handoff) |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section — only Handoff section. |

---

### 3.21 lg-kml-writer

| Field | Value |
|-------|-------|
| **Description** | Foundation KML skill — writes placemarks, tours, overlays, polygons |
| **INTERACTIONS** | STOP after generating KML — quiz on coordinate order |
| **Interaction Type** | Free text questions about KML structure ("If I swap lat and lon, where do placemarks appear?") |
| **CHAINS TO** | lg-ssh-controller, lg-code-reviewer (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-api-integrator, lg-dart-converter, lg-data-pipeline (implicit) |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. |

---

### 3.22 lg-learning-resources

| Field | Value |
|-------|-------|
| **Description** | Curated knowledge base — maps topics to external resources (LG repos, Flutter docs, YouTube) |
| **INTERACTIONS** | None — it IS the learning resource |
| **Interaction Type** | External links, topic mapping |
| **CHAINS TO** | lg-quiz-master (retry), lg-critical-advisor, lg-debugger, lg-setup-guide, lg-resume-pipeline |
| **CHAINED FROM** | Almost all skills (universal handoff for knowledge gaps) |
| **SAVES TO DOCS** | Entries in quiz reports (via quiz-master) |
| **GAPS** | None — correctly positioned as reference library. |

---

### 3.23 lg-logic-builder

| Field | Value |
|-------|-------|
| **Description** | Designs and implements business logic — state machines, data flow, error recovery |
| **INTERACTIONS** | STOP after implementing each logic component |
| **Interaction Type** | Free text questions about error recovery, data flow tracing |
| **CHAINS TO** | lg-file-generator, lg-exec (handoff), lg-critical-advisor, lg-learning-resources |
| **CHAINED FROM** | None explicit — invoked during Execute stage |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. Not explicitly chained from any pipeline skill. |

---

### 3.24 lg-nanobanana-sprite

| Field | Value |
|-------|-------|
| **Description** | Asset generation utility — creates logos, icons, sprites with green-screen → transparent PNG |
| **INTERACTIONS** | None |
| **Interaction Type** | None — asset generation utility |
| **CHAINS TO** | None explicitly |
| **CHAINED FROM** | lg-init, lg-flutter-init |
| **SAVES TO DOCS** | None (generates assets, not docs) |
| **GAPS** | No interaction with student. No `## Skill Chain` or Handoff section. Smallest skill (90 lines). |

---

### 3.25 lg-plan-writer

| Field | Value |
|-------|-------|
| **Description** | Writes task-by-task implementation plans |
| **INTERACTIONS** | **Build plan ONE task at a time, STOP between each.** 4 verification questions asked one at a time. |
| **Interaction Type** | Free text questions, task-by-task discussion |
| **CHAINS TO** | lg-data-pipeline + lg-ui-scaffolder + lg-exec (chain), lg-critical-advisor, lg-shield, lg-learning-resources |
| **CHAINED FROM** | lg-viz-architect |
| **SAVES TO DOCS** | `docs/plans/YYYY-MM-DD-<feature-name>-plan.md` |
| **GAPS** | None — well-structured with clear chain. |

---

### 3.26 lg-quiz-master

| Field | Value |
|-------|-------|
| **Description** | Final assessment — 5-category quiz covering all pipeline outputs |
| **INTERACTIONS** | One question at a time, waits for answer |
| **Interaction Type** | Quiz questions (5 categories: Command Flow, KML Challenge, Engineering Pillar, Performance Pitfall, Future Architect), free text answers |
| **CHAINS TO** | lg-demo-recorder (chain/graduation), lg-brainstormer (new feature cycle), lg-critical-advisor, lg-learning-resources |
| **CHAINED FROM** | lg-code-reviewer, lg-shield (post-flight) |
| **SAVES TO DOCS** | `docs/reviews/YYYY-MM-DD-final-quiz-report.md` |
| **GAPS** | None — well-structured, clear chains both forward and backward. |

---

### 3.27 lg-resume-pipeline

| Field | Value |
|-------|-------|
| **Description** | Tracks pipeline progress, resumes from exact stage where interrupted |
| **INTERACTIONS** | None — state management utility |
| **Interaction Type** | Resume/pause commands |
| **CHAINS TO** | lg-env-doctor, lg-setup-guide, lg-dependency-resolver, lg-debugger |
| **CHAINED FROM** | lg-critical-advisor, lg-learning-resources, lg-dependency-resolver (cross-cutting) |
| **SAVES TO DOCS** | Manages `docs/pipeline-checkpoint.yaml` |
| **GAPS** | None — correctly positioned as cross-cutting state manager. |

---

### 3.28 lg-setup-guide

| Field | Value |
|-------|-------|
| **Description** | OS-aware installation guide — step-by-step instructions for every missing tool |
| **INTERACTIONS** | Verification commands after each install |
| **Interaction Type** | Confirm tool installation works |
| **CHAINS TO** | lg-resume-pipeline, lg-debugger, lg-critical-advisor |
| **CHAINED FROM** | lg-env-doctor, lg-resume-pipeline, lg-demo-recorder |
| **SAVES TO DOCS** | None |
| **GAPS** | No doc save of installation results. |

---

### 3.29 lg-shield

| Field | Value |
|-------|-------|
| **Description** | Security/quality gate — pre-flight and post-flight scans |
| **INTERACTIONS** | None for student (automated scan). Offers next stage after scan. |
| **Interaction Type** | Automated pass/fail |
| **CHAINS TO** | lg-init (pre-flight chain), lg-quiz-master (post-flight chain), lg-critical-advisor |
| **CHAINED FROM** | lg-env-doctor (pre-flight), lg-code-reviewer (post-flight) |
| **SAVES TO DOCS** | `docs/reviews/shield-report.md`, `docs/tech-debt.md` (WARN items) |
| **GAPS** | None — well-positioned as dual-mode (pre/post) quality gate. |

---

### 3.30 lg-ssh-controller

| Field | Value |
|-------|-------|
| **Description** | Implements SSH service for LG rig communication |
| **INTERACTIONS** | STOP after implementing SSH service — walk through with student |
| **Interaction Type** | Free text questions about connection lifecycle, dispose() |
| **CHAINS TO** | lg-kml-writer, lg-code-reviewer (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-api-integrator, lg-dart-converter |
| **SAVES TO DOCS** | None |
| **GAPS** | No `## Skill Chain` section. |

---

### 3.31 lg-tester

| Field | Value |
|-------|-------|
| **Description** | Writes and runs Flutter tests — unit, widget, integration |
| **INTERACTIONS** | Guardrail trigger if student skips testing |
| **Interaction Type** | Guardrail |
| **CHAINS TO** | lg-critical-advisor (guardrail), lg-code-reviewer (handoff), lg-learning-resources |
| **CHAINED FROM** | lg-demo-recorder |
| **SAVES TO DOCS** | None |
| **GAPS** | No formal STOP/WAIT for student explanation. No `## Skill Chain` section. No doc saves (test reports not persisted). |

---

### 3.32 lg-ui-scaffolder

| Field | Value |
|-------|-------|
| **Description** | Generates Flutter screen files with Material 3 and Provider patterns |
| **INTERACTIONS** | STOP after generating each screen — explain and ask trace question |
| **Interaction Type** | Free text ("Trace the call from UI to rig") |
| **CHAINS TO** | lg-exec (chain), lg-critical-advisor, lg-shield, lg-learning-resources |
| **CHAINED FROM** | lg-data-pipeline, lg-plan-writer |
| **SAVES TO DOCS** | Entry in `docs/learning-journal.md` |
| **GAPS** | None — well-connected with clear chain. |

---

### 3.33 lg-viz-architect

| Field | Value |
|-------|-------|
| **Description** | Designs the visualization experience — maps data to KML visual elements |
| **INTERACTIONS** | **STOP after each of 6 steps** — most granular within-stage interaction |
| **Interaction Type** | Free text questions, visualization exercises, KML knowledge checks |
| **CHAINS TO** | lg-plan-writer (chain), lg-kml-craftsman (handoff), lg-critical-advisor, lg-shield, lg-learning-resources |
| **CHAINED FROM** | lg-brainstormer |
| **SAVES TO DOCS** | `docs/plans/YYYY-MM-DD-<topic>-viz-design.md` |
| **GAPS** | None — well-structured with explicit chain section. |

---

## 4. Rules Summary

| Rule File | Purpose | Key Enforcements |
|-----------|---------|-----------------|
| **dart-style.md** | Dart language conventions | `dart format`, 80 chars, PascalCase classes, snake_case files, import ordering, `///` doc comments, null safety, Provider patterns |
| **flutter-best-practices.md** | Flutter framework patterns | One screen/service/model per file, Provider + ChangeNotifier, async try-catch with timeouts, named routes, Material 3 dark mode, `const`, `ListView.builder`, 80% test coverage, APK as primary deliverable |
| **kml-standards.md** | KML compliance | KML 2.2 + `gx:` namespace, **longitude,latitude,altitude** order (NOT lat,lon), `aaBBGGRR` color format, max 500 placemarks, <2MB payload, XML escaping |
| **layer-boundaries.md** | Architecture enforcement | 5 layers (Presentation → Orchestration → Data Providers → KML Generation → Transport), left-to-right data flow only, import matrix, automated by lg-shield + lg-critical-advisor |
| **lg-architecture.md** | LG rig and contest requirements | 3/5/7 screen rig model, Flutter→SSH→LG Master→Google Earth communication, `LG-<TaskName>` naming, Task 2 requirements (5 operations), service layer rules, Lucia's reference app |

---

## 5. Workflows Summary

| Workflow | Stages | Purpose |
|----------|--------|---------|
| **full-pipeline.md** | 11 stages (Pre → 0-10) | Master pipeline: Env Doctor → Shield(pre) → Init → Brainstorm → Viz Design → Plan → Data Pipeline → UI+KML → Execute → Review → Shield(post) → Quiz. Enforces mandatory student interaction between every stage. |
| **generate-flutter-app.md** | 13 stages (Pre → 0-12) | End-to-end app generation with specific skill mappings per stage. More detailed than full-pipeline. Reads from `app_config.yaml`. |
| **test-ios-emulator.md** | Sequential | iOS Simulator testing — configure permissions, install deps, run on simulator, verify functionality, optional build. |
| **test-rig-flutter.md** | 3 methods | Test with/without physical LG rig — physical rig, Docker SSH mock, Google Earth Pro desktop. Verification checklists. |

---

## 6. Skill Chain Graph

### Primary Pipeline (Happy Path)

```
lg-env-doctor
    │
    ▼
lg-shield (pre-flight)
    │
    ▼
lg-init ──────────────┐
    │                  │
    │          lg-github-agent
    │          lg-nanobanana-sprite
    ▼
lg-brainstormer
    │
    ▼
lg-viz-architect
    │               ╲
    ▼                lg-kml-craftsman
lg-plan-writer
    │
    ├──────────────────────────────┐
    ▼                              ▼
lg-data-pipeline              lg-ui-scaffolder
    │                              │
    └──────────┐    ┌──────────────┘
               ▼    ▼
              lg-exec
                │
                ▼
          lg-code-reviewer
                │
                ▼
          lg-shield (post-flight)
                │
                ▼
          lg-quiz-master
                │
                ├──── (pass) ──── lg-demo-recorder
                │
                └──── (new feature) ──── lg-brainstormer (cycle)
```

### Cross-Cutting Skills (Always Active)

```
lg-critical-advisor ←── triggered by any skill when student can't explain
lg-shield ←── pre-flight + post-flight gates
lg-learning-resources ←── referenced by almost all skills for knowledge gaps
lg-resume-pipeline ←── manages pipeline-checkpoint.yaml, handles interruptions
lg-dependency-resolver ←── resolves package/version conflicts when they arise
```

### Support Skills (Invoked On-Demand)

```
lg-setup-guide ←── called by lg-env-doctor when tools are missing
lg-debugger ←── called by lg-dependency-resolver or lg-resume-pipeline on errors
lg-emulator-manager ←── called by lg-demo-recorder for device management
lg-tester ←── called during Review stage or by lg-demo-recorder
lg-flutter-build ←── called by lg-devops-agent or during Execute
lg-devops-agent ←── CI/CD setup, on-demand
lg-github-agent ←── called by lg-init for repo creation
lg-nanobanana-sprite ←── called by lg-init for asset generation
lg-file-generator ←── called by lg-logic-builder or lg-dart-converter
lg-logic-builder ←── called during Execute stage
lg-ssh-controller ←── called during data pipeline / KML transport
lg-kml-writer ←── called during data pipeline / KML generation
lg-kml-craftsman ←── called by lg-viz-architect for advanced KML
lg-api-integrator ←── called during data pipeline for REST/WebSocket
lg-dart-converter ←── on-demand code conversion
lg-code-converter ←── on-demand code conversion
```

---

## 7. Orphan Skills

Skills **never explicitly chained TO** by any pipeline stage in `full-pipeline.md` or `generate-flutter-app.md`:

| Skill | Status | Notes |
|-------|--------|-------|
| **lg-devops-agent** | ⚠️ Orphan | Not referenced in any pipeline stage. Only chains exist in its own Handoff. No skill chains TO it. |
| **lg-code-converter** | ⚠️ Orphan | Not referenced in any pipeline stage. On-demand utility only. |
| **lg-dart-converter** | ⚠️ Orphan | Not referenced in any pipeline stage. On-demand utility only. |
| **lg-flutter-init** | ⚠️ Semi-Orphan | Referenced by `generate-flutter-app.md` workflow but NOT by `full-pipeline.md`. Overlaps with `lg-init`. |
| **lg-logic-builder** | ⚠️ Semi-Orphan | Not explicitly chained from any skill. Implicitly invoked during Execute stage. |
| **lg-flutter-build** | ⚠️ Semi-Orphan | Only chained from `lg-devops-agent` (itself an orphan). Not in main pipeline. |

---

## 8. Doc Save Matrix

| Skill | Doc Path | Content |
|-------|----------|---------|
| **lg-brainstormer** | `docs/plans/YYYY-MM-DD-<topic>-design.md` | Brainstorm session output — approaches, selected design |
| **lg-brainstormer** | `docs/architecture-map.md` | Architecture decisions |
| **lg-code-reviewer** | `docs/reviews/YYYY-MM-DD-<feature>-review.md` | Code review findings |
| **lg-critical-advisor** | `docs/aimentor/YYYY-MM-DD-advisor-session.md` | Advisor intervention log |
| **lg-critical-advisor** | `docs/tech-debt.md` | Systemic issues found |
| **lg-data-pipeline** | `docs/plans/` | Pipeline stage entry |
| **lg-debugger** | `docs/tech-debt.md` | Systemic bugs found |
| **lg-demo-recorder** | `docs/screenshots/` | Screenshot captures |
| **lg-demo-recorder** | `docs/recordings/` | Video recordings |
| **lg-demo-recorder** | `docs/gifs/` | GIF captures |
| **lg-emulator-manager** | `docs/screenshots/`, `docs/recordings/` | Emulator captures |
| **lg-env-doctor** | `docs/pipeline-checkpoint.yaml` | Initialize checkpoint |
| **lg-exec** | `docs/plans/` (updates) | Task completion updates |
| **lg-exec** | `docs/learning-journal.md` | Student learning entries |
| **lg-exec** | `docs/screenshots/batch_N.png` | Batch screenshots |
| **lg-init** | `docs/` (directory structure) | Creates docs/, plans/, reviews/, aimentor/ |
| **lg-init** | `docs/pipeline-checkpoint.yaml` | Initialize checkpoint |
| **lg-flutter-init** | `docs/plans`, `docs/reviews`, `docs/aimentor` | Directory creation |
| **lg-plan-writer** | `docs/plans/YYYY-MM-DD-<feature-name>-plan.md` | Task-by-task plan |
| **lg-quiz-master** | `docs/reviews/YYYY-MM-DD-final-quiz-report.md` | Quiz results + scores |
| **lg-resume-pipeline** | `docs/pipeline-checkpoint.yaml` | Pipeline state tracking |
| **lg-shield** | `docs/reviews/shield-report.md` | Security/quality scan |
| **lg-shield** | `docs/tech-debt.md` | WARN items |
| **lg-ui-scaffolder** | `docs/learning-journal.md` | Learning entries |
| **lg-viz-architect** | `docs/plans/YYYY-MM-DD-<topic>-viz-design.md` | Visualization design |

### Skills with NO Doc Saves (15/33):

lg-api-integrator, lg-code-converter, lg-code-converter, lg-dart-converter, lg-dependency-resolver, lg-devops-agent, lg-file-generator, lg-flutter-build, lg-github-agent, lg-kml-craftsman, lg-kml-writer, lg-logic-builder, lg-nanobanana-sprite, lg-setup-guide, lg-ssh-controller, lg-tester

---

## 9. Broken References & Gaps

### 9.1 Broken/Suspect References

| Issue | Location | Detail |
|-------|----------|--------|
| **lg-flutter-init vs lg-init overlap** | Both skills | Both perform project initialization with near-identical phases. `full-pipeline.md` uses `lg-init`. `generate-flutter-app.md` uses `lg-flutter-init`. No clear disambiguation rules. |
| **lg-devops-agent orphan chain** | lg-devops-agent | Chains to `lg-flutter-build`, but lg-devops-agent itself is never invoked by any pipeline stage. Dead chain. |
| **lg-logic-builder floating** | lg-logic-builder | Has no `CHAINED FROM` — no skill explicitly chains to it. Presumably used during Execute stage but not wired. |
| **lg-code-converter vs lg-dart-converter overlap** | Both skills | Both convert code to Dart. `lg-dart-converter` is more specialized (JS/Python→Dart). `lg-code-converter` is more general. No disambiguation. |

### 9.2 Structural Gaps

| Gap | Severity | Detail |
|-----|----------|--------|
| **No `## Skill Chain` section** in 20/33 skills | Medium | Only 13 skills have a formal `## Skill Chain` section. Others rely on Handoff sections which are less structured. |
| **No STOP/WAIT** in 11/33 skills | Medium | lg-code-converter, lg-dart-converter, lg-dependency-resolver, lg-devops-agent, lg-emulator-manager, lg-env-doctor, lg-flutter-build, lg-github-agent (partial), lg-learning-resources, lg-nanobanana-sprite, lg-resume-pipeline have no student interaction points. Some are utilities where this is acceptable. |
| **No doc saves** in 15/33 skills | Low | Many execution/utility skills don't persist outputs. Acceptable for utilities, but skills like lg-tester should arguably save test reports. |
| **Test reports not persisted** | Medium | lg-tester has no doc save. Test run results are not captured in any docs/ path. |
| **lg-flutter-build has no doc save** | Low | Build artifacts mentioned but not logged to docs/. |
| **Missing `app_templates/` audit** | Info | `app_templates/flutter/app_config.yaml` and `boilerplate/` exist but aren't referenced by name in most skills. Only `generate-flutter-app.md` mentions `app_config.yaml`. |

### 9.3 Consistency Issues

| Issue | Detail |
|-------|--------|
| **Announcement format varies** | Some skills use `"I'm using the X skill..."`, others use `"X activated."`, others have no announcement. |
| **Guardrail reference format varies** | Some reference as `⚠️ PROMINENT GUARDRAIL`, others as `**GUARDRAIL**`, others embed it inline. |
| **Handoff section naming** | Some use `## Handoff`, others `## 🔗 Skill Chain`, others combine both. No standard. |
| **YAML frontmatter** | All 33 skills have proper `name:` and `description:` frontmatter ✓ |

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| Total skills | 33 |
| Skills with STOP/WAIT interaction | 22 |
| Skills without student interaction | 11 |
| Skills with formal `## Skill Chain` | 13 |
| Skills with doc saves | 18 |
| Skills without doc saves | 15 |
| Orphan/semi-orphan skills | 6 |
| Rules | 5 |
| Workflows | 4 |
| Total SKILL.md lines | ~6,679 |
| Broken/suspect references | 4 |
| Structural gaps identified | 6 |
| Consistency issues | 4 |
