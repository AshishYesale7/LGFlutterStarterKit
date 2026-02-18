---
name: lg-shield
description: 'Security and boundary enforcement guardrail. Validates that no secrets leak into source control, no layers violate their architectural boundaries, and all data flows respect the API → Domain → KML → Transport pipeline.'
---

# LG Shield — Security & Boundary Enforcement

Runs automatically at the **start** and **end** of every workflow, plus on-demand
when any skill produces or modifies code.

**Announce:** "Shield scan initiated. Checking security posture and layer boundaries."

**⚠️ PROMINENT GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active at all times. Security issues are NON-NEGOTIABLE — the pipeline BLOCKS until all BLOCK-level findings are resolved.

## Automated Checks

### 1. Secret Detection
Scan all Dart, YAML, JSON, and environment files for:

| Pattern | Action |
|---------|--------|
| Hardcoded API keys (`AIza...`, `sk-...`, Bearer tokens) | **BLOCK** — move to `.env` + `flutter_secure_storage` |
| Passwords in `SharedPreferences` | **BLOCK** — must use `flutter_secure_storage` |
| Plain-text credentials in `config.dart` | **WARN** — mark as dev-only defaults, document in tech-debt |
| `.env` or keystore files not in `.gitignore` | **BLOCK** — add to `.gitignore` immediately |

### 2. Repository Hygiene
- `.gitignore` must exclude: `*.env`, `*.jks`, `*.keystore`, `*.p12`, `build/`, `.dart_tool/`, `node_modules/`
- No binary blobs > 1 MB in tracked files.
- No generated code committed without a `// GENERATED — DO NOT EDIT` header.

### 3. Layer Boundary Validation
Verify that imports respect the layered architecture:

```
Forbidden import chains:
  screens/*.dart  →  package:dartssh2    (SSH in UI)
  screens/*.dart  →  dart:io HttpClient  (network in UI)
  kml_service.dart →  package:dartssh2   (SSH in KML layer)
  kml_service.dart →  package:http       (network in KML layer)
  ssh_service.dart →  kml_service.dart   (KML in transport layer)
  *_service.dart   →  screens/*.dart     (UI in service layer)
```

### 4. Data Flow Integrity
The canonical pipeline must be preserved:

```
External API (http)
  → Provider / API Service (lib/services/*_service.dart)
  → Domain Models (lib/models/*.dart)
  → KML Generator (lib/services/kml_service.dart)
  → KML Payload (String)
  → SSH Transport (lib/services/ssh_service.dart)
  → LG Rig
```

No layer may skip a step.  
UI code **never** calls `http.get()` directly.  
UI code **never** generates KML strings.  
KML generators **never** open SSH connections.

### 5. Dependency Audit
Scan `pubspec.yaml` for:
- Packages with known vulnerabilities (log warning).
- Unnecessary platform permissions (camera, location when unused).
- Missing `flutter_secure_storage` when the app handles credentials.

## Enforcement Levels

| Level | Action |
|-------|--------|
| **BLOCK** | Execution halted. Must be resolved before continuing. |
| **WARN** | Logged to `docs/tech-debt.md`. May proceed with acknowledgement. |
| **INFO** | Noted in review report. No action required. |

## Integration Points
- Called by `generate-flutter-app` workflow at Stage 0 (pre-flight) and Stage 10 (post-build).
- Called by `lg-critical-advisor` during Step 3 (Security Audit).
- Called by `lg-code-reviewer` during the security section of the review.

## Output
Produces a `shield-report.md` in `docs/reviews/`:

```markdown
# Shield Report — [Date]
## Secret Scan: PASS / FAIL
## Boundary Scan: PASS / FAIL
## Data Flow Scan: PASS / FAIL
## Dependency Audit: PASS / WARN
## Blockers: [list]
## Warnings: [list]
```

## 🔗 Skill Chain

### Pre-Flight (Stage 0) → Init
After a clean pre-flight scan, **automatically offer the next stage**:
> *"Security pre-flight is clean — no secrets, no boundary violations! Let's initialize your LG project. Ready to set up your app?"*

If student says "ready" → activate `.agent/skills/lg-init/SKILL.md`.

### Post-Flight (Stage 9) → Quiz
After a clean post-flight scan:
> *"Security post-flight passed! Your code is clean and secure. Ready for the **Liquid Galaxy Quiz Show** finale? 🎬"*

If student says "ready" → activate `.agent/skills/lg-quiz-master/SKILL.md`.
