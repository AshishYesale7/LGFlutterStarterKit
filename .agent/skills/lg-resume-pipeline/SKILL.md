---
name: lg-resume-pipeline
description: Resume interrupted pipeline from the last checkpoint
---

# LG Resume Pipeline

Tracks pipeline progress via checkpoints and resumes from the exact interrupted stage.

## Checkpoint System
Pipeline progress is stored in `.pipeline-checkpoint.json`:
```json
{
  "project": "<project-name>",
  "stage": 5,
  "stageName": "KML Integration",
  "timestamp": "2026-02-17T10:30:00Z",
  "completedTasks": ["init", "architecture", "services", "providers", "kml"],
  "pendingTasks": ["testing", "build", "documentation"]
}
```

## Resume Protocol
1. Read `.pipeline-checkpoint.json`
2. Display current status to student
3. Verify completed work still compiles: `flutter analyze`
4. Resume from the next pending stage
5. Update checkpoint after each stage completes

## Activation
- Session reconnect after disconnect
- Student says "continue" or "resume"
- Agent detects checkpoint file exists

## Recovery Scenarios
| Scenario | Action |
|----------|--------|
| Clean checkpoint | Resume from next stage |
| Build broken since last session | Fix first, then resume |
| Dependencies outdated | Run `flutter pub upgrade`, then resume |
| New errors in existing code | Debug with `lg-debugger`, then resume |
