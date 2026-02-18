---
name: lg-plan-writer
description: Creates detailed implementation plans for LG Flutter features with educational checkpoints before any code is written.
---

# Writing Liquid Galaxy Implementation Plans

Third step: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**.

**⚠️ PROMINENT GUARDRAIL**: If the student fails Educational Verification, call **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md). The **LG Shield** (.agent/skills/lg-shield/SKILL.md) is also always active.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>-plan.md`

## Task Granularity
Each step: single logical action, 5-10 minutes. Commit after each.

## Plan Header

```markdown
# [Feature Name] Implementation Plan
**Goal:** [One sentence]
**Architecture:** Controller-to-Rig over SSH
**Tech Stack:** Dart, Flutter, Provider, [additional packages]
**Educational Objectives:** [Principles to learn]

## Implementation Checklist
- [ ] Task 1: [Short Title]
- [ ] Task 2: [Short Title]
```

## Task Structure

```markdown
### Task N: [Name]
**Files:** Create/Modify/Test paths
**Step 1**: Why we're touching these files
**Step 2**: Code pattern / interface
**Step 3**: Verification (`flutter analyze`, `flutter test`, visual check)
**Step 4**: `git commit -m "feat: [description]"`
```

## Engineering Principles
- **Controller-to-Rig**: Flutter app controls, Google Earth displays via KML over SSH.
- **Separation of Concerns**: UI in screens/, logic in services/, data in models/.
- **DRY/YAGNI/SOLID**: Modular, minimal, clean.

## Educational Verification Phase (MANDATORY)
Before implementation, ask:
1. "Why is [Logic] in a service instead of the widget?"
2. "What trade-off did we make choosing Provider?"
3. "Trace the data path: App → SSH → LG Master → Google Earth."
4. "Which principle applies to separating SSH from KML logic?"

Do not proceed until student answers reasonably.

## Handoff

**Student Checkpoint (MANDATORY):**
Before handing to the executor, ask:
- *"The plan is ready. Before we start coding — why is [core logic] in a service instead of the widget? What trade-off did we make?"*
- **Wait for the student's answer.** If they can't explain, link to [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) and ask them to study Lucia's service layer.

## Reference Links

- **Lucia's LG Master App**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **Flutter project structure**: https://docs.flutter.dev/resources/architectural-overview
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

"Plan saved to `docs/plans/<file>.md`. Ready for implementation? Using **Plan Executer** (.agent/skills/lg-exec/SKILL.md)."

## 🔗 Skill Chain

After the plan is written and the student passes the checkpoint, **automatically offer the next stage**:

> *"Plan is saved and you clearly understand the service-layer architecture! Now let's start building. We'll begin by wiring the data pipeline and scaffolding the UI. Ready to code? 🚀"*

If student says "ready" → activate `.agent/skills/lg-data-pipeline/SKILL.md` first, then `.agent/skills/lg-ui-scaffolder/SKILL.md`, then `.agent/skills/lg-exec/SKILL.md` for batch execution.
