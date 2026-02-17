---
name: lg-code-reviewer
description: The final gatekeeper for quality. Use after a feature implementation is finished to ensure OSS standards, performance, and architectural purity.
---

# The OSS Code Reviewer

## Overview
Fifth step in the pipeline: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**. Simulates a professional code review.

**Announce at start:** "I'm starting a professional Code Review for the [Feature Name] implementation."

## The Review Process

### 1. Holistic Quality Check
- **SOLID Purity**: Are classes doing too much?
- **DRY Compliance**: Any copy-pasted logic that should be shared?
- **Naming**: Descriptive and consistent with Dart conventions?
- **Widget Tree**: Appropriately decomposed? No "God Widgets."
- **Provider Usage**: Services properly registered and consumed?

### 2. Technical Tooling Audit (Mandatory)
Run and verify:
- **Analysis**: `flutter analyze` — zero errors/warnings.
- **Formatting**: `dart format --set-exit-if-changed .`
- **Tests**: `flutter test` — all passing.
- **Coverage**: `flutter test --coverage` — target 80%.

### 3. Liquid Galaxy Specific Audit
- **SSH Lifecycle**: Connections properly opened, verified, and disposed?
- **KML Validity**: Valid XML, correct coordinate ordering (lon, lat, alt)?
- **KML Cleanup**: Old overlays cleared before sending new data?
- **Service Layer**: UI delegates to services, no direct SSH/KML in widgets?
- **Memory Safety**: Dispose methods clean up SSH connections and resources?

### 4. Layer Boundary & Security Audit
- **Import compliance**: No `dartssh2` or `package:http` in `screens/` or `widgets/`.
- **No KML in UI**: Screens must not contain KML string literals or XML generation.
- **No network in UI**: Screens must not call `http.get()` or open sockets.
- **Provider contracts**: API implementations expose only domain models downstream.
- **Secret storage**: No passwords/API keys in `SharedPreferences` — must use `flutter_secure_storage`.
- **Repository hygiene**: `.gitignore` excludes `.env`, keystores, build artifacts.
- See `.agent/rules/layer-boundaries.md` for the full import matrix.

### 5. Documentation & OSS Readiness
- **Dart Doc**: `///` doc comments on all public members.
- **README**: Explains new features.
- **Readability**: New student could understand in 5 minutes.

## Review Report
Save to `docs/reviews/YYYY-MM-DD-<feature>-review.md`.

```markdown
# Code Review: [Feature Name]

## The Good
- [Strengths]

## Tooling & Quality Status
- **Analysis**: [PASS/FAIL]
- **Formatting**: [PASS/FAIL]
- **Tests**: [PASS/FAIL]
- **Coverage**: [X]% (Target: 80%)

## Required Refactors
- [Must fix before merging]

## Best Practice Suggestions
- [Minor improvements]

## Final Verdict: [APPROVED / REVISIONS NEEDED]
```

## Guardrail: Revision Loop
If REVISIONS NEEDED, hand back to Plan Writer or Executer. Feature is not "Complete" until APPROVED.

## Final Completion
Once APPROVED:
- Commit: `chore: final polish after code review`
- Hand to **Quiz Master** (.agent/skills/lg-quiz-master/SKILL.md)
