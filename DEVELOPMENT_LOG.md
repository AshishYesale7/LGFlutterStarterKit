# Development Log

Tracks all architecture decisions, milestones, and lessons learned.

## Session 1-5: Initial Build
- Built complete LG Flutter Starter Kit from scratch
- 52 agent files + complete Flutter app
- Architecture: splash → connection → main → settings → help (Lucia's LG Master Web App style)
- Provider pattern with MultiProvider
- SSH via dartssh2, KML generation service, LG control service

## Session 7: CI/CD
- Added 3 GitHub Actions workflows:
  - `flutter-ci.yml` — analyze + test
  - `flutter-build.yml` — APK generation with manual dispatch
  - `security-scan.yml` — secret detection + dependency audit

## Session 8: Helper Skills
- Added 4 environment helper skills:
  - `lg-env-doctor` — OS detection + tool health report
  - `lg-setup-guide` — OS-specific install commands
  - `lg-dependency-resolver` — Targeted dependency fix
  - `lg-resume-pipeline` — Checkpoint tracking + resume
- Fixed 15 pre-existing skill YAML front-matter errors

## Session 9: Learning Resources
- Created `lg-learning-resources` skill
- Updated `lg-quiz-master` with wrong-answer protocol
- Updated `lg-critical-advisor` with Gap→Teach→Verify protocol

## Session 12: Separate Directory + Visual Testing
- Added separate directory rule: new apps go in sibling directories, not inside starter kit
- Created `lg-emulator-manager` skill for emulator lifecycle
- Created `lg-demo-recorder` skill for screenshots, recordings, GIFs
- Updated workflows with emulator/demo stages

## Architecture Decisions
| Decision | Rationale |
|----------|-----------|
| Provider over Riverpod | Simpler for beginners, sufficient for LG apps |
| dartssh2 over ssh2 | Better maintained, null-safe |
| Material 3 | Modern design, better theming |
| Layered architecture | Clear boundaries, testable |
| Separate app directories | Template stays clean, each student gets own repo |
