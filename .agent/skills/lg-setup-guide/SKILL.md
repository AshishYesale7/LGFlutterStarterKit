````skill
---
name: lg-setup-guide
description: OS-aware installation guide that walks students through installing every missing SDK, tool, or dependency. Detects macOS/Linux/Windows and provides the exact commands, multiple methods per tool, and verification steps.
---

# Setup Guide

## Overview

This skill activates when `lg-env-doctor` reports **MISSING** or **WARN** items. It detects the student's OS (from the doctor report) and provides step-by-step installation instructions with **multiple methods** per tool so the student can pick what works best for their setup.

**Announce at start:** "Some tools are missing. I'll guide you through installing them for your [OS]. Let's fix this before continuing."

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active. Students must understand WHY each tool is needed, not just blindly install.

## Principle: Multi-Method Guidance

For every tool, provide **2-3 installation methods** ranked by recommendation:
1. **Package manager** (fastest, recommended)
2. **Official installer / manual download**
3. **Version manager** (for flexibility with multiple versions)

Always end with a **verification command** so the student confirms it works.

---

## Tool Installation Guides

### 1. Flutter SDK

#### Why You Need It
Flutter compiles your Dart code into a native Android/iOS app. Without it, nothing builds.

#### macOS
```bash
# Method 1: Homebrew (RECOMMENDED)
brew install --cask flutter
# Adds flutter to PATH automatically

# Method 2: Manual download
# 1. Download from https://docs.flutter.dev/get-started/install/macos
# 2. Extract to ~/development/flutter
# 3. Add to PATH:
export PATH="$HOME/development/flutter/bin:$PATH"
# Add the above line to ~/.zshrc to persist

# Method 3: FVM (Flutter Version Manager — manage multiple versions)
brew tap leoafarias/fvm
brew install fvm
fvm install 3.24.0
fvm use 3.24.0 --force
```

#### Linux (Ubuntu/Debian)
```bash
# Method 1: Snap (RECOMMENDED)
sudo snap install flutter --classic

# Method 2: Manual download
sudo apt-get update && sudo apt-get install -y curl git unzip xz-utils zip libglu1-mesa
git clone https://github.com/flutter/flutter.git -b stable ~/development/flutter
export PATH="$HOME/development/flutter/bin:$PATH"
# Add to ~/.bashrc to persist

# Method 3: FVM
dart pub global activate fvm
fvm install 3.24.0
fvm use 3.24.0 --force
```

#### Linux (Fedora)
```bash
# Method 1: Manual download (no snap on Fedora by default)
sudo dnf install -y git curl unzip which xz zip mesa-libGLU
git clone https://github.com/flutter/flutter.git -b stable ~/development/flutter
export PATH="$HOME/development/flutter/bin:$PATH"
```

#### Windows
```powershell
# Method 1: Chocolatey (RECOMMENDED)
choco install flutter

# Method 2: Manual download
# 1. Download from https://docs.flutter.dev/get-started/install/windows
# 2. Extract to C:\src\flutter
# 3. Add C:\src\flutter\bin to System PATH

# Method 3: Scoop
scoop install flutter
```

#### Verify
```bash
flutter --version
flutter doctor
```

---

### 2. Java / JDK 17

#### Why You Need It
Android builds use Gradle, which requires a JDK. JDK 17 is required for modern Android Gradle Plugin (AGP 8+).

#### macOS
```bash
# Method 1: Homebrew (RECOMMENDED)
brew install openjdk@17
sudo ln -sfn $(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
# Add to ~/.zshrc

# Method 2: SDKMAN (manage multiple JDK versions)
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 17.0.9-tem
sdk use java 17.0.9-tem

# Method 3: Download from Adoptium
# https://adoptium.net/temurin/releases/?version=17
```

#### Linux (Ubuntu/Debian)
```bash
# Method 1: APT (RECOMMENDED)
sudo apt-get update
sudo apt-get install -y openjdk-17-jdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
# Add to ~/.bashrc

# Method 2: SDKMAN (same as macOS Method 2)
```

#### Linux (Fedora)
```bash
sudo dnf install -y java-17-openjdk-devel
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
```

#### Windows
```powershell
# Method 1: Chocolatey
choco install temurin17

# Method 2: Scoop
scoop bucket add java
scoop install temurin17-jdk

# Method 3: Download from https://adoptium.net/temurin/releases/?version=17
# Set JAVA_HOME in System Environment Variables
```

#### Verify
```bash
java -version    # Should show openjdk 17.x.x
javac -version
echo $JAVA_HOME
```

---

### 3. Android SDK & Command-Line Tools

#### Why You Need It
Compiles Flutter code to Android APK. Provides `adb` for device deployment/debugging.

#### All Platforms (via Android Studio — RECOMMENDED)
```
1. Install Android Studio: https://developer.android.com/studio
2. Open Android Studio → More Actions → SDK Manager
3. SDK Platforms tab → Check "Android 14 (API 34)" or latest
4. SDK Tools tab → Check:
   - Android SDK Build-Tools
   - Android SDK Command-line Tools (latest)
   - Android SDK Platform-Tools
   - Android Emulator (if you want AVD)
5. Click Apply → Download
```

#### macOS (command-line only — no Android Studio)
```bash
# Install cmdline-tools
brew install --cask android-commandlinetools

# Set environment
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
# Add to ~/.zshrc

# Install required SDK components
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"

# Accept licenses
flutter doctor --android-licenses
```

