# Full LG Development Pipeline

The complete end-to-end pipeline for building an LG Flutter app.

## Pre-Stage: Environment Check
**Skill**: `.agent/skills/lg-env-doctor/SKILL.md`
- Run environment health check
- If tools missing → hand off to `lg-setup-guide`
- Must pass before proceeding

---

### Stage 1: Init
**Skill**: `.agent/skills/lg-init/SKILL.md` + `.agent/skills/lg-flutter-init/SKILL.md`
- **Create new app in a SEPARATE sibling directory** (NOT inside LGFlutterStarterKit)
- Gather requirements (project name, screens, platforms, APIs)
- Copy starter kit scaffolding into new directory
- Initialize Git repo + create GitHub repo via `lg-github-agent`
- Scaffold directory structure with layered architecture
- Install dependencies
- Verify toolchain
- All subsequent stages operate in the NEW app directory

### Stage 2: Plan
**Skill**: `.agent/skills/lg-plan-writer/SKILL.md`
- Decompose project into tasks (max 10)
- Write design document to `docs/plans/`
- Prioritize by dependency order

### Stage 3: Brainstorm
**Skill**: `.agent/skills/lg-brainstormer/SKILL.md`
- Generate feature ideas
- Student selects features to implement
- Refine selected features into tasks

### Stage 4: Security Pre-Scan
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Baseline security scan
- Flag any initial issues (hardcoded credentials, etc.)

### Stage 5: First Task
**Skill**: `.agent/skills/lg-logic-builder/SKILL.md` + `.agent/skills/lg-ui-scaffolder/SKILL.md`
- Implement first task from the plan
- Build model → service → provider → screen
- Run `flutter analyze` + `flutter test`
- Commit with conventional message

### Stage 6: Review First Task
**Skill**: `.agent/skills/lg-code-reviewer/SKILL.md`
- Review first task for quality and architecture compliance
- Generate review report

### Stage 7: Execute
**Skill**: `.agent/skills/lg-exec/SKILL.md`
- Execute remaining tasks in batches of 2-3
- Verify after each batch: `flutter analyze`, `flutter test`
- **Launch emulator** via `lg-emulator-manager` to visually validate each batch
- Learning journal after each batch
- Commit after each task
- Push to GitHub remote after each batch

### Stage 8: Build
**Skill**: `.agent/skills/lg-flutter-build/SKILL.md`
- Build debug APK
- Build release APK
- Verify app runs on emulator

### Stage 9: Security Post-Scan
**Skill**: `.agent/skills/lg-shield/SKILL.md`
- Final security scan
- Compare with pre-scan baseline
- Generate security report

### Stage 10: Quiz & Graduation
**Skill**: `.agent/skills/lg-quiz-master/SKILL.md`
- 5-question assessment
- Categories: Command Flow, KML, Engineering, Layer Boundaries, Security
- **Run app on emulator** via `lg-emulator-manager` for live demonstration
- **Capture demo evidence** via `lg-demo-recorder` (screenshots, screen recording, GIF)
- Generate graduation report with links to learning resources
- If 3+ wrong -> Critical Advisor coaching session + Learning Resources

### Stage 11: Documentation
**Skill**: `.agent/skills/lg-plan-writer/SKILL.md`
- Update README.md with setup, usage, screenshots
- Finalize DEVELOPMENT_LOG.md
- Add demo GIFs/screenshots from `lg-demo-recorder`
- Create GitHub Release with APK artifact

---

## Cross-Cutting Helpers

| Skill | Trigger | What It Does |
|-------|---------|--------------| 
| `lg-env-doctor` | Pipeline start, or "check my setup" | Scans OS for all required tools, produces health report |
| `lg-setup-guide` | Doctor finds MISSING tools | OS-specific install commands (2-3 methods per tool) |
| `lg-dependency-resolver` | `flutter pub get` or Gradle fails | Classifies error → targeted fix (not just "flutter clean") |
| `lg-resume-pipeline` | Session reconnect, or "continue" | Reads checkpoint file → resumes from exact interrupted stage |
| `lg-emulator-manager` | Execute/Test/Demo stages | Launches emulators, runs app, captures screenshots/recordings |
| `lg-demo-recorder` | Documentation/Graduation stage | Captures full demo evidence (screenshots, video, GIF for README) |
| `lg-learning-resources` | Quiz wrong answers or knowledge gaps | Links to LG official sources, YouTube tutorials, docs |
