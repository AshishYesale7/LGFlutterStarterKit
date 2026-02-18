---
name: Full Pipeline
description: The complete 10-stage educational pipeline from security pre-flight through graduation, with mandatory student interaction checkpoints between stages.
---

# Full Pipeline Workflow

## Overview
Executes the complete LG educational pipeline in order. This is the recommended workflow for students going through the full learning experience. The pipeline includes environment validation, security bookends, strict layer boundary enforcement, and automatic resume on interruption.

**CRITICAL**: This pipeline is designed for the **Gemini Summer of Code 2026 — Agentic Programming Contest**. The generated app follows the `LG-<TaskName>` naming convention and is created as a **sibling directory inside the Antigravity workspace** (not outside it).

---

## 📍 MANDATORY: Path Transparency

> **Every file, directory, command, and output path MUST be shown to the student in chat.**
> The student should NEVER have to ask "where is that file?" or "what command did you run?"

**After every action, show:**
- Full file paths for created/modified files
- Terminal commands with working directory
- Build output locations (APK path, screenshot path, etc.)
- Git commands for manual verification
- Emulator launch commands for manual testing

Example after each task:
```
📁 Files changed:
  ✅ Created: ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client/lib/services/ssh_service.dart
  ✏️ Modified: ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client/lib/main.dart
🖥️ To verify: cd ~/.gemini/antigravity/scratch/LG-Task2-Demo/flutter_client && flutter analyze
```

---

## 🧠 MANDATORY: Conversational Brain

> **Antigravity is ONE continuous intelligence, not a menu of skills.**
> The agent seamlessly detects what the student needs and activates the right skill automatically.
> The student should NEVER need to know skill names or manually request stages.

**The agent MUST:**
- Detect context and activate the appropriate skill without being asked
- Use multiple skills within a single conversation turn when needed
- Transition between skills naturally: "Let me check your code for security issues before we continue..."
- ALWAYS explain what it's doing in plain language, not skill names
- Feel like ONE mentor, not a skill directory

**The agent announces skills for transparency** ("I'm using lg-exec to implement the SSH service") but the student never needs to REQUEST a skill.

---

## ⛔️ MANDATORY: Student Interaction Policy

> **The agent MUST pause and wait for the student's response between EVERY stage.**
> DO NOT chain stages together automatically.
> Each stage transition includes a **Student Checkpoint** (marked with ⛔️).
> If the student says "just do it all" or "skip ahead," trigger the Critical Advisor.

---

## ⛔️ MANDATORY: Within-Stage Conversational Interaction

> **The agent MUST also interact with the student DURING each stage — not just between stages.**
> Every skill has internal interaction points marked with ⛔.
> The agent must present content ONE SECTION AT A TIME and ask questions after each section.

### The One-Section-Per-Message Rule

**During any stage, the agent MUST NOT:**
- ❌ Generate a complete plan, design, or walkthrough in one message
- ❌ Present multiple approaches without pausing between them
- ❌ Create multiple files silently without explaining each
- ❌ Ask multiple verification questions in a single message
- ❌ End a message with just "Ready?" — must ask a thought-provoking question

**During any stage, the agent MUST:**
- ✅ Present ONE logical section per message (one task, one approach, one step, one concept)
- ✅ End every content message with a specific, engagement-requiring question
- ✅ Wait for the student to respond before presenting the next section
- ✅ Explain WHAT it's about to create and WHY before creating files
- ✅ Narrate code changes like a teacher working alongside the student

**This transforms the agent from a "content dumper" into a "teaching conversationalist."**

---

## 🔗 CONVERSATIONAL AUTO-CHAIN (CRITICAL)

**The agent MUST automatically offer the next pipeline stage at the end of every skill.**
The student should NEVER have to manually ask "now do the review" or "now do the quiz."

Each skill ends with a **Skill Chain Handoff** — an explicit conversational offer:

```
Env Doctor  → "Environment looks good! Ready for the Security Pre-Flight scan?"
Shield Pre  → "Security scan clean! Let's initialize your project. Ready?"
Init        → "Project scaffolded! Ready to brainstorm your first feature?"
Brainstorm  → "Design documented! Ready to map the visualization experience?"
Viz Arch    → "Storyboard ready! Ready to write the implementation plan?"
Plan Writer → "Plan saved! Ready to start coding? I'll begin with Task 1."
Data Pipe   → "Pipeline wired! Ready to scaffold the UI screens?"
UI Scaffold → "Screens generated! Ready to execute the remaining plan tasks?"
Exec        → "Implementation complete! Ready for a professional Code Review?"
Review      → "Code APPROVED! Ready for the Liquid Galaxy Quiz Show finale?"
Shield Post → (runs automatically before Quiz)
Quiz Master → "Congratulations! 🎓 Ready to start your next LG project?"
```

