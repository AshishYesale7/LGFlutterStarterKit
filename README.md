
# LG Flutter Starter Kit

> **Flutter starter kit for building Liquid Galaxy apps with tours, KML, external APIs, and AI-assisted workflows using Gemini.**

---

<a id="about-the-contest"></a>
<a href="https://drive.google.com/drive/folders/1uDfGWf18ZrRjqCtSQCITzh7SdfkQAbgQ"> <h2>Reference Video and Demo App </h2> </a>
## About the Contest

This repository is my submission for the **Liquid Galaxy Agentic Programming Contest** — a competition focused on **Agentic Programming** and the **"AI tsunami"**. The challenge: build an Antigravity-powered environment that automates the development of Liquid Galaxy Flutter applications using Google's **Antigravity** framework with **Gemini** as the exclusive LLM.

<a id="what-i-built"></a>

### What I Built

I built an **agentic system** — an Antigravity package with **33 specialized agent skills**, **5 architecture rules**, and **4 workflows** that can generate production-ready LG Flutter applications from scratch. The agent pipeline guides students through an 11-stage journey from environment setup to a deployed APK, enforcing best practices and verifying understanding at every checkpoint.

<a id="deliverables"></a>

### Deliverables

| # | Deliverable | Description | Status |
|---|-------------|-------------|--------|
| 1 | **Starter Kit** | Flutter "skeleton" with LG best practices built in | [`flutter_client/`](flutter_client/) |
| 2 | **agent/ Folder** | 33 skills, 5 rules, 4 workflows — the core agentic system |  [`.agent/`](.agent/) |
| 3 | **Demo Repository** | Sample app created entirely by the agent system | 📂 [Separate repo](https://github.com/AshishYesale7/LG-Task-2-controller-Demo/) |
| 4 | **Video Demo** | Walkthrough of repository, agent skills, and resulting app | 🎥 [Separate](https://drive.google.com/drive/folders/1uDfGWf18ZrRjqCtSQCITzh7SdfkQAbgQ) |
| 5 | **Technical Documentation** | This README + comprehensive [`DOCUMENTATION/`](DOCUMENTATION/) folder |  |

<a id="demo-app"></a>

### Demo App


> **[LG-Task2-Controller](https://github.com/AshishYesale7/LG-Task-2-controller-Demo/releases)** — A demo application built entirely using this starter kit and the Antigravity agent system. Visualizes real-time USGS earthquake data on a Liquid Galaxy rig with KML heatmaps, camera tours, and multi-screen overlays.

---

<a id="index"></a>

## INDEX

1. [About the Contest](#about-the-contest)  
   1.1. [What I Built](#what-i-built)  
   1.2. [Deliverables](#deliverables)  
   1.3. [Demo App](#demo-app)  
2. [Main Workflow](#main-workflow)  
3. [Agentic Architecture](#agentic-architecture)  
4. [Agent Skills Overview](#agent-skills-overview)  
5. [CI/CD Pipeline](#cicd-pipeline)  
6. [Key Features](#key-features)  
7. [Getting Started with Antigravity](#getting-started)  
   7.1. [Step-by-Step: From Install to Running App](#step-by-step)  
   7.2. [Prompts to Explore the Starter Kit](#prompts)  
   7.3. [How GUIDE.md Powers the Agent](#guide-context)  
8. [Installation](#installation)  
9. [Running the Project](#running-the-project)  
   9.1. [Standard Start (3-Screen Rig)](#standard-start)  
   9.2. [Custom Rig Configuration](#custom-rig)  
   9.3. [Screen Mapping (3-Screen Rig)](#screen-mapping)  
   9.4. [Building for Release](#building-release)  
   9.5. [Node.js Server (Optional)](#nodejs-server)  
10. [Architecture Overview](#architecture-overview)  
    10.1. [The Flutter App](#flutter-app)  
    10.2. [The LG Rig](#lg-rig)  
    10.3. [App → Rig Communication](#app-rig-comm)  
    10.4. [The 5-Layer Import Matrix](#import-matrix)  
11. [What Can You Build?](#what-can-you-build)  
12. [App Screens & Controls](#app-screens-and-controls)  
    12.1. [5 Core LG Operations (Task 2 Minimum)](#core-operations)  
13. [Expert Agent Pipeline](#expert-agent-pipeline)  
    13.1. [Conversational Auto-Chain](#auto-chain)  
    13.2. [Full Skill Roster (33 Skills)](#skill-roster)  
    13.3. [5 Enforced Architecture Rules](#arch-rules)  
14. [Educational Notes](#educational-notes)  
    14.1. [Professional Quality Tools](#quality-tools)  
15. [Dependencies](#dependencies)  
16. [References & Resources](#references)  
17. [Future Work](#future-work)  
    17.1. [Data Visualization](#fw-data-viz)  
    17.2. [Educational Tours](#fw-tours)  
    17.3. [Satellite Tracking](#fw-satellite)  
    17.4. [AI-Powered Apps](#fw-ai)  
    17.5. [Rig Management](#fw-rig)  
18. [Acknowledgments](#acknowledgments)  
19. [License](#license)  

### Documentation & Community

| Document | Description |
|----------|-------------|
| [Architecture](DOCUMENTATION/architecture.md) | 5-layer system design, import matrix, data flow diagrams |
| [Service API Reference](DOCUMENTATION/service-api-reference.md) | Complete method signatures for all services |
| [Setup & Configuration](DOCUMENTATION/setup-and-configuration.md) | Prerequisites, build overrides, secure storage, rig config |
| [Agent System](DOCUMENTATION/agent-system.md) | 11-stage pipeline, 33 skills, auto-chain details |
| [Screens & UI](DOCUMENTATION/screens-and-ui.md) | Every screen — purpose, route, widgets, behavior |
| [CI/CD & Quality](DOCUMENTATION/cicd-and-quality.md) | GitHub Actions, static analysis, quality standards |
| [Node.js Server](DOCUMENTATION/nodejs-server.md) | Companion server endpoints, WebSocket API |
| [Repository Map](DOCUMENTATION/repository-map.md) | Complete annotated file tree |
| [LG Development Guide](GUIDE.md) | Comprehensive Liquid Galaxy + Flutter guide (onboarding, KML, rig setup, best practices) |
| [Code of Conduct](CODE_OF_CONDUCT.md) | Community standards and behavior expectations |
| [Contributing](CONTRIBUTING.md) | How to contribute, code standards, PR checklist |
| [Security Policy](SECURITY.md) | Vulnerability reporting and security practices |

---

A professional, production-grade starter kit for building **Liquid Galaxy** applications using **Flutter**, **Dart**, **SSH/KML**, and **Node.js**.

This project provides everything you need to build, test, and deploy Flutter apps that interact with the Liquid Galaxy multi-screen Google Earth system — from earthquake visualizers and satellite trackers to guided tours and interactive dashboards. It ships with **Antigravity**, a 33-skill AI engineering mentor that teaches you the full stack while you build.

<a id="main-workflow"></a>

##  Main Workflow

The end-to-end development flow from starter kit to deployed LG application:

```
┌─────────────────────────────────────────────────────────────────────┐
│                        MAIN WORKFLOW                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐      │
│  │  STARTER  │───▶│  AGENT   │───▶│  FLUTTER │───▶│    LG    │      │
│  │   KIT     │    │ PIPELINE │    │   APP    │    │   RIG    │      │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘      │
│       │               │               │               │            │
│  Template code   11-stage flow    Your custom     Multi-screen     │
│  + services      + AI mentoring   LG application  Google Earth     │
│  + architecture  + code review    + external API   visualization   │
│                                   + KML tours                      │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  Developer Journey:                                         │    │
│  │  1. Clone starter kit                                       │    │
│  │  2. Run `lg-env-doctor` → validates environment             │    │
│  │  3. Run `lg-init` → scaffolds new app from template         │    │
│  │  4. Brainstorm → Plan → Build (agent-guided)                │    │
│  │  5. Code review + security scan                             │    │
│  │  6. Build APK → Deploy → Connect to LG rig                 │    │
│  │  7. Quiz → Graduate 🎓                                      │    │
│  └─────────────────────────────────────────────────────────────┘    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

<a id="agentic-architecture"></a>

## Agentic Architecture

The Antigravity agent system is organized into layers that separate concerns:

```
┌─────────────────────────────────────────────────────────────────────┐
│                     AGENTIC ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │  WORKFLOWS (Orchestration Layer)          .agent/workflows/   │  │
│  │  ┌─────────────┐ ┌──────────────┐ ┌──────────┐ ┌──────────┐  │  │
│  │  │full-pipeline │ │generate-app  │ │test-rig  │ │test-ios  │  │  │
│  │  │  (11 stages) │ │(flutter init)│ │(flutter) │ │(emulator)│  │  │
│  │  └──────┬───────┘ └──────┬───────┘ └────┬─────┘ └────┬─────┘  │  │
│  └─────────┼────────────────┼──────────────┼────────────┼────────┘  │
│            │                │              │            │           │
│  ┌─────────▼────────────────▼──────────────▼────────────▼────────┐  │
│  │  SKILLS (33 Specialized Agents)           .agent/skills/      │  │
│  │                                                               │  │
│  │  Pipeline:  env-doctor → shield → init → brainstorm →        │  │
│  │             viz-architect → plan → exec → review → quiz       │  │
│  │                                                               │  │
│  │  Builders:  data-pipeline, ui-scaffolder, kml-craftsman,      │  │
│  │             logic-builder, file-generator, ssh-controller     │  │
│  │                                                               │  │
│  │  Quality:   critical-advisor, tester, debugger                │  │
│  │  DevOps:    github-agent, flutter-build, emulator-manager     │  │
│  │  Teaching:  learning-resources, resume-pipeline                │  │
│  └──────────────────────────┬────────────────────────────────────┘  │
│                             │                                       │
│  ┌──────────────────────────▼────────────────────────────────────┐  │
│  │  RULES (5 Architecture Guards)            .agent/rules/       │  │
│  │  ┌──────────────┐ ┌───────────────┐ ┌──────────────────────┐  │  │
│  │  │lg-architecture│ │flutter-best-  │ │ layer-boundaries     │  │  │
│  │  │(rig + SSH)    │ │practices      │ │ (5-layer enforcement)│  │  │
│  │  └──────────────┘ └───────────────┘ └──────────────────────┘  │  │
│  │  ┌──────────────┐ ┌───────────────┐                           │  │
│  │  │kml-standards │ │dart-style     │   Enforced on EVERY      │  │
│  │  │(KML 2.2)     │ │(Effective Dart)│   code generation       │  │
│  │  └──────────────┘ └───────────────┘                           │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
│  ┌───────────────────────────────────────────────────────────────┐  │
│  │  GUARDRAIL: Critical Advisor                                  │  │
│  │  Active across ALL stages — blocks progress if student        │  │
│  │  skips understanding. "Explain it or the pipeline stops."     │  │
│  └───────────────────────────────────────────────────────────────┘  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

<a id="agent-skills-overview"></a>

## 🛠️ Agent Skills Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                    33 AGENT SKILLS BY CATEGORY                      │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  🔵 PIPELINE CORE (11 skills — the main 11-stage journey)          │
│  ┌────────────┐ ┌────────┐ ┌──────┐ ┌────────────┐ ┌────────────┐ │
│  │env-doctor  │→│shield  │→│init  │→│flutter-init│→│brainstormer│ │
│  │(validate)  │ │(scan)  │ │(repo)│ │(flutter)   │ │(design)    │ │
│  └────────────┘ └────────┘ └──────┘ └────────────┘ └────────────┘ │
│  ┌────────────┐ ┌────────┐ ┌──────┐ ┌────────────┐ ┌────────────┐ │
│  │viz-architect│→│plan-   │→│exec  │→│code-       │→│quiz-master │ │
│  │(storyboard)│ │writer  │ │(build)│ │reviewer    │ │(graduate)  │ │
│  └────────────┘ └────────┘ └──────┘ └────────────┘ └────────────┘ │
│  + setup-guide                                                     │
│                                                                     │
│  🟢 ARCHITECTURE (7 skills — code generation)                      │
│  data-pipeline · ui-scaffolder · kml-craftsman · kml-writer        │
│  logic-builder · file-generator · ssh-controller                   │
│                                                                     │
│  🟡 QUALITY (4 skills — enforcement)                               │
│  critical-advisor · tester · debugger · dependency-resolver        │
│                                                                     │
│  🔴 DEVOPS (5 skills — build & deploy)                             │
│  github-agent · flutter-build · devops-agent                       │
│  emulator-manager · demo-recorder                                  │
│                                                                     │
│  🟣 CONVERTERS (3 skills — transformation)                         │
│  api-integrator · dart-converter · code-converter                  │
│                                                                     │
│  📚 TEACHING (3 skills — learning)                                 │
│  learning-resources · resume-pipeline · nanobanana-sprite           │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

<a id="cicd-pipeline"></a>

##  CI/CD Pipeline

```
┌─────────────────────────────────────────────────────────────────────┐
│                      CI/CD PIPELINE                                 │
│                  3 GitHub Actions Workflows                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  1. flutter-ci.yml  (on every push & PR)                    │    │
│  │     ┌──────────┐  ┌──────────┐  ┌──────────┐               │    │
│  │     │ checkout │→ │ flutter  │→ │ flutter  │               │    │
│  │     │ + setup  │  │ analyze  │  │  test    │               │    │
│  │     └──────────┘  └──────────┘  └──────────┘               │    │
│  │     Blocks merge if lint errors or test failures            │    │
│  └─────────────────────────────────────────────────────────────┘    │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  2. flutter-build.yml  (on release tags)                    │    │
│  │     ┌──────────┐  ┌──────────┐  ┌──────────┐               │    │
│  │     │ checkout │→ │  build   │→ │ upload   │               │    │
│  │     │ + setup  │  │   APK    │  │ artifact │               │    │
│  │     └──────────┘  └──────────┘  └──────────┘               │    │
│  │     Produces release APK for contest submission             │    │
│  └─────────────────────────────────────────────────────────────┘    │
│                                                                     │
│  ┌─────────────────────────────────────────────────────────────┐    │
│  │  3. security-scan.yml  (on push to main)                    │    │
│  │     ┌──────────┐  ┌──────────┐  ┌──────────┐               │    │
│  │     │ secret   │→ │ dep audit│→ │ Node.js  │               │    │
│  │     │ scanning │  │ (pub)    │  │ npm audit│               │    │
│  │     └──────────┘  └──────────┘  └──────────┘               │    │
│  │     Scans for hardcoded secrets, vulnerable dependencies    │    │
│  └─────────────────────────────────────────────────────────────┘    │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

<a id="key-features"></a>

##  Key Features

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

<a id="getting-started"></a>

##  Getting Started with Antigravity

This section walks you through installing **Antigravity**, cloning this starter kit, and using the AI agent system to build your own Liquid Galaxy Flutter app — all from inside the Antigravity application.

>  **Reference**: The agent system uses [`GUIDE.md`](GUIDE.md) as its primary knowledge source for Liquid Galaxy concepts, KML management, rig architecture, Flutter best practices, and GSoC deliverables. Antigravity automatically reads this file for context when answering your questions.

<a id="step-by-step"></a>

### Step-by-Step: From Install to Running App

---

####  Phase 1 — Install Antigravity

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 1: Download Antigravity                                   │
│                                                                 │
│  Visit:  https://goo.gle/gemini-code-assist-antigravity         │
│                                                                 │
│  Antigravity is a standalone desktop application powered by     │
│  Google Gemini. It provides:                                    │
│    • An AI chat interface for conversational coding             │
│    • Background agents that run tasks autonomously              │
│    • Full terminal, file editor, and workspace management       │
│    • Built-in Git integration                                   │
│                                                                 │
│  Download → Install → Launch the Antigravity app                │
└─────────────────────────────────────────────────────────────────┘
```

>  **What is Antigravity?** It's Google's agentic coding application — think of it as an AI-powered IDE that can read your entire project, run terminal commands, edit files, and guide you through complex development tasks using Gemini.

---

#### 📂 Phase 2 — Clone the Starter Kit

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 2: Clone LGFlutterStarterKit inside Antigravity           │
│                                                                 │
│  Open the Antigravity chat and type:                            │
│                                                                 │
│  💬 "Clone the repo                                             │
│      github.com/AshishYesale7/LGFlutterStarterKit               │
│      and open it as my workspace"                               │
│                                                                 │
│  The agent will:                                                │
│    ✅ Clone the repo into Antigravity's scratch directory       │
│    ✅ Open the workspace with all files visible                 │
│    ✅ Detect the .agent/ folder (33 skills, 5 rules)            │
│    ✅ Load GUIDE.md as context for LG-specific questions        │
│                                                                 │
│  Your workspace will look like:                                 │
│  ~/.gemini/antigravity/scratch/                                 │
│  └── LGFlutterStarterKit/                                      │
│      ├── .agent/          ← 33 skills + 5 rules + 4 workflows  │
│      ├── flutter_client/  ← Starter Flutter app template        │
│      ├── server/          ← Node.js WebSocket server            │
│      ├── demo/            ← Verified plugin stack reference     │
│      ├── GUIDE.md         ← LG development guide (agent reads)  │
│      └── README.md        ← You are here!                      │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 🤖 Phase 3 — Meet the Agent System

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 3: Explore the Antigravity Chat + Background Agents       │
│                                                                 │
│  Antigravity has TWO ways to interact with the AI:              │
│                                                                 │
│  ┌───────────────────────────────────────────────────┐          │
│  │  💬 CHAT (Interactive)                            │          │
│  │  ─────────────────────────────────────────────    │          │
│  │  Type prompts in the chat panel.                  │          │
│  │  The agent responds conversationally.             │          │
│  │  Use for: questions, brainstorming, reviews,      │          │
│  │  learning LG concepts, quick edits.               │          │
│  │                                                   │          │
│  │  Example:                                         │          │
│  │  💬 "Explain how SSH works with the LG rig"       │          │
│  │  💬 "What KML elements do I need for a flyTo?"    │          │
│  └───────────────────────────────────────────────────┘          │
│                                                                 │
│  ┌───────────────────────────────────────────────────┐          │
│  │  🔄 BACKGROUND AGENTS (Autonomous)                │          │
│  │  ─────────────────────────────────────────────    │          │
│  │  Agents run in the background — they read files,  │          │
│  │  execute terminal commands, edit code, run tests,  │          │
│  │  and commit changes WITHOUT blocking you.          │          │
│  │                                                   │          │
│  │  Use for: scaffolding entire features, running     │          │
│  │  builds, code reviews, security scans, test gen.  │          │
│  │                                                   │          │
│  │  Example:                                         │          │
│  │  💬 "Run lg-init to create my LG-EarthquakeViz    │          │
│  │      app in a new repo"                           │          │
│  │  → Agent runs in background: creates dir, copies  │          │
│  │    template, runs flutter create, inits Git,      │          │
│  │    sets up GitHub repo — while you keep working.  │          │
│  └───────────────────────────────────────────────────┘          │
└─────────────────────────────────────────────────────────────────┘
```

---

#### ⚙️ Phase 4 — Set Up Your Environment

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 4: Run the Environment Doctor                             │
│                                                                 │
│  💬 "Run lg-env-doctor to check my setup"                       │
│                                                                 │
│  The agent validates your entire dev environment:               │
│                                                                 │
│    ✅ Flutter SDK installed & on PATH                           │
│    ✅ Dart SDK version >=3.0.0                                  │
│    ✅ Git configured with user.name & user.email                │
│    ✅ JDK 17+ for Android builds                                │
│    ✅ Android SDK with platform-tools                           │
│    ✅ SSH client available (for LG rig communication)           │
│                                                                 │
│  ❌ If anything fails → the agent tells you exactly             │
│     how to fix it before continuing.                            │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 🏗️ Phase 5 — Create Your App

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 5: Initialize a new LG app from the starter kit           │
│                                                                 │
│  💬 "Run lg-init to create my app called EarthquakeViz"         │
│                                                                 │
│  The agent (running in background) will:                        │
│                                                                 │
│    1️⃣  Ask your project name → enforces LG-<TaskName> format   │
│    2️⃣  Create a NEW sibling directory:                          │
│        ~/.gemini/antigravity/scratch/                            │
│        ├── LGFlutterStarterKit/    (template — untouched)       │
│        └── LG-EarthquakeViz/       (YOUR new app)               │
│                                                                 │
│    3️⃣  Copy scaffolding from the starter kit                    │
│    4️⃣  Run flutter create --platforms=android                   │
│    5️⃣  Install dependencies from demo/DEPENDENCIES.md           │
│    6️⃣  Configure LG rig connection in config.dart               │
│    7️⃣  Init Git + create GitHub repo                            │
│    8️⃣  Open BOTH repos side-by-side in the workspace            │
│                                                                 │
│  ⛔ The agent STOPS at checkpoints to verify you understand     │
│     the architecture before moving forward.                     │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 🧠 Phase 6 — Brainstorm, Design & Build

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 6-7: The agent guides you through the full pipeline       │
│                                                                 │
│  💬 "Let's brainstorm — I want to visualize earthquake data"    │
│  ┌──────────────────────────────────────────────────────┐       │
│  │  BRAINSTORM → The agent discusses data sources,      │       │
│  │  KML strategies, screen layouts, and user flows.     │       │
│  │  Outputs: docs/plans/<date>-design.md                │       │
│  └──────────────────────────────────────────────────────┘       │
│                           ↓                                     │
│  💬 "Start the execution phase"                                 │
│  ┌──────────────────────────────────────────────────────┐       │
│  │  EXECUTE → Background agent implements features in    │       │
│  │  batches of 2-3 tasks. After each batch:             │       │
│  │    • Shows what was built                             │       │
│  │    • Asks you to explain what the code does           │       │
│  │    • Only proceeds if you demonstrate understanding   │       │
│  └──────────────────────────────────────────────────────┘       │
│                           ↓                                     │
│  💬 "Run code review and security scan"                         │
│  ┌──────────────────────────────────────────────────────┐       │
│  │  REVIEW → Professional audit: SOLID compliance,       │       │
│  │  flutter analyze, dart format, layer boundary check.  │       │
│  │  Shield scans for hardcoded secrets & credentials.    │       │
│  └──────────────────────────────────────────────────────┘       │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 📱 Phase 7 — Build, Connect & Deploy

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 8: Build the release APK                                  │
│                                                                 │
│  💬 "Build my app for release"                                  │
│                                                                 │
│  The agent runs the full build pipeline:                        │
│    flutter analyze              ← Zero errors required          │
│    dart format --set-exit-if-changed .   ← Clean formatting     │
│    flutter build apk --release --split-per-abi                  │
│                                                                 │
│  Output: LG-EarthquakeViz-arm64-v8a-release.apk                │
│                                                                 │
│  Install on your Android phone → connect to LG rig → done! 📡  │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 🎓 Phase 8 — Prove You Understand

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 9: Graduate!                                              │
│                                                                 │
│  💬 "start the quiz"                                            │
│                                                                 │
│  The agent asks 5 questions covering:                           │
│    ❓ SSH rig communication                                      │
│    ❓ KML structure & Google Earth rendering                      │
│    ❓ 5-layer architecture & import boundaries                    │
│    ❓ Provider state management                                   │
│    ❓ Performance & multi-screen considerations                   │
│                                                                 │
│  Pass = you understand what you built (not just what AI wrote)  │
│                                                                 │
│  📋 Quiz report saved to: docs/reviews/<date>-quiz-report.md   │
└─────────────────────────────────────────────────────────────────┘
```

---

#### 🔁 How Antigravity + LGFlutterStarterKit Work Together

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   ANTIGRAVITY APP                  LGFlutterStarterKit          │
│   ┌─────────────┐                 ┌──────────────────┐          │
│   │             │   reads from    │                  │          │
│   │  💬 Chat    │◄───────────────►│  .agent/         │          │
│   │  Interface  │   skills &      │  ├── skills/     │          │
│   │             │   rules         │  ├── rules/      │          │
│   └──────┬──────┘                 │  └── workflows/  │          │
│          │                        │                  │          │
│   ┌──────▼──────┐   reads for     │  GUIDE.md        │          │
│   │             │   LG context    │  (LG knowledge   │          │
│   │  🔄 Back-   │◄──────────────►│   base)          │          │
│   │  ground     │                 │                  │          │
│   │  Agents     │   uses as       │  flutter_client/ │          │
│   │             │   template      │  (starter code)  │          │
│   └──────┬──────┘                 │                  │          │
│          │                        │  demo/           │          │
│          │         uses verified   │  (plugin stack)  │          │
│          │◄────────versions───────│                  │          │
│          ▼                        └──────────────────┘          │
│   ┌─────────────┐                                               │
│   │ YOUR NEW    │   Created as sibling directory                │
│   │ LG APP      │   ~/.gemini/antigravity/scratch/LG-<Name>/   │
│   │ (separate   │   Own Git repo, own GitHub, own APK          │
│   │  repo)      │                                               │
│   └─────────────┘                                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

>  **Key Insight**: The starter kit is **never modified**. It serves as a read-only template and knowledge base. Antigravity reads the `.agent/` skills, `GUIDE.md`, and `demo/` references to create and guide YOUR app in a separate directory.

<a id="prompts"></a>

### Prompts to Explore the Starter Kit

Use these prompts directly in the Antigravity chat to learn and build:

####  Understanding the Kit

| Prompt | What It Does |
|--------|--------------|
| `"Explain the 5-layer architecture of this project"` | Agent walks through Presentation → Transport layers with examples from the codebase |
| `"How does SSH communication work with the LG rig?"` | Agent explains SSHService, command execution, and `/tmp/query.txt` using GUIDE.md context |
| `"Show me how KML files are generated and sent"` | Agent traces the flow from KMLService → SSHService → LG rig |
| `"What is the master-slave architecture of Liquid Galaxy?"` | Agent explains using GUIDE.md — master node, slave screens, UDP sync |
| `"Explain the service layer pattern in this kit"` | Agent shows LGService facade, why screens never touch SSH/KML directly |

####  Building Your App

| Prompt | What It Does |
|--------|--------------|
| `"Create a new screen that displays weather data on the LG rig"` | Agent scaffolds a screen + service + KML generation following architecture rules |
| `"Add an API service that fetches ISS position from NASA"` | Agent creates the service, model, and wires it into the provider layer |
| `"Generate a KML tour that orbits around 3 cities"` | Agent uses KMLService patterns to create a multi-stop animated tour |
| `"Help me send a ScreenOverlay logo to the left slave screen"` | Agent explains and implements using sendLogo() with proper screen targeting |
| `"Add a settings screen where users enter their LG rig IP"` | Agent extends SettingsProvider with flutter_secure_storage |

####  Testing & Quality

| Prompt | What It Does |
|--------|--------------|
| `"Run flutter analyze and fix all warnings"` | Agent runs analysis and fixes lint issues following dart-style rules |
| `"Write unit tests for KMLService"` | Agent generates tests for pure KML generation functions |
| `"Check if my app follows the layer boundary rules"` | Agent scans imports and flags architecture violations |
| `"Scan my code for hardcoded secrets"` | Agent runs lg-shield to find exposed passwords or API keys |

####  Learning LG Concepts

| Prompt | What It Does |
|--------|--------------|
| `"What are the essential LG functions my app must implement?"` | Agent lists requirements from GUIDE.md — KML cleanup, camera sync, orbit, QR connect |
| `"Explain KML coordinate order and common mistakes"` | Agent clarifies `longitude,latitude,altitude` order and why it matters |
| `"How should I handle camera tilt and zoom for 3D views?"` | Agent explains 45° tilt, 2km altitude rule from the LG guide |
| `"What are KML balloons and their limitations on LG?"` | Agent explains balloon rendering issues on legacy Google Earth |
| `"Walk me through the GSoC deliverables checklist"` | Agent lists APK builds, documentation, worklog, and GO webstore from GUIDE.md |

####  Advanced Workflows

| Prompt | What It Does |
|--------|--------------|
| `"Design a multi-screen visualization for satellite tracking"` | Agent runs viz-architect — storyboards, KML elements, performance budget |
| `"Create a data pipeline from USGS API to KML overlay"` | Agent wires API → Model → KMLService → SSHService end-to-end |
| `"Build an AI-powered tour generator using Gemini"` | Agent integrates Gemini API, generates waypoints, renders KML tours |
| `"Set up my project for the GO webstore submission"` | Agent runs flutter-build, prepares APK, checks deliverable checklist |

> 💡 **Tip**: You don't need to memorize these prompts. Just say **"ready"** after each pipeline stage and the agent automatically suggests the next step. The prompts above are for when you want to explore specific topics or skip ahead.

<a id="guide-context"></a>

### How [`GUIDE.md`](GUIDE.md) Powers the Agent

The [`GUIDE.md`](GUIDE.md) file is a comprehensive Liquid Galaxy development guide covering:

- **Onboarding** — GSoC bonding period, mentor meetings, environment setup (Windows & macOS)
- **GitHub Methodology** — Branch strategy, PR workflow, commit conventions
- **Liquid Galaxy Architecture** — Master-slave model, UDP communication, screen synchronization
- **Essential LG Functions** — KML cleanup, camera sync, orbit controls, QR connection
- **KML Management** — XML structure, placemarks, tours, overlays, balloon limitations
- **Flutter Fundamentals** — Widgets, state, reactive programming, composition
- **Best Practices** — Camera tilt/zoom, 3D views, data transmission, rig compatibility
- **Deliverables** — APK builds, documentation, worklog, GO webstore

When you ask the agent any question about Liquid Galaxy, KML, rig setup, or GSoC requirements, it pulls context directly from this file to give accurate, project-specific answers.

<a id="installation"></a>

## 🛠️ Installation

1. **Clone the repository**
  ```bash
   git clone https://github.com/AshishYesale7/LGFlutterStarterKit.git
   cd LGFlutterStarterKit
   ```
3. **Install dependencies**:
   ```bash
   cd flutter_client
   flutter pub get
   ```

<a id="running-the-project"></a>

## 🏁 Running the Project

<a id="standard-start"></a>

### Standard Start (3-Screen Rig)

The default mode assumes a standard 3-screen Liquid Galaxy rig at `192.168.56.101`.

```bash
cd flutter_client
flutter run
```

<a id="custom-rig"></a>

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

<a id="screen-mapping"></a>

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

<a id="building-release"></a>

### Building for Release

```bash
# Debug APK
flutter build apk --debug

# Release APK (contest submission)
flutter build apk --release

# With custom LG host override
flutter build apk --dart-define=LG_HOST=192.168.56.101
```

<a id="nodejs-server"></a>

### Node.js Server (Optional)

```bash
cd server
npm install
npm start
# Server runs on http://localhost:3000
```

<a id="architecture-overview"></a>

## 🏗️ Architecture Overview

The project follows a **Client-to-Rig** model. Your Flutter app communicates with the LG rig over SSH, sending KML data and camera commands. Google Earth on the rig handles all multi-screen rendering.

<a id="flutter-app"></a>

### 1. The Flutter App (`flutter_client/lib/`)

- **Screens**: UI for rig interaction — Splash, Connection, Dashboard, Settings, Help, Workflow Visualizer. Actions trigger KML/SSH operations on the rig.
- **Services**: All business logic. `LGService` is the facade that coordinates SSH + KML. Screens never touch SSH or KML directly.
- **Providers**: State management via `ChangeNotifier` + `MultiProvider`. Settings, themes, and connection state.
- **Models**: Immutable domain data classes. Pure data — no I/O, no side effects.

<a id="lg-rig"></a>

### 2. The LG Rig

- **LG Master** (Screen 1): Receives SSH commands from your app. Writes KML files to `/var/www/html/kml/` and camera commands to `/tmp/query.txt`.
- **Slave Screens**: Google Earth instances that poll the KML files and render synchronized visualizations across all screens automatically.
- **No Code Runs on the Rig**: You don't deploy anything to the rig. You send KML over SSH, and Google Earth handles the rest.

<a id="app-rig-comm"></a>

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

<a id="import-matrix"></a>

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

<a id="what-can-you-build"></a>

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

<a id="app-screens-and-controls"></a>

##  App Screens & Controls

| Screen | Purpose |
|--------|---------|
| **Splash** | App branding, auto-navigates to Connection |
| **Connection** | Enter LG rig IP, port, credentials. Test connection. |
| **Main Dashboard** | Action cards: FlyTo, Send Logo, Send Pyramid, Orbit, Clean |
| **Settings** | Rig config, screen count, home city coordinates |
| **Help/About** | Usage instructions and LG architecture overview |
| **Workflow Flow** | Interactive n8n-style visualization of the 11-stage agent pipeline |

All screens are starting points — extend, replace, or add new ones for your project.

<a id="core-operations"></a>

### 5 Core LG Operations (Task 2 Minimum)

| Operation | Service Method | Effect on Rig |
|-----------|---------------|---------------|
| **Send Logo** | `lgService.sendLogo()` | ScreenOverlay KML → left slave screen |
| **Send 3D Pyramid** | `lgService.sendPyramid()` | Extruded colored polygon → master screen |
| **FlyTo Home City** | `lgService.flyToHomeCity()` | Smooth camera flight to your coordinates |
| **Clean Logos** | `lgService.cleanLogos()` | Remove overlays from slave screens |
| **Clean KMLs** | `lgService.cleanKMLs()` | Clear all KML files from the rig |

<a id="expert-agent-pipeline"></a>

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

** PROMINENT GUARDRAIL**: The **Critical Advisor** (`lg-critical-advisor`) is active throughout the entire journey. If you rush, skip explanations, or say "just build it" — it intervenes immediately. You must demonstrate understanding at every checkpoint.

<a id="auto-chain"></a>

### Conversational Auto-Chain

After each stage, the agent **automatically offers** the next one:

> *"Project scaffolded! Now let's brainstorm features — what should your LG app visualize on Google Earth? Ready? 🧠"*

No manual skill-hunting required. Say "ready" and the pipeline flows.

<a id="skill-roster"></a>

### Full Skill Roster (33 Skills)

| Category | Skills |
|----------|--------|
| **Pipeline Core** | `lg-env-doctor`, `lg-setup-guide`, `lg-shield`, `lg-init`, `lg-flutter-init`, `lg-brainstormer`, `lg-viz-architect`, `lg-plan-writer`, `lg-exec`, `lg-code-reviewer`, `lg-quiz-master` |
| **Architecture** | `lg-data-pipeline`, `lg-ui-scaffolder`, `lg-kml-craftsman`, `lg-kml-writer`, `lg-logic-builder`, `lg-file-generator`, `lg-ssh-controller` |
| **Quality** | `lg-critical-advisor`, `lg-tester`, `lg-debugger`, `lg-dependency-resolver` |
| **DevOps** | `lg-github-agent`, `lg-flutter-build`, `lg-devops-agent`, `lg-emulator-manager`, `lg-demo-recorder` |
| **Converters** | `lg-api-integrator`, `lg-dart-converter`, `lg-code-converter` |
| **Teaching** | `lg-learning-resources`, `lg-resume-pipeline`, `lg-nanobanana-sprite` |

<a id="arch-rules"></a>

### 5 Enforced Architecture Rules

| Rule | Enforces |
|------|----------|
| `lg-architecture.md` | LG rig model, SSH communication, service layer patterns |
| `flutter-best-practices.md` | Provider patterns, widget decomposition, const constructors |
| `layer-boundaries.md` | 5-layer import matrix, one-direction data flow |
| `kml-standards.md` | Valid KML 2.2 structure, `lon,lat,alt` coordinate order, tour conventions |
| `dart-style.md` | Effective Dart naming, `///` documentation, formatting standards |

<a id="educational-notes"></a>

##  Educational Notes

- **No Free Code**: The agent explains every architectural decision before writing code. If you can't explain it, the pipeline stops.
- **Service Layer Pattern**: All SSH, KML, and API logic lives in services — never in screens or widgets. This matches how [Lucia's LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) structures the reference implementation.
- **KML Coordinate Order**: Google Earth uses `longitude,latitude,altitude` — not `lat,lon`. Getting this wrong is the #1 beginner mistake.
- **SSH Lifecycle**: Connections must be properly opened, verified, and disposed. The agent enforces `dispose()` methods on services to prevent resource leaks.
- **Secure Storage**: Passwords and API keys **must** use `flutter_secure_storage` — never `SharedPreferences`. The Shield skill scans for this.

<a id="quality-tools"></a>

###  Professional Quality Tools

This starter kit comes pre-configured with the same tools used by professional Flutter teams:

- **`flutter analyze`**: Static analysis — zero errors/warnings required at all times.
- **`dart format`**: Consistent code formatting enforced via `--set-exit-if-changed`.
- **`flutter test`**: Unit and widget tests with 80%+ coverage target.
- **GitHub Actions CI/CD**: `flutter-ci.yml` (lint + test), `flutter-build.yml` (APK build), `security-scan.yml` (automated scanning).
- **Provider + ChangeNotifier**: Google-recommended state management for medium-complexity apps.

Students are expected to keep `flutter analyze` passing at all times!

<a id="dependencies"></a>

##  Dependencies

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

<a id="references"></a>

##  Reference Implementations & Resources

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

For detailed technical documentation, see the **[`DOCUMENTATION/`](DOCUMENTATION/)** folder — architecture deep dives, service API reference, setup guides, agent system docs, and more. Full listing in the [Index](#index) above.

---

<a id="future-work"></a>

##  Future Work

This starter kit is designed to help build **any kind** of Flutter-powered Liquid Galaxy application. Here's how each app category can benefit from future enhancements:

<a id="fw-data-viz"></a>

###  Data Visualization

| Enhancement | Description |
|-------------|-------------|
| **KML Heatmap Generator** | Built-in service to convert datasets (CSV, JSON, API) into KML heatmap overlays with configurable color gradients and intensity scaling |
| **Real-Time Data Streaming** | WebSocket-based live data pipeline — push updates from APIs (USGS, OpenWeather, NASA) directly to KML on the rig without manual refresh |
| **Multi-Layer Overlays** | Support stacking multiple data layers (e.g., earthquakes + fault lines + population density) on different slave screens simultaneously |
| **Chart-to-KML Converter** | Transform Flutter charts (bar, line, pie) into `<ScreenOverlay>` KMLs rendered on LG slave screens as dashboard panels |

<a id="fw-tours"></a>

###  Educational Tours

| Enhancement | Description |
|-------------|-------------|
| **Tour Builder UI** | Drag-and-drop screen for creating multi-stop Google Earth tours — set waypoints, camera angles, dwell times, and narrative text |
| **Narration Engine** | TTS integration to auto-narrate tour stops as the camera flies between locations on the rig |
| **Pre-Built Tour Templates** | Ready-made tour packages (World Wonders, Solar System, Historical Battles, Ocean Exploration) that students can customize |
| **Quiz-at-Waypoint** | Embed interactive quiz questions at tour stops — the rig pauses until the user answers correctly on the phone |

<a id="fw-satellite"></a>

###  Satellite Tracking

| Enhancement | Description |
|-------------|-------------|
| **TLE Parser Service** | Built-in Two-Line Element parser to convert CelesTrak/NASA orbital data into real-time KML satellite positions |
| **Orbit Prediction KML** | Generate animated orbit paths showing past tracks and future predictions as KML `<gx:Track>` elements |
| **Constellation Visualizer** | Render entire constellations (Starlink, GPS, Iridium) with color-coded altitude bands across multiple screens |
| **ISS Live Tracker** | Pre-wired ISS tracking module with live crew info overlay and ground track KML — plug and play |

<a id="fw-ai"></a>

###  AI-Powered Apps

| Enhancement | Description |
|-------------|-------------|
| **Gemini API Service** | Ready-to-use service class for calling Gemini — text generation, image analysis, and structured JSON output for KML creation |
| **AI Itinerary Generator** | Describe a trip in natural language → Gemini generates waypoints → KMLService renders the tour on the rig automatically |
| **Smart Data Enrichment** | Feed raw location data to Gemini for context (history, demographics, ecology) displayed as info balloons on the rig |
| **Natural Language Rig Control** | Voice or text commands ("Fly to the Eiffel Tower and orbit at 500m") parsed by Gemini into LGService method calls |

<a id="fw-rig"></a>

###  Rig Management

| Enhancement | Description |
|-------------|-------------|
| **Health Dashboard** | Real-time monitoring of all rig screens — connection status, CPU/memory, Google Earth process health — displayed on the phone |
| **Multi-Rig Support** | Manage multiple LG rigs from a single app instance — switch between rigs, broadcast KML to all, or target specific rigs |
| **Scheduled Tasks** | Cron-style scheduler for automated rig operations — rotate demos every 10 minutes, clean KMLs at midnight, auto-relaunch GE |
| **Remote Configuration** | Push config changes (screen count, resolution, network settings) to the rig over SSH without physically accessing the machines |


<a id="acknowledgments"></a>

##  Acknowledgments

Special thanks to the Liquid Galaxy community and mentors who make this project possible:

- **Lucia Fernandez** — For the [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App), the reference implementation that established the service-layer patterns and KML communication protocols used throughout this starter kit.
- **Victor Sanchez** — For mentoring the Liquid Galaxy project, driving the contest vision, and championing the integration of AI and agentic programming into the LG ecosystem.
- **The Liquid Galaxy LAB Team** — For maintaining the open-source infrastructure, documentation, and community that supports 100+ GSoC projects.

---

<a id="license"></a>

##  License

This project is licensed under the [MIT License](LICENSE).

Copyright (c) 2026 Ashish Yesale.
