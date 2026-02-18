# CI/CD & Quality

> GitHub Actions workflows, static analysis configuration, and code quality standards.

---

## Table of Contents

- [Overview](#overview)
- [GitHub Actions Workflows](#github-actions-workflows)
  - [Flutter CI](#flutter-ci-flutter-ciyml)
  - [Flutter Build](#flutter-build-flutter-buildyml)
  - [Security Scan](#security-scan-security-scanyml)
- [Static Analysis](#static-analysis)
- [Code Quality Standards](#code-quality-standards)
- [Quality Checklist](#quality-checklist)

---

## Overview

The project uses 3 GitHub Actions workflows for continuous integration, automated builds, and security scanning. Combined with local static analysis via `analysis_options.yaml`, they ensure code quality at every stage.

| Workflow | Purpose | Trigger |
|----------|---------|---------|
| Flutter CI | Lint + format + test | Push/PR to `main`/`develop` |
| Flutter Build | Generate APK artifacts | Push to `main`, manual dispatch |
| Security Scan | Secret detection + dependency audit | PR to `main`, weekly cron |

---

## GitHub Actions Workflows

### Flutter CI (`flutter-ci.yml`)

**Location:** `.github/workflows/flutter-ci.yml`

**Triggers:**
- Push to `main` or `develop` branch
- Pull request to `main`
- Path filter: `flutter_client/**`

**Jobs:**

#### 1. Analyze
```yaml
steps:
  - flutter pub get
  - dart format --set-exit-if-changed .      # Formatting check
  - flutter analyze --no-fatal-infos          # Static analysis
```

#### 2. Test (needs: analyze)
```yaml
steps:
  - flutter pub get
  - flutter test --coverage                   # Run all tests
  - Upload coverage/lcov.info artifact        # 14-day retention
```

**Concurrency:** Auto-cancels older runs on the same branch.

**Flutter version:** 3.24.0 stable with pub cache caching.

---

### Flutter Build (`flutter-build.yml`)

**Location:** `.github/workflows/flutter-build.yml`

**Triggers:**
- Push to `main` (path: `flutter_client/**`)
- `workflow_dispatch` with inputs:
  - `build_type`: `debug` or `release` (default: `debug`)
  - `lg_host`: LG master IP (default: `192.168.56.101`)

**Job: build-android**

```yaml
steps:
  - Setup Java 17 (temurin)
  - Setup Flutter 3.24.0
  - flutter pub get
  - flutter analyze + dart format
  - Debug build:   flutter build apk --debug --dart-define=LG_HOST=${{ inputs.lg_host }}
  - Release build: flutter build apk --release --split-per-abi --dart-define=LG_HOST=${{ inputs.lg_host }}
  - Upload APK artifacts (30-day retention)
  - Build summary in $GITHUB_STEP_SUMMARY
```

**Artifacts generated:**
- `flutter-apk-debug` — Debug APK
- `flutter-apk-release` — Release APKs (armeabi-v7a, arm64-v8a, x86_64)

---

### Security Scan (`security-scan.yml`)

**Location:** `.github/workflows/security-scan.yml`

**Triggers:**
- Pull request to `main`
- Weekly cron: Monday 08:00 UTC
- `workflow_dispatch`

**Jobs:**

#### 1. Dependency Audit
```yaml
steps:
  - flutter pub outdated       # Check for outdated packages
  - flutter pub deps           # Dependency tree summary
```

#### 2. Secret Detection
```yaml
steps:
  - grep scan for:
    - API keys (api_key, apikey, api-key patterns)
    - Hardcoded passwords (excluding 'lg' default)
    - Private key files (.pem, .key)
  - Fails CI if secrets found
```

#### 3. Node Audit
```yaml
steps:
  - cd server
  - npm install
  - npm audit --audit-level=moderate
```

---

## Static Analysis

**File:** `flutter_client/analysis_options.yaml`

**Base:** `package:flutter_lints/flutter.yaml`

### Linter Rules (18)

| Rule | Category | Description |
|------|----------|-------------|
| `avoid_print` | Error Prevention | Use `debugPrint()` instead of `print()` |
| `avoid_relative_lib_imports` | Error Prevention | Use `package:` imports |
| `prefer_const_constructors` | Performance | Const where possible |
| `prefer_const_declarations` | Performance | Const variables |
| `prefer_final_fields` | Safety | Immutable fields |
| `prefer_final_locals` | Safety | Immutable locals |
| `unnecessary_nullable_for_final_variable_declarations` | Safety | Remove unnecessary `?` |
| `always_declare_return_types` | Clarity | Explicit return types |
| `annotate_overrides` | Clarity | `@override` annotations |
| `avoid_empty_else` | Error Prevention | No empty else blocks |
| `avoid_unnecessary_containers` | Performance | Remove redundant containers |
| `prefer_is_empty` | Readability | Use `.isEmpty` |
| `prefer_is_not_empty` | Readability | Use `.isNotEmpty` |
| `sort_child_properties_last` | Readability | Widget `child:` at end |
| `use_build_context_synchronously` | Safety | BuildContext async safety |
| `slash_for_doc_comments` | Documentation | Use `///` not `/** */` |

### Analyzer Configuration

```yaml
analyzer:
  errors:
    avoid_print: warning    # Warning, not error
  exclude:
    - "**.g.dart"          # Generated files
    - "**.freezed.dart"    # Freezed generated
```

### Running Analysis

```bash
# Full analysis
flutter analyze

# Strict mode (warnings = failures)
flutter analyze --fatal-warnings

# Format check
dart format --set-exit-if-changed .
```

---

## Code Quality Standards

### SOLID Principles

| Principle | Implementation |
|-----------|---------------|
| **Single Responsibility** | Each service has one job: `KMLService` generates XML, `SSHService` transports, `LGService` orchestrates |
| **Open/Closed** | `Config` supports `--dart-define` overrides; `KMLService` methods can be extended without modifying existing ones |
| **Liskov Substitution** | All providers extend `ChangeNotifier` and can be swapped via `MultiProvider` |
| **Interface Segregation** | Screens only see `LGService` — never the full SSH or KML API surface |
| **Dependency Inversion** | Screens depend on `LGService` abstraction, not on `dartssh2` or KML internals |

### Service Layer Pattern

```
Screen → LGService → KMLService + SSHService
         (facade)    (generate)   (transport)
```

Screens **never** import `ssh_service.dart`, `kml_service.dart`, `dartssh2`, or `http` directly. All interaction goes through the `LGService` facade.

### Error Handling

| Layer | Strategy |
|-------|----------|
| Transport (`SSHService`) | Throws `StateError` if not connected. No silent failures. |
| Orchestration (`LGService`) | Propagates exceptions from transport layer |
| Presentation (screens) | Catches errors in `_executeAction()`, displays in `_statusMessage` |

### Resource Lifecycle

| Resource | Created | Disposed |
|----------|---------|----------|
| SSH connection | `LGService.connect()` | `LGService.dispose()` → `SSHService.dispose()` |
| WebSocket | `SocketService.connect()` | `SocketService.dispose()` |
| Stream controllers | `SocketService` constructor | `SocketService.dispose()` |

---

## Quality Checklist

Before every commit/PR:

- [ ] `dart format --set-exit-if-changed .` exits with 0
- [ ] `flutter analyze --no-fatal-infos` exits with 0
- [ ] No `print()` statements (use `debugPrint()`)
- [ ] No hardcoded secrets (passwords, API keys)
- [ ] Passwords use `FlutterSecureStorage`
- [ ] No cross-layer imports (check import matrix)
- [ ] `///` doc comments on all public methods
- [ ] `@override` annotations on overridden methods
- [ ] `dispose()` called on services with resources
- [ ] Commit message follows `feat:` / `fix:` / `docs:` convention