**RULE**: The agent announces which skill it's activating at the START of each stage:
> "I'm using the lg-brainstormer skill to explore your app design."

And offers the next skill at the END:
> "Design complete! I'll use the lg-plan-writer skill next. Ready to create the implementation plan?"

This creates a **natural conversational flow** where the student always knows:
1. What just happened
2. What happens next
3. They have a chance to ask questions before moving on

**The student only needs to say "yes" / "ready" / ask a question.** They should never need to know skill names or manually request stages.

---

## ⚠️ PROMINENT GUARDRAIL: Critical Advisor

The **Critical Advisor** (`.agent/skills/lg-critical-advisor/SKILL.md`) is active at **ALL** stages.
Every skill MUST reference it prominently. If the student rushes, goes silent, or fails verification, the advisor intervenes IMMEDIATELY.

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

> 🔗 **Skill Chain**: *"Environment looks good! All tools are PASS. Let's run a Security Pre-Flight scan to make sure we're starting clean. Ready?"*

### Stage 0: Security Pre-Flight
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Scan for hardcoded secrets, exposed API keys
- Validate `.gitignore` covers credentials and build artifacts
- Verify `flutter_secure_storage` present if app handles credentials
- Check layer boundary compliance on existing code
- **BLOCKS pipeline if critical issues found**

> 🔗 **Skill Chain**: *"Security scan is clean — no secrets exposed, boundaries intact. Let's initialize your project! Ready to set up your LG app?"*

### Stage 1: Init
**Skill**: `.agent/skills/lg-init/SKILL.md` + `.agent/skills/lg-flutter-init/SKILL.md`
- **Enforce LG-<TaskName> naming convention** (e.g., `LG-Task2-Demo`)
- **Create new app as a sibling inside the Antigravity workspace** (`~/.gemini/antigravity/scratch/LG-Task2-Demo/`)
- **Add the new app to the IDE workspace** so student sees both repos side-by-side
- Gather requirements (project name, screens, platforms, APIs) — one question at a time
- **Recommend logo/assets** via `lg-nanobanana-sprite`
- Copy starter kit scaffolding into new directory
- Initialize Git repo + create GitHub repo via `lg-github-agent`
- Scaffold directory structure with layered architecture
- Install dependencies
- Verify toolchain
- **Show full paths for all created files and directories**
- All subsequent stages operate in the NEW app directory

> ⛔️ **Student Checkpoint**: *"The project is scaffolded. Explain: What is the relationship between the Flutter app on your phone and Google Earth on the LG rig?"*

> 🔗 **Skill Chain** (after checkpoint passes): *"Great understanding! Now let's brainstorm what your app will do. Ready to explore the idea?"*

