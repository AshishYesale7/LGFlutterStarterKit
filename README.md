# LG Flutter Starter Kit

A comprehensive starter template for building **Google Summer of Code (GSoC)** projects that interact with the **Liquid Galaxy** multi-display system.

## Features

- **SSH Communication**: Connect to LG rig via dartssh2
- **KML Generation**: Create placemarks, overlays, tours, and more
- **LG Control**: FlyTo, orbit, reboot, clean KML, logo display
- **Material 3 UI**: Modern Flutter design with light/dark themes
- **Provider State Management**: Clean architecture with ChangeNotifier
- **Node.js Server**: Optional backend for data processing
- **Antigravity Agent System**: 33 AI skills for guided development

## Quick Start

```bash
# Clone
git clone https://github.com/<username>/LGFlutterStarterKit.git
cd LGFlutterStarterKit/flutter_client

# Install dependencies
flutter pub get

# Run on emulator or device
flutter run
```

## Project Structure

```
LGFlutterStarterKit/
├── flutter_client/          # Flutter app
│   ├── lib/
│   │   ├── config.dart      # LG rig configuration
│   │   ├── main.dart        # App entry with MultiProvider
│   │   ├── models/          # Data classes
│   │   ├── providers/       # State management
│   │   ├── screens/         # UI pages
│   │   ├── services/        # SSH, LG, KML services
│   │   └── modules/         # Optional modules
│   └── pubspec.yaml
├── server/                  # Node.js companion server
│   ├── index.js
│   └── package.json
├── .agent/                  # Antigravity agent system
│   ├── skills/              # 33 development skills
│   ├── workflows/           # 4 pipeline workflows
│   └── rules/               # 5 coding rules
├── .github/workflows/       # CI/CD pipelines
└── docs/                    # Documentation
```

## Screen Flow

```
Splash → Connection → Main → (Settings | Help)
```

## LG Rig Configuration

Default settings in `config.dart`:
| Setting | Default |
|---------|---------|
| Host | 192.168.56.101 |
| Port | 22 |
| Username | lg |
| Password | lg |
| Screens | 3 (lg3=left, lg1=master, lg2=right) |

## Dependencies

| Package | Purpose |
|---------|---------|
| dartssh2 | SSH communication |
| provider | State management |
| http | HTTP requests |
| xml | KML validation |
| shared_preferences | Settings persistence |
| flutter_secure_storage | Credential storage |
| path_provider | File system access |

## Antigravity Agent System

This project includes 33 AI development skills:

**Core**: lg-init, lg-flutter-init, lg-exec, lg-plan-writer, lg-brainstormer
**Architecture**: lg-logic-builder, lg-ui-scaffolder, lg-file-generator
**LG Specific**: lg-ssh-controller, lg-kml-craftsman, lg-kml-writer, lg-viz-architect
**Quality**: lg-code-reviewer, lg-tester, lg-shield, lg-debugger
**DevOps**: lg-github-agent, lg-flutter-build, lg-devops-agent
**Converters**: lg-dart-converter, lg-code-converter, lg-api-integrator, lg-data-pipeline
**Teaching**: lg-quiz-master, lg-critical-advisor, lg-learning-resources
**Environment**: lg-env-doctor, lg-setup-guide, lg-dependency-resolver, lg-resume-pipeline
**Visual**: lg-emulator-manager, lg-demo-recorder
**Fun**: lg-nanobanana-sprite

## Node.js Server (Optional)

```bash
cd server
npm install
node index.js
# Server runs on http://localhost:3000
```

## Building

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# With LG host override
flutter build apk --dart-define=LG_HOST=192.168.56.101
```

## License

This project is part of the Liquid Galaxy GSoC initiative.
