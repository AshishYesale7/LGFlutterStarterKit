# Contributing to LG Flutter Starter Kit

Thank you for your interest in contributing! This project is the starter template and agentic system for the Liquid Galaxy Agentic Programming Contest.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Code Standards](#code-standards)
- [Making Changes](#making-changes)
- [Pull Request Process](#pull-request-process)
- [What to Contribute](#what-to-contribute)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Report unacceptable behavior to **ashishyesale7@gmail.com**.

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/<your-username>/LGFlutterStarterKit.git
   cd LGFlutterStarterKit
   ```
3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

```bash
cd flutter_client
flutter pub get
```

> **Important**: This is a **template** repository. Do NOT run `flutter create .` here — platform directories (`android/`, `ios/`, `test/`) are generated when students create their own app via Antigravity.

### Node.js Server (Optional)

```bash
cd server
npm install
npm start
```

## Project Structure

```
LGFlutterStarterKit/
├── .agent/              # Antigravity agent system (skills, rules, workflows)
├── .github/workflows/   # CI/CD pipelines
├── flutter_client/      # Flutter starter app
│   └── lib/
│       ├── models/      # Immutable data classes
│       ├── modules/     # Feature modules
│       ├── providers/   # State management (ChangeNotifier)
│       ├── screens/     # UI screens
│       ├── services/    # Business logic (LG, SSH, KML, API)
│       └── widgets/     # Reusable widgets
├── server/              # Node.js companion server
├── DOCUMENTATION/       # Comprehensive technical docs
└── docs/                # Design plans and reviews
```

## Code Standards

### 5-Layer Architecture (Mandatory)

This project enforces strict import boundaries. Violations will be flagged:

| Layer | Files | Cannot Import |
|-------|-------|---------------|
| **Presentation** | `screens/`, `widgets/` | `dartssh2`, `http`, `kml_service` |
| **Orchestration** | `lg_service.dart` | — (coordinates everything) |
| **Data Providers** | `providers/`, API services | `dartssh2` directly |
| **KML Generation** | `kml_service.dart` | `dartssh2`, `ssh_service` |
| **Transport** | `ssh_service.dart` | `kml_service`, `models/` |

### Dart Style

- Follow [Effective Dart](https://dart.dev/effective-dart) guidelines
- Use `///` doc comments on all public APIs
- Run before every commit:
  ```bash
  cd flutter_client
  dart format .
  flutter analyze
  ```
- Zero warnings required — CI blocks merges with lint errors

### Commit Messages

Use clear, descriptive commit messages following conventional format:

```
feat: add orbit camera tour to KMLService
fix: SSH reconnection after timeout
docs: update architecture-map with data flow diagram
refactor: extract KML overlay into separate method
test: add unit tests for KMLService.generateFlyTo
```

| Prefix | Use For |
|--------|---------|
| `feat:` | New features or capabilities |
| `fix:` | Bug fixes |
| `docs:` | Documentation changes |
| `refactor:` | Code restructuring (no behavior change) |
| `test:` | Adding or updating tests |
| `chore:` | Build, CI, or tooling changes |

## Making Changes

1. **Understand the architecture** — read [DOCUMENTATION/architecture.md](DOCUMENTATION/architecture.md)
2. **One concern per PR** — keep changes focused and reviewable
3. **Test locally**:
   ```bash
   cd flutter_client
   flutter analyze         # Must pass with zero warnings
   dart format --set-exit-if-changed .  # Must pass
   flutter test            # If tests exist
   ```
4. **Update documentation** if you change public APIs or architecture
5. **Don't modify `.agent/`** unless your PR is specifically about agent skills/rules

## Pull Request Process

1. Push your branch and open a PR against `main`
2. Fill in the PR template with:
   - What the change does
   - How to test it
   - Screenshots (for UI changes)
3. Ensure CI passes (flutter-ci.yml)
4. Address review feedback

### PR Checklist

- [ ] Code follows the 5-layer architecture rules
- [ ] `flutter analyze` passes with zero warnings
- [ ] `dart format` applied to all changed files
- [ ] Doc comments (`///`) on new public APIs
- [ ] No hardcoded credentials or API keys
- [ ] Updated relevant documentation
- [ ] Commit messages follow conventional format

## What to Contribute

### Good First Issues

- Add unit tests for `KMLService` (pure functions, easy to test)
- Improve KML generation (new element types, tour patterns)
- Add API service templates (weather, satellites, etc.)
- Improve error messages and user feedback in screens
- Add more screen templates for common LG app patterns

### Larger Contributions

- SSH reconnection and keep-alive strategy
- KML validation before sending to rig
- Interactive settings editor with real-time validation
- New agent skills for specialized tasks
- Performance optimizations for large KML datasets

### Agent System Contributions

If you want to contribute to the `.agent/` system:

1. Each skill lives in `.agent/skills/<skill-name>/SKILL.md`
2. Rules live in `.agent/rules/<rule-name>.md`
3. Workflows live in `.agent/workflows/<workflow-name>.md`
4. Follow the existing SKILL.md format and naming conventions
5. Test your skill through the Antigravity conversational interface

## Reporting Issues

When reporting bugs, include:

- **Flutter version**: Output of `flutter --version`
- **Steps to reproduce**: Numbered steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **LG rig config**: Screen count, OS, network setup
- **Screenshots/logs**: If applicable

For security issues, see [SECURITY.md](SECURITY.md) — **do not open a public issue**.

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).