### Stage 2: Brainstorm
**Skill**: `.agent/skills/lg-brainstormer/SKILL.md`
- Explore the idea collaboratively
- Reference real LG projects: [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App), [LG LAB repos](https://github.com/LiquidGalaxyLAB)
- Propose 2-3 approaches with trade-offs
- Apply SOLID and DRY principles to design choices
- Select optimal design
- Document in `docs/plans/`

> ⛔️ **Student Checkpoint**: *"Describe the data flow in your own words: where does data come from, how becomes KML, how reaches Google Earth?"*

> 🔗 **Skill Chain** (after checkpoint passes): *"Excellent data flow understanding! Now let's design the visual experience — what people will actually SEE on the rig. Ready?"*

### Stage 3: Visualization Design
**Skill**: `.agent/skills/lg-viz-architect/SKILL.md`
- Design the multi-screen experience storyboard
- Map data to KML elements (placemarks, tours, overlays, time animations)
- Define phone-to-rig interaction mapping
- Set performance budget (max placemarks, KML size, tour duration)
- Document in `docs/plans/`
- ⛔ **WITHIN-STAGE**: Present ONE storyboard moment at a time. Discuss each before moving on. Present each step (1-6) as a separate conversation turn.

> ⛔️ **Student Checkpoint**: *"Which phone action maps to which rig response? Trace one interaction end-to-end."*

> 🔗 **Skill Chain**: *"Visualization storyboard is ready! Now let's break it into concrete tasks. Ready for the implementation plan?"*

### Stage 4: Plan
**Skill**: `.agent/skills/lg-plan-writer/SKILL.md`
- Break design into bite-sized tasks
- Define file paths and code patterns per layer
- **MANDATORY**: Educational Verification Phase
- Save plan to `docs/plans/`

> ⛔️ **Student Checkpoint**: *"Before we start coding — why does SSH logic belong in a service and not in a widget? What principle is that?"*

> 🔗 **Skill Chain** (after checkpoint passes): *"Plan saved! Let's start building. I'll set up the data pipeline first, then scaffold the UI. Ready to code?"*

### Stage 5: Data Pipeline Setup
**Skill**: `.agent/skills/lg-data-pipeline/SKILL.md`
- Define provider contracts for external APIs
- Create domain models (immutable, no side effects)
- Wire API -> Domain -> KML -> Transport flow
- Validate boundary compliance
- ⛔ **WITHIN-STAGE**: Explain each domain model BEFORE creating it. Ask the student to predict what fields and types the model needs.

> ⛔️ **Student Checkpoint**: *"Walk me through the data flow: which file fetches from the API, which file holds the model, and which file generates the KML?"*

> 🔗 **Skill Chain**: *"Data pipeline is wired! Now let's build the screens and KML art. Ready for the UI?"*

### Stage 6: UI Scaffolding + KML Crafting
**Skills**: `.agent/skills/lg-ui-scaffolder/SKILL.md` + `.agent/skills/lg-kml-craftsman/SKILL.md`
- Generate controller screens (no network/KML/SSH imports in UI)
- Compose artistic KML visualizations (3D extrusions, time animations, tours)
- Wire screens to services via Provider
- ⛔ **WITHIN-STAGE**: Show screen layout design BEFORE creating each screen. Build ONE screen at a time and discuss each.

> ⛔️ **Student Checkpoint**: *"Looking at the home screen — which Provider does it listen to, and what action does each button trigger?"*

> 🔗 **Skill Chain**: *"Screens and KML compositions are scaffolded! Ready to start executing the full plan in batches?"*

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

> 🔗 **Skill Chain** (after all batches): *"All tasks implemented! Ready for a professional Code Review?"*

### Stage 8: Review
**Skill**: `.agent/skills/lg-code-reviewer/SKILL.md`
- Holistic quality check (SOLID, DRY, naming, widget decomposition)
- Tooling audit (analysis, format, tests, coverage 80%+)
- LG-specific audit (KML validity, SSH lifecycle, service layer boundaries)
- Write review report
- If REVISIONS NEEDED -> return to Stage 7
- ⛔ **WITHIN-STAGE**: Present ONE category of review findings at a time (architecture, then style, then tests, then LG-specific). Discuss fixes before applying them.

> ⛔️ **Student Checkpoint**: *"Which review finding do you think is most critical to fix first, and why?"*

> 🔗 **Skill Chain** (if APPROVED): *"Code review APPROVED! Let me run the final security scan, then we'll move to the Quiz Show finale. Ready?"*

### Stage 9: Security Post-Flight
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Re-run full security and boundary scan on final code
- Verify no regressions from execution phase
- Generate shield report in `docs/reviews/`
- **BLOCKS graduation if critical issues found**

> 🔗 **Skill Chain**: *"Security post-flight passed! You've built and secured a complete LG app. Ready for the Liquid Galaxy Quiz Show? 🎬"*

### Stage 10: Quiz & Graduation
**Skill**: `.agent/skills/lg-quiz-master/SKILL.md`
- 5-question assessment
- Categories: Command Flow, KML, Engineering, Layer Boundaries, Security
- **Run app on emulator** via `lg-emulator-manager` for live demonstration
- **Capture demo evidence** via `lg-demo-recorder` (screenshots, screen recording, GIF)
- Generate graduation report with links to learning resources
- If 3+ wrong -> Critical Advisor coaching session + Learning Resources

> 🔗 **Skill Chain** (after graduation): *"🎓 Congratulations! You've completed the full Liquid Galaxy Pipeline! Ready to start your next project? I can initialize a new LG app anytime."*

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
- **Path transparency** — every file, command, and output path shown explicitly in chat
- **Conversational brain** — one continuous intelligence that seamlessly uses the right skill at every step
- **Workspace co-location** — generated app lives alongside starter kit in the same IDE workspace
