---
name: Generate Flutter App
description: End-to-end workflow to generate a complete Liquid Galaxy Flutter controller application. Enforces LG-<TaskName> naming, student interaction at every stage, and contest 3-repo structure.
---

# Generate Flutter App Workflow

## Overview
This is the master workflow that orchestrates the full generation of a Liquid Galaxy Flutter controller application. It chains together multiple skills in the correct order to produce a working, tested, secured, and documented app. Security validation runs at the start (pre-flight) and end (post-flight) of the pipeline.

**Contest**: Supports the **Gemini Summer of Code 2026 — Agentic Programming Contest** 3-repository workflow:
1. **LGFlutterStarterKit** — Template + `.agent/` system (this repo)
2. **Student's Demo App** — Generated in a separate repo using `LG-<TaskName>` naming
3. **Agent System** — The `.agent/` directory (part of repo #1)

---

## ⛔️ MANDATORY: Student Interaction Policy

> The agent MUST pause between stages for student interaction.
> Each stage has a checkpoint question. DO NOT skip them.
> If the student says "just build everything," trigger the Critical Advisor.

---

## Prerequisites
- App configuration defined in `.agent/app_templates/flutter/app_config.yaml`
- **All other prerequisites are auto-checked** by the Environment Doctor (Pre-Stage below)

## Pipeline Stages

### Pre-Stage: Environment Doctor
**Skill**: `lg-env-doctor` → `lg-setup-guide` (if needed)
**Actions**:
1. Detect host OS (macOS, Linux distro, Windows/WSL) and architecture.
2. Check all required tools: Flutter SDK (>=3.0), Dart, Git, JDK 17, Android SDK, `adb`, SSH client.
3. Check optional tools: Node.js (for `node_server/`), Google Earth Pro (for KML testing), Xcode (if iOS).
4. Produce health report table with PASS / WARN / MISSING per tool.
5. **If any required tool is MISSING**:
   - Hand off to `lg-setup-guide` which provides OS-specific install commands.
   - Multiple methods per tool (package manager, manual, version manager).
   - After install, re-run doctor to confirm.
6. Initialize checkpoint file at `docs/pipeline-checkpoint.yaml`.
7. **BLOCKS pipeline until all required tools pass.**

**Cross-cutting helpers** (active on-demand throughout all stages):
| Skill | Trigger | Purpose |
|-------|---------|---------|
| `lg-dependency-resolver` | `pub get` / Gradle / CocoaPods fails | Classifies error → targeted fix |
| `lg-resume-pipeline` | Session reconnect or "continue" | Reads checkpoint → resumes from interrupted stage |

### Stage 0: Security Pre-Flight
**Skill**: `lg-shield`
**Actions**:
1. Scan existing code for hardcoded secrets, exposed API keys.
2. Validate `.gitignore` covers credentials, `.env`, build artifacts.
3. Check that `flutter_secure_storage` is included if credentials are involved.
4. Verify layer boundary compliance on any pre-existing code.
5. **If BLOCK-level issues found, halt pipeline until resolved.**

### Stage 1: Initialize Project
**Skill**: `lg-flutter-init` + `lg-init`
**Actions**:
1. Read `app_config.yaml` for project identity, screen count, and platform targets.
2. **Enforce LG-<TaskName> naming** (e.g., `LG-Task2-Demo`, `LG-Earthquake-Viz`).
3. **Create new app in a SEPARATE sibling directory** (NOT inside `LGFlutterStarterKit`).
4. Copy starter kit scaffolding (flutter_client/, .github/, .gitignore, server/) into new directory.
5. Initialize Git repo in the new directory.
6. Create GitHub repo via `lg-github-agent` and push initial commit.
7. Create/verify directory structure with layered architecture (`providers/`, `models/`, `services/`, `screens/`, `widgets/`).
8. Configure `pubspec.yaml` with required dependencies.
9. Configure `config.dart` with LG rig connection defaults.
10. **Recommend logo/assets** via `lg-nanobanana-sprite`.
11. Run `flutter pub get`.
12. Run `flutter analyze` -- must pass.
13. Commit: `init: project scaffolding from config`.
14. **All subsequent stages operate in the NEW app directory.**

> ⛔️ **Checkpoint**: *"What is the relationship between the Flutter app and the LG rig?"*

### Stage 2: Brainstorm & Design
**Skill**: `lg-brainstormer`
**Actions**:
1. Present the app concept from config.
2. Discuss 2-3 architectural approaches with trade-offs.
3. Apply DRY and SOLID principles to design decisions.
4. Select optimal approach for LG visualization.
5. Write design document to `docs/plans/`.
6. Validate with student.

### Stage 3: Visualization Experience Design
**Skill**: `lg-viz-architect`
**Actions**:
1. Design multi-screen experience storyboard.
2. Map data source to KML elements (placemarks, tours, overlays, time-based viz).
3. Define phone-to-rig interaction mapping.
4. Set performance budget (max placemarks, KML size, tour length).
5. Write viz design to `docs/plans/`.

### Stage 4: Write Implementation Plan
**Skill**: `lg-plan-writer`
**Actions**:
1. Break the design into 5-10 minute tasks.
2. Define file paths, code patterns, and verifications per layer.
3. Run Educational Verification Phase.
4. Save plan to `docs/plans/`.

### Stage 5: Build Data Pipeline
**Skills**: `lg-data-pipeline`, `lg-api-integrator`
**Actions**:
1. Define provider contracts for external APIs (in `lib/providers/`).
2. Generate domain models from API response shapes (in `lib/models/`).
3. Wire API -> Domain Model -> KML Generator -> Transport flow.
4. Validate no layer imports from a forbidden neighbour.

### Stage 6: Generate Services
**Skills**: `lg-file-generator`, `lg-logic-builder`
**Actions**:
1. Generate service classes (SSH, KML, LG facade).
2. Register providers in `main.dart`.
3. For each file: `flutter analyze` must pass.

### Stage 7: Generate UI & KML Art
**Skills**: `lg-ui-scaffolder`, `lg-kml-craftsman`, `lg-kml-writer`
**Actions**:
1. Generate controller screens — no network/KML/SSH imports in UI code.
2. Generate reusable widget components.
3. Compose artistic KML visualizations (3D extrusions, time animations, polished tours).
4. Wire screens to services via Provider.
5. Boundary check: `grep -rn "import.*dartssh2" lib/screens/ lib/widgets/` must return nothing.

### Stage 8: Implement LG Communication
**Skill**: `lg-ssh-controller`
**Actions**:
1. Implement SSH connection service.
2. Wire up KML sending to LG rig.
3. Implement fly-to, orbit, relaunch commands.
4. Add connection UI (host, port, user, password inputs).
5. Verify credentials use `flutter_secure_storage`, not `SharedPreferences`.

### Stage 9: Testing & Quality
**Skills**: `lg-tester`, `lg-code-reviewer`, `lg-emulator-manager`
**Actions**:
1. Generate unit tests for providers, models, and KML generators.
2. Generate widget tests for screens.
3. `flutter analyze` -- zero errors.
4. `dart format --set-exit-if-changed .` -- consistent style.
5. `flutter test` -- all passing.
6. `flutter test --coverage` -- target 80%.
7. **Launch emulator** via `lg-emulator-manager` for visual testing.
8. Run app on emulator — verify all screens render correctly.
9. **Capture screenshots** of each screen for documentation.
10. Write review report to `docs/reviews/`.

### Stage 10: Security Post-Flight
**Skill**: `lg-shield`
**Actions**:
1. Re-run full secret scan on final codebase.
2. Re-validate layer boundaries after all code changes.
3. Verify no regressions from execution phase.
4. Generate shield report in `docs/reviews/`.
5. **If BLOCK-level issues found, halt before build.**

### Stage 11: Build Artifacts
**Skill**: `lg-flutter-build`
**Actions**:
1. `flutter build apk --release` -- Android APK (primary deliverable).
2. Organize artifacts in `builds/` directory.

### Stage 12: Documentation & Graduation
**Skills**: `lg-quiz-master`, `lg-demo-recorder`
**Actions**:
1. Update `README.md` with setup, usage, and screenshots.
2. **Capture full demo recording** via `lg-demo-recorder` (video + GIF for README).
3. **Add screenshots** of all mandatory screens to `docs/screenshots/`.
4. Finalize `DEVELOPMENT_LOG.md`.
5. Run Quiz Show for learning assessment (includes layer boundary questions).
6. Generate graduation report with learning resources for missed topics.
7. **Push all artifacts to GitHub**: code, docs, screenshots, recordings.
8. **Create GitHub Release** with APK artifact attached.
9. Final commit: `chore: release v1.0.0`.

## Configuration Reference

The workflow reads from `.agent/app_templates/flutter/app_config.yaml`:

```yaml
app:
  name: "LG-Task2-Demo"          # MUST follow LG-<TaskName> convention
  package: "com.liquidgalaxy.lg_task2_demo"
  description: "Task 2 demo: logo, pyramid, flyTo, clean on LG rig"

rig:
  screens: 3

platforms:
  - android

apis: []  # None for Task 2; add USGS/NASA/etc for advanced apps

features:
  ssh_control: true
  kml_generation: true
  logo_overlay: true     # Send logo to slave screen
  pyramid_3d: true       # 3D colored pyramid KML
  flyto_home: true       # FlyTo student's home city
  clean_kml: true        # Clear all KMLs
  clean_logos: true      # Clear logo overlays
```

## Success Criteria
- [ ] App name follows `LG-<TaskName>` convention
- [ ] App is in its own directory (separate from LGFlutterStarterKit)
- [ ] App has its own GitHub repo with all code pushed
- [ ] App compiles and runs on target platform (Android)
- [ ] App runs on emulator with all screens functional
- [ ] `flutter analyze` passes with zero issues
- [ ] All tests pass
- [ ] KML generation produces valid XML
- [ ] SSH connection to LG rig works (when available)
- [ ] Logo/assets recommended or generated via Nano Banana
- [ ] Screenshots of all mandatory screens captured in `docs/screenshots/`
- [ ] Demo recording captured for contest submission
- [ ] Student answered verification questions at each stage checkpoint
- [ ] Release APK built: `flutter build apk --release`
- [ ] Demo video/GIF captured in `docs/recordings/` and `docs/gifs/`
- [ ] README fully documents setup, usage, and includes screenshots
- [ ] DEVELOPMENT_LOG tracks all decisions
- [ ] GitHub Release created with APK artifact
