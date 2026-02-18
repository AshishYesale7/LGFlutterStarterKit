---
name: lg-devops-agent
description: Manages CI/CD pipelines, Docker configurations, LG rig deployment, and build automation for Liquid Galaxy Flutter applications.
---

# Liquid Galaxy DevOps Agent

## Overview

This skill handles the infrastructure and deployment side of Liquid Galaxy Flutter app development. It covers CI/CD pipelines, Docker containers for development, LG rig deployment, and build automation.

> **Context**: Gemini Summer of Code 2026 — Task 2 requires a deployable Flutter app. DevOps ensures builds pass, Docker mock rigs work, and the APK is contest-ready.

**Announce at start:** "I'm using the lg-devops-agent skill to set up [DevOps Task]."

## 🐳 Docker for LG Development

### SSH Mock Server (for development without a physical rig)

```dockerfile
# Dockerfile.lg-mock
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'lg:lg' | chpasswd
RUN mkdir -p /var/www/html/kml
RUN echo "" > /var/www/html/kml/slave_0.kml
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

```bash
# Build and run
docker build -t lg-mock -f Dockerfile.lg-mock .
docker run -d -p 2222:22 --name lg-mock lg-mock

# Test SSH connection
ssh -p 2222 lg@localhost  # password: lg
```

### Docker Compose (mock rig + optional data proxy)

```yaml
version: '3.8'
services:
  lg-mock:
    build:
      context: .
      dockerfile: Dockerfile.lg-mock
    ports:
      - "2222:22"
    volumes:
      - ./kml-data:/var/www/html/kml

  data-proxy:
    build: ./server
    ports:
      - "3000:3000"
    environment:
      - OPENWEATHER_API_KEY=${OPENWEATHER_API_KEY}
```

## 🔄 GitHub Actions CI/CD

### Flutter Analysis + Tests

```yaml
# .github/workflows/flutter-ci.yml
name: Flutter CI
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  analyze-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
          channel: 'stable'

      - name: Install dependencies
        working-directory: flutter_client
        run: flutter pub get

      - name: Analyze
        working-directory: flutter_client
        run: flutter analyze

      - name: Format check
        working-directory: flutter_client
        run: dart format --set-exit-if-changed .

      - name: Run tests
        working-directory: flutter_client
        run: flutter test --coverage

      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: flutter_client/coverage/lcov.info
```

### Android APK Build

```yaml
# .github/workflows/build-apk.yml
name: Build APK
on:
  push:
    tags: ['v*']

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'

      - name: Build APK
        working-directory: flutter_client
        run: flutter build apk --release --split-per-abi

      - name: Upload APK artifacts
        uses: actions/upload-artifact@v4
        with:
          name: release-apk
          path: flutter_client/build/app/outputs/flutter-apk/*.apk
```

## 📦 Deployment to LG Rig

### Deploy KML Assets to Rig
```bash
#!/bin/bash
# deploy-assets.sh — Upload custom assets to LG rig
LG_HOST="${LG_HOST:-192.168.1.100}"
LG_USER="${LG_USER:-lg}"

echo "Deploying assets to LG rig ($LG_HOST)..."
scp -r assets/* $LG_USER@$LG_HOST:/var/www/html/assets/
echo "Assets deployed. Accessible at http://$LG_HOST:81/assets/"
```

### Install APK on Connected Android Device
```bash
#!/bin/bash
# deploy-apk.sh — Install the release APK on a connected Android device
cd flutter_client
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
echo "APK installed. Launch the app on the device."
```

## 🔧 Environment Setup Checklist

### For New Developers
1. Install Flutter SDK: `flutter doctor` should pass.
2. Clone the repo.
3. `cd flutter_client && flutter pub get`
4. `flutter analyze` — zero errors.
5. Optional: `docker compose up -d` for mock LG rig.
6. `flutter run -d <device>` to test.

### For LG Rig Admin
1. Ensure all rig machines are on the same subnet.
2. SSH access configured for user `lg` on master.
3. `/var/www/html/kml/` writable from SSH.
4. Google Earth Pro installed and running on all machines.
5. `lg-sync` service running to sync master → slaves.

## Reference Links

- **LG rig setup scripts**: https://github.com/LiquidGalaxyLAB/liquid-galaxy
- **Flutter CI best practices**: https://docs.flutter.dev/testing/build-modes
- **GitHub Actions Flutter**: https://github.com/marketplace/actions/flutter-action
- **Docker SSH for testing**: https://hub.docker.com/r/linuxserver/openssh-server
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## ⛔ Student Interaction Checkpoints

### After CI/CD Setup — Understand the Pipeline

⛔ **STOP and WAIT** — After setting up GitHub Actions, ask:
> *"Look at the flutter-ci.yml workflow we just created. Can you describe what happens step-by-step when you push code to the `main` branch?"*

Wait for the student's answer. Evaluate:
- ✅ **Correct**: They understand the CI pipeline flow (checkout → deps → analyze → format → test → coverage).
- ⚠️ **Partially correct**: Highlight the steps they missed.
- ❌ **Wrong**: Walk through the YAML step by step. Link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md).

### Docker Setup — Predict Behavior

⛔ **STOP and WAIT** — After Docker mock rig setup, present multiple choice:
> *"What does port 2222 map to in the Docker container? If I SSH to `localhost:2222`, what am I connecting to?"*
> A) The LG master's Google Earth instance
> B) A mock SSH server simulating the LG rig
> C) The Flutter app's debug server

### Deployment — Build Strategy

⛔ **STOP and WAIT** — Before deploying, ask:
> *"Why do we use `--split-per-abi` when building the release APK? What are the trade-offs of splitting vs. a fat APK?"*

## 📋 Doc Save

After CI/CD setup is complete, save a summary:

**Save to:** `docs/reviews/YYYY-MM-DD-cicd-setup.md`

Include:
- CI pipeline configuration summary
- Docker setup status
- Deployment scripts created
- Any environment-specific notes

## Handoff
After DevOps setup → return to calling skill (typically `lg-exec` or `lg-flutter-build`).

## 🔗 Skill Chain

After CI/CD and deployment configuration is complete, **automatically offer the next stage**:

> *"DevOps pipeline is configured! CI will run on every push and PRs will get automatic Flutter analysis. Ready to build the release APK? 🏗️"*

If student says "ready" → activate `.agent/skills/lg-flutter-build/SKILL.md`.
