````skill
---
name: lg-dependency-resolver
description: Resolves Flutter/Dart package conflicts, pub get failures, Gradle errors, CocoaPods issues, and version mismatches. Diagnoses the specific error and walks the student through the fix.
---

# Dependency Resolver

## Overview

This skill activates when `flutter pub get` fails, Gradle builds break, or package version conflicts arise. It reads the actual error output, classifies the problem, and provides the targeted fix — not a generic "try flutter clean."

**Announce at start:** "Dependency issue detected. Let me analyze the error and find the right fix."

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active. Students should understand what dependency resolution means and why version constraints matter.

## Diagnostic Flow

```
Error Output → Classify → Targeted Fix → Verify → Resume
```

---

## Category 1: Flutter Pub Get Failures

### 1.1 Version Conflict (Incompatible Constraints)
**Symptom**: `Because X depends on Y >=2.0.0 and Z depends on Y <2.0.0, version solving failed.`

**Fix Steps:**
1. Read the conflict message carefully — identify the two packages in conflict.
2. Check which package is outdated:
   ```bash
   flutter pub outdated
   ```
3. Try upgrading to latest compatible versions:
   ```bash
   flutter pub upgrade --major-versions
   ```
4. If still failing, use dependency_overrides (TEMPORARY — never ship with overrides):
   ```yaml
   # pubspec.yaml — TEMPORARY FIX, remove before release
   dependency_overrides:
     conflicting_package: ^2.0.0
   ```
5. Best fix: update both packages to versions that agree on the shared dependency.

### 1.2 Package Not Found
**Symptom**: `Could not find package "xxx" on pub.dev`

**Fix Steps:**
1. Check spelling in `pubspec.yaml`.
2. Verify package exists: `https://pub.dev/packages/xxx`
3. Check if it's a git dependency that needs a URL:
   ```yaml
   dependencies:
     custom_package:
       git:
         url: https://github.com/user/package.git
         ref: main
   ```
4. For private packages, check authentication.

### 1.3 SDK Constraint Mismatch
**Symptom**: `The current Dart SDK version is X. Because Y requires SDK version >=Z, version solving failed.`

**Fix Steps:**
1. Check your Dart/Flutter version:
   ```bash
   dart --version
   flutter --version
   ```
2. Option A — Upgrade Flutter:
   ```bash
   flutter upgrade
   ```
3. Option B — Relax the constraint in `pubspec.yaml`:
   ```yaml
   environment:
     sdk: '>=3.0.0 <4.0.0'
   ```
4. Option C — Use an older version of the package that supports your SDK.

### 1.4 Network / Proxy Issues
**Symptom**: `Connection refused`, `SocketException`, `Could not resolve host pub.dev`

**Fix Steps:**
1. Check internet: `ping pub.dev`
2. If behind a proxy:
   ```bash
   export HTTP_PROXY=http://proxy:port
   export HTTPS_PROXY=http://proxy:port
   export NO_PROXY=localhost,127.0.0.1
   ```
3. If using a VPN, try disconnecting temporarily.
4. Try a different DNS: `8.8.8.8` or `1.1.1.1`.
5. Use pub cache if offline:
   ```bash
   flutter pub get --offline
   ```

---

## Category 2: Gradle / Android Build Failures

### 2.1 Gradle Version Mismatch
**Symptom**: `Could not determine the dependencies of task ':app:compileDebugJavaWithJavac'` or `Unsupported class file major version`

**Fix Steps:**
1. Check `android/build.gradle` for the AGP (Android Gradle Plugin) version.
2. Check `android/gradle/wrapper/gradle-wrapper.properties` for the Gradle version.
3. Compatibility matrix:
   | AGP Version | Required Gradle | Required JDK |
   |-------------|----------------|--------------|
   | 8.1+        | 8.0+           | JDK 17       |
   | 7.4         | 7.5+           | JDK 11-17    |
   | 7.0-7.3     | 7.0+           | JDK 11       |
