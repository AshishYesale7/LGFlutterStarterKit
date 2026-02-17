````skill
---
name: lg-resume-pipeline
description: Tracks pipeline progress and resumes from the exact stage where work was interrupted — whether due to missing tools, errors, session disconnect, or manual pause. Prevents re-running completed stages.
---

# Resume Pipeline

## Overview

This skill maintains a **pipeline checkpoint file** that records which stages have been completed, which was in-progress when interrupted, and what caused the interruption. When invoked, it reads the checkpoint, validates the current environment, and resumes from exactly where things left off.

**Announce at start:** "Checking pipeline progress... Let me find where we left off."

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active. Students should not skip stages — even if they think they know the material.

## Checkpoint File

Location: `docs/pipeline-checkpoint.yaml`

```yaml
# Auto-maintained by lg-resume-pipeline. Do not edit manually.
pipeline: full-pipeline            # or generate-flutter-app
started_at: "2026-02-17T10:30:00Z"
last_updated: "2026-02-17T11:45:00Z"
host_os: "macOS 15.2 (arm64)"

stages:
  - name: "Shield (pre-flight)"
    status: completed              # completed | in-progress | blocked | not-started
    completed_at: "2026-02-17T10:31:00Z"
    notes: "No secrets found. .gitignore verified."

  - name: "Init"
    status: completed
    completed_at: "2026-02-17T10:40:00Z"
    notes: "Project: LG-Task2-Demo, 3 screens, Android"

  - name: "Brainstorm"
    status: completed
    completed_at: "2026-02-17T10:55:00Z"
    notes: "Selected approach: Single-screen controller with action buttons"

  - name: "Viz Design"
    status: in-progress
    started_at: "2026-02-17T11:00:00Z"
    notes: ""

  - name: "Plan"
    status: not-started

  - name: "Data Pipeline"
    status: not-started

  - name: "UI + KML"
    status: not-started

  - name: "Execute"
    status: not-started

  - name: "Review"
    status: not-started

  - name: "Shield (post-flight)"
    status: not-started

  - name: "Quiz"
    status: not-started

interruption:
  reason: "missing-tool"           # missing-tool | error | session-disconnect | manual-pause
  details: "Flutter SDK not found on PATH"
  blocked_at_stage: "Init"
  resolution_skill: "lg-setup-guide"
  resolved: true
  resolved_at: "2026-02-17T11:30:00Z"
```

## Resume Logic

### Step 1: Read Checkpoint
```
1. Look for docs/pipeline-checkpoint.yaml
2. If not found → No pipeline in progress. Start fresh with lg-env-doctor.
3. If found → Parse and display progress summary.
```

### Step 2: Display Progress Summary
```
╔══════════════════════════╦════════════╗
║ Stage                    ║ Status     ║
╠══════════════════════════╬════════════╣
║ 0. Shield (pre-flight)   ║ ✅ Done    ║
║ 1. Init                  ║ ✅ Done    ║
║ 2. Brainstorm            ║ ✅ Done    ║
║ 3. Viz Design            ║ 🔄 Resume  ║  ← pick up here
║ 4. Plan                  ║ ⬜ Pending ║
║ 5. Data Pipeline         ║ ⬜ Pending ║
║ 6. UI + KML              ║ ⬜ Pending ║
║ 7. Execute               ║ ⬜ Pending ║
║ 8. Review                ║ ⬜ Pending ║
║ 9. Shield (post-flight)  ║ ⬜ Pending ║
║ 10. Quiz                 ║ ⬜ Pending ║
╚══════════════════════════╩════════════╝

Pipeline: full-pipeline
Started: 2026-02-17 10:30
Last active: 2026-02-17 11:45
Resuming from: Stage 3 (Viz Design)
```

### Step 3: Pre-Resume Validation
Before resuming, run a quick health check:

1. **Environment check** (lightweight — not full doctor):
   ```bash
   flutter --version >/dev/null 2>&1 && echo "Flutter: OK" || echo "Flutter: MISSING"
   git --version >/dev/null 2>&1 && echo "Git: OK" || echo "Git: MISSING"
   ```
2. **If any required tool is now missing** → Hand off to `lg-setup-guide` again.
3. **Verify working directory** — are we in the right project?
   ```bash
   test -f flutter_client/pubspec.yaml && echo "Project: OK" || echo "Wrong directory"
   ```
4. **Check for dirty state** — any uncommitted changes from the interrupted stage?
   ```bash
   git status --short
   ```
   If dirty → ask student: "You have uncommitted changes from the last session. Commit them before resuming?" (Yes → commit. No → stash.)

### Step 4: Resume
1. Load the skill for the `in-progress` stage.
2. Pass any context from the `notes` field.
3. Continue execution from where it stopped.
4. Update checkpoint on completion of each stage.

## Interruption Handling

When any skill encounters a blocking issue, it should update the checkpoint:

### Interruption Types

| Type | Trigger | Recovery |
|------|---------|----------|
| `missing-tool` | `lg-env-doctor` finds MISSING required tool | `lg-setup-guide` → install → resume |
| `error` | `flutter analyze` fails, build errors, test failures | `lg-dependency-resolver` or `lg-debugger` → fix → resume |
| `session-disconnect` | User closes VS Code or terminal | Next session: auto-detect checkpoint → resume |
| `manual-pause` | User says "stop" or "pause" | Save state → resume when user says "continue" |

### Recording an Interruption
Any skill can record an interruption by updating the checkpoint:
```yaml
interruption:
  reason: "error"
  details: "flutter analyze found 3 errors in lg_service.dart"
  blocked_at_stage: "Execute"
  resolution_skill: "lg-debugger"
  resolved: false
```

### After Resolution
```yaml
interruption:
  reason: "error"
  details: "flutter analyze found 3 errors in lg_service.dart"
  blocked_at_stage: "Execute"
  resolution_skill: "lg-debugger"
  resolved: true
  resolved_at: "2026-02-17T12:00:00Z"
```

## Quick Commands

| What | Prompt |
|------|--------|
| Check progress | *"Where did we leave off?"* or *"Show pipeline status"* |
| Resume work | *"Continue the pipeline"* or *"Resume from where we stopped"* |
| Pause | *"Pause the pipeline"* or *"Save progress and stop"* |
| Restart a stage | *"Redo stage 3"* (resets that stage to `not-started`) |
| Start fresh | *"Reset pipeline"* (deletes checkpoint, starts from scratch) |

## Handoff

- **Resuming** → Invokes the skill for the `in-progress` or first `not-started` stage.
- **Environment broken** → `.agent/skills/lg-env-doctor/SKILL.md` → `.agent/skills/lg-setup-guide/SKILL.md`.
- **Build/dependency error** → `.agent/skills/lg-dependency-resolver/SKILL.md`.
- **Other errors** → `.agent/skills/lg-debugger/SKILL.md`.

````
