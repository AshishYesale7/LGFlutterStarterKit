# Generate Flutter App Workflow

Detailed 12-stage workflow for generating a complete LG Flutter application.

## Pre-Stage: Environment Doctor
**Skill**: `lg-env-doctor`
Before starting, verify the development environment:
1. Run `lg-env-doctor` to scan all tools
2. If anything MISSING → invoke `lg-setup-guide` with OS + tool name
3. If anything OUTDATED → suggest update commands
4. Only proceed when all REQUIRED tools show ✅

## Configuration
Before starting, create `app_config.yaml`:
```yaml
app:
  name: my_lg_app
  description: My Liquid Galaxy visualization
  platforms: [android]
  screens:
    - splash
    - connection
    - main
    - settings
    - help
    - visualization  # custom screen
lg:
  host: 192.168.56.101
  port: 22
  user: lg
  password: lg
  total_screens: 3
```

---

### Stage 1: Initialize Project
**Skill**: `lg-flutter-init` + `lg-init`
**Actions**:
1. Read `app_config.yaml` for project identity, screen count, and platform targets.
2. **Create new app in a SEPARATE sibling directory** (NOT inside `LGFlutterStarterKit`).
3. Copy starter kit scaffolding (flutter_client/, .github/, .gitignore, node_server/) into new directory.
4. Initialize Git repo in the new directory.
5. Create GitHub repo via `lg-github-agent` and push initial commit.
6. Create/verify directory structure with layered architecture (`providers/`, `models/`, `services/`, `screens/`, `widgets/`).
7. Configure `pubspec.yaml` with required dependencies.
8. Configure `config.dart` with LG rig connection defaults.
9. Run `flutter pub get`.
10. Run `flutter analyze` -- must pass.
11. Commit: `init: project scaffolding from config`.
12. **All subsequent stages operate in the NEW app directory.**

### Stage 2: SSH Service
**Skill**: `lg-ssh-controller`
**Actions**:
1. Implement `SSHService` with dartssh2.
2. Connection management (connect, disconnect, reconnect).
3. Command execution with error handling.
4. SFTP file upload for KML.
5. Unit test SSH service (mock connection).
6. Commit: `feat(ssh): implement SSH service`.

### Stage 3: KML Service
**Skill**: `lg-kml-craftsman` + `lg-kml-writer`
**Actions**:
1. Implement `KMLService` with all KML generators.
2. Placemark, LineString, Polygon, ScreenOverlay, Tour.
3. XML validation for all generated KML.
4. Unit test each KML generator.
5. Commit: `feat(kml): implement KML service`.

### Stage 4: LG Service
**Skill**: `lg-logic-builder`
**Actions**:
1. Implement `LGService` wrapping SSH + KML.
2. FlyTo, search, orbit, reboot, shutdown.
3. Logo display on slave screen.
4. Clean KML from all screens.
5. Commit: `feat(lg): implement LG service`.

### Stage 5: State Management
**Skill**: `lg-logic-builder`
**Actions**:
1. `SettingsProvider` with SharedPreferences persistence.
2. `ThemeProvider` with light/dark/system modes.
3. Wire `LGService` as a provider.
4. Unit test providers.
5. Commit: `feat(state): implement providers`.

### Stage 6: Core Screens
**Skill**: `lg-ui-scaffolder`
**Actions**:
1. `SplashScreen` — animated logo, 2s delay → connection.
2. `ConnectionScreen` — SSH form with host/port/user/pass, connect + skip buttons.
3. `MainScreen` — action buttons (flyTo, orbit, KML, reboot, disconnect).
4. `SettingsScreen` — connection info, theme switcher, reset.
5. `HelpScreen` — usage guide, architecture overview.
6. Widget tests for each screen.
7. Commit: `feat(ui): implement core screens`.

### Stage 7: Custom Visualization
**Skill**: `lg-viz-architect` + `lg-data-pipeline`
**Actions**:
1. Design visualization architecture.
2. Implement data fetching (API or mock).
3. Transform data to KML.
4. Display on LG rig (or emulator preview).
5. Commit: `feat(viz): implement visualization`.

### Stage 8: Security Scan
**Skill**: `lg-shield`
**Actions**:
1. Scan for hardcoded credentials.
2. Check SSH command safety.
3. Audit dependencies.
4. Generate shield report.
5. Commit: `chore(security): security audit`.

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

### Stage 10: Build & Deploy
**Skill**: `lg-flutter-build`
**Actions**:
1. `flutter build apk --debug` — verify debug build.
2. `flutter build apk --release` — production build.
3. `adb install` on test device.
4. Verify full flow on device/emulator.
5. Commit: `build: release APK`.

### Stage 11: CI/CD
**Skill**: `lg-github-agent` + `lg-devops-agent`
**Actions**:
1. Configure GitHub Actions for CI.
2. Set up automated testing on push.
3. Configure APK artifact upload.
4. Create GitHub Release with APK.
5. Commit: `ci: GitHub Actions workflow`.

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

---

## Success Criteria
- [ ] App is in its own directory (separate from LGFlutterStarterKit)
- [ ] App has its own GitHub repo with all code pushed
- [ ] App compiles and runs on target platform (Android)
- [ ] App runs on emulator with all screens functional
- [ ] `flutter analyze` passes with zero issues
- [ ] All tests pass
- [ ] KML generation produces valid XML
- [ ] SSH connection to LG rig works (when available)
- [ ] Screenshots of all mandatory screens captured in `docs/screenshots/`
- [ ] Demo video/GIF captured in `docs/recordings/` and `docs/gifs/`
- [ ] README fully documents setup, usage, and includes screenshots
- [ ] DEVELOPMENT_LOG tracks all decisions
- [ ] GitHub Release created with APK artifact