4. Update `gradle-wrapper.properties`:
   ```properties
   distributionUrl=https\://services.gradle.org/distributions/gradle-8.4-all.zip
   ```
5. Ensure `JAVA_HOME` points to the correct JDK:
   ```bash
   echo $JAVA_HOME
   java -version
   ```

### 2.2 Android SDK Not Found
**Symptom**: `SDK location not found. Define location with sdk.dir in local.properties`

**Fix Steps:**
1. Create/update `android/local.properties`:
   ```properties
   # macOS (typical)
   sdk.dir=/Users/<username>/Library/Android/sdk
   # Linux
   sdk.dir=/home/<username>/Android/Sdk
   # Windows
   sdk.dir=C:\\Users\\<username>\\AppData\\Local\\Android\\sdk
   ```
2. Or set environment variable:
   ```bash
   export ANDROID_HOME="$HOME/Library/Android/sdk"   # macOS
   export ANDROID_HOME="$HOME/Android/Sdk"            # Linux
   ```

### 2.3 Missing Android Platform / Build Tools
**Symptom**: `Failed to find target with hash string 'android-34'`

**Fix Steps:**
```bash
# Install the missing platform
sdkmanager "platforms;android-34"
sdkmanager "build-tools;34.0.0"

# Or via Android Studio: SDK Manager → SDK Platforms → check the required API level
```

### 2.4 License Not Accepted
**Symptom**: `Android license status unknown` or `You have not accepted the license agreements`

**Fix Steps:**
```bash
flutter doctor --android-licenses
# Press 'y' for each license prompt
```

### 2.5 minSdkVersion Too Low
**Symptom**: `uses-sdk:minSdkVersion 16 cannot be smaller than version 21 declared in library`

**Fix Steps:**
Update `android/app/build.gradle`:
```groovy
defaultConfig {
    minSdkVersion 21    // Required for many Flutter plugins
    targetSdkVersion 34
}
```

---

## Category 3: iOS / CocoaPods Failures

### 3.1 CocoaPods Not Installed
**Symptom**: `CocoaPods not installed`

**Fix Steps:**
```bash
# macOS
sudo gem install cocoapods
# Or via Homebrew:
brew install cocoapods

# Then:
cd ios && pod install && cd ..
```

### 3.2 Pod Install Fails
**Symptom**: `CDN: trunk URL couldn't be downloaded` or dependency conflicts

**Fix Steps:**
```bash
cd ios
pod deintegrate
pod cache clean --all
rm Podfile.lock
pod repo update
pod install
cd ..
```

### 3.3 Xcode Build Signing
**Symptom**: `No signing certificate` or `Provisioning profile` errors

**Fix Steps:**
1. Open `ios/Runner.xcworkspace` in Xcode.
2. Select Runner target → Signing & Capabilities.
3. Set Team to your Apple Developer account (free or paid).
4. For development, enable "Automatically manage signing."

---

## Category 4: Flutter Clean & Nuclear Options

When targeted fixes don't work, escalate through these levels:

### Level 1: Soft Reset
```bash
flutter clean
flutter pub get
```

### Level 2: Cache Clear
```bash
flutter clean
flutter pub cache clean
flutter pub get
```

### Level 3: Full Reset
```bash
flutter clean
rm -rf .dart_tool/
rm -rf build/
rm pubspec.lock
flutter pub get
```

### Level 4: Android Nuclear
```bash
flutter clean
cd android
./gradlew clean
rm -rf .gradle/
rm -rf build/
cd ..
flutter pub get
```

### Level 5: iOS Nuclear
```bash
flutter clean
cd ios
rm -rf Pods/
rm Podfile.lock
rm -rf .symlinks/
pod cache clean --all
pod install
cd ..
flutter pub get
```

---

---

## Category 5: Known Good Plugin Stack for LG Apps