#### Linux
```bash
# Set environment (after Android Studio or manual install)
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"
# Add to ~/.bashrc

# Accept licenses
flutter doctor --android-licenses
```

#### Verify
```bash
adb --version
sdkmanager --version
flutter doctor   # Should show Android toolchain ✓
```

---

### 4. Node.js & npm

#### Why You Need It
The `node_server/` component provides an Express REST API server. Optional but included in the starter kit.

#### macOS
```bash
# Method 1: Homebrew (RECOMMENDED)
brew install node@20

# Method 2: nvm (manage multiple versions)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.zshrc
nvm install 20
nvm use 20

# Method 3: Official installer
# https://nodejs.org/en/download/
```

#### Linux (Ubuntu/Debian)
```bash
# Method 1: NodeSource (RECOMMENDED)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Method 2: nvm (same as macOS Method 2 using ~/.bashrc)

# Method 3: Snap
sudo snap install node --classic --channel=20
```

#### Linux (Fedora)
```bash
sudo dnf install -y nodejs npm
# Or use nvm for specific version
```

#### Windows
```powershell
# Method 1: Chocolatey
choco install nodejs-lts

# Method 2: nvm-windows
# https://github.com/coreybutler/nvm-windows/releases
nvm install 20
nvm use 20

# Method 3: Official installer from https://nodejs.org
```

#### Verify
```bash
node --version   # Should show v20.x.x
npm --version
```

---

### 5. Git

#### Why You Need It
Version control. Every pipeline stage commits progress. The workflows won't start without it.

#### macOS
```bash
# Method 1: Xcode Command Line Tools (likely already installed)
xcode-select --install

# Method 2: Homebrew
brew install git
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update && sudo apt-get install -y git
```

#### Linux (Fedora)
```bash
sudo dnf install -y git
```

#### Windows
```powershell
# Method 1: Chocolatey
choco install git

# Method 2: Official installer
# https://git-scm.com/download/win
```

#### Verify
```bash
git --version
git config --global user.name    # Should be set
git config --global user.email   # Should be set
```

---

### 6. Google Earth Pro (Desktop)

#### Why You Need It
Lets you visually test `.kml` files on your machine without needing a physical LG rig. Open KMLs directly to see placemarks, tours, and overlays.

#### macOS
```bash
# Download and install:
# https://www.google.com/earth/about/versions/#earth-pro
# Or via Homebrew:
brew install --cask google-earth-pro
```

#### Linux (Ubuntu/Debian)
```bash
# Download .deb from: https://www.google.com/earth/about/versions/#earth-pro
sudo dpkg -i google-earth-pro-stable_current_amd64.deb
sudo apt-get -f install   # Fix dependencies if needed
```

#### Linux (Fedora)
```bash
# Download .rpm from: https://www.google.com/earth/about/versions/#earth-pro
sudo dnf install google-earth-pro-stable-current.x86_64.rpm
```

#### Windows
```
Download and install from: https://www.google.com/earth/about/versions/#earth-pro
```

#### Verify
Open Google Earth Pro → File → Open → select any `.kml` file from `assets/kml/`.

---

### 7. Xcode (macOS only — iOS builds)

#### Why You Need It
Required only if you're building for iOS. Provides the iOS SDK, Simulator, and signing tools.

```bash
# Install from Mac App Store (RECOMMENDED)
# Or via command line:
xcode-select --install

# After install, accept license:
sudo xcodebuild -license accept

# Install CocoaPods (iOS dependency manager):
sudo gem install cocoapods
# Or via Homebrew:
brew install cocoapods

# Verify
xcodebuild -version
pod --version
```

---

### 8. SSH Client

#### Why You Need It
Manual debugging of the LG rig. The app uses `dartssh2` (Dart), but you need terminal SSH for troubleshooting.

#### macOS / Linux
```bash
# Already installed (OpenSSH). Verify:
ssh -V

# If somehow missing on Linux:
sudo apt-get install -y openssh-client   # Ubuntu/Debian
sudo dnf install -y openssh-clients      # Fedora
```

#### Windows
```powershell
# OpenSSH is built into Windows 10+. Verify:
ssh -V

# If missing, install via Optional Features:
# Settings → Apps → Optional Features → Add → OpenSSH Client
```

---

### 9. VS Code Extensions (Recommended)

After VS Code is installed, guide the student to install these:

```bash
code --install-extension Dart-Code.dart-code
code --install-extension Dart-Code.flutter
code --install-extension ms-vscode.vscode-json
```

---

## Post-Installation: Re-Run Doctor

After installing all missing tools:

```bash
# Re-run the environment doctor to verify everything
flutter doctor -v
```

Guide:
1. Confirm every tool now shows `PASS`.
2. If any tool still fails, troubleshoot (likely PATH issue).
3. Once all clear → hand off to `lg-resume-pipeline` to pick up where you left off.

## Handoff

- **All tools installed** → `.agent/skills/lg-resume-pipeline/SKILL.md` to continue the interrupted pipeline.
- **Still failing** → `.agent/skills/lg-debugger/SKILL.md` for advanced troubleshooting.
- **Student confused about WHY** → `.agent/skills/lg-critical-advisor/SKILL.md` for educational coaching.

````