**Reference**: `demo/DEPENDENCIES.md` in the starter kit contains the verified plugin versions from a working LG Task 2 demo.

### Verified Core Plugins

| Package | Version | Purpose |
|---------|---------|--------|
| `google_maps_flutter` | `^2.10.1` | In-app map view for location picking |
| `dartssh2` | `^2.9.0+2` | SSH to LG rig master (pure Dart, recommended) |
| `ssh2` | `^2.2.3` | SSH alternative (native build, used in older LG apps) |
| `shared_preferences` | `^2.5.3` | Persistent connection settings |
| `path_provider` | `^2.1.5` | File system paths for KML temp files |
| `provider` | `^6.1.1` | State management |
| `xml` | `^6.3.0` | KML generation & parsing |
| `http` | `^1.2.0` | REST API calls |
| `flutter_secure_storage` | `^9.0.0` | Encrypted password storage |
| `web_socket_channel` | `^3.0.1` | WebSocket for Node.js server |

### Platform Compatibility

| Plugin | Android | iOS | macOS | Linux | Web |
|--------|---------|-----|-------|-------|-----|
| `google_maps_flutter` | ✅ | ✅ | — | — | ✅ |
| `ssh2` / `dartssh2` | ✅ | ✅ | — | — | — |
| `path_provider` | ✅ | ✅ | ✅ | ✅ | — |
| `shared_preferences` | ✅ | ✅ | ✅ | ✅ | ✅ |

**Key**: SSH and Google Maps are mobile-only — LG controller apps target Android/iOS primarily.

When a student hits dependency issues, **check their versions against this table first** — mismatched versions are the #1 cause of build failures.

---

## Post-Fix Verification

After applying any fix, always run:
```bash
flutter pub get       # Dependencies resolve?
flutter analyze       # No static errors?
flutter test          # Tests still pass?
flutter build apk     # Builds successfully? (Android)
```

## ⛔ Student Interaction Checkpoints

### After Diagnosing — Explain Before Fixing

⛔ **STOP and WAIT** — After identifying the dependency issue, ask:
> *"I found the issue: [describe the conflict/error]. Before I fix it — can you explain why this version conflict happens? What does it mean when two packages depend on different versions of the same library?"*

Wait for the student's answer. Evaluate:
- ✅ **Correct**: Great, they understand semantic versioning and transitive dependencies.
- ⚠️ **Partially correct**: Explain the dependency graph concept — Package A needs X v1, Package B needs X v2.
- ❌ **Wrong or "just fix it"**: Trigger **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md). Understanding dependency resolution is essential.

### After Fixing — Predict the Verification

⛔ **STOP and WAIT** — Before running verification, ask:
> *"I'm about to run `flutter pub get` and `flutter analyze`. What do you expect to see? Will there be any warnings?"*

Let the student predict the outcome, then run the command so they can compare.

### Nuclear Options — Understand the Escalation

If escalating to Level 2+ cleanup, present multiple choice:
> *"We need to clear more caches. Which of these is the most aggressive?"*
> A) `flutter clean`
> B) Deleting `.dart_tool/`
> C) Deleting `pubspec.lock`

⛔ **STOP and WAIT** — Let them pick and explain their reasoning.

## Handoff

- **Fixed** → Return to the pipeline stage that triggered the error. Use `.agent/skills/lg-resume-pipeline/SKILL.md`.
- **Still broken** → Escalate to `.agent/skills/lg-debugger/SKILL.md` for deeper diagnosis.
- **Student doesn't understand** → `.agent/skills/lg-critical-advisor/SKILL.md` for educational coaching on dependency management.

## 🔗 Skill Chain

After the dependency issue is resolved and verified, **automatically offer to resume the interrupted pipeline**:

> *"Dependencies resolved! All packages are compatible and `flutter analyze` passes clean. Let's pick up where we left off. Ready to resume? 🔄"*

If student says "ready" → activate `.agent/skills/lg-resume-pipeline/SKILL.md`.

````
