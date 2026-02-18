---
name: lg-plan-writer
description: Creates detailed implementation plans for LG Flutter features with educational checkpoints before any code is written.
---

# Writing Liquid Galaxy Implementation Plans

Third step: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**.

**⚠️ PROMINENT GUARDRAIL**: If the student fails Educational Verification, call **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md). The **LG Shield** (.agent/skills/lg-shield/SKILL.md) is also always active.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>-plan.md`

---

## ⛔ WITHIN-STAGE INTERACTION RULES (NON-NEGOTIABLE)

> **You MUST build the plan collaboratively with the student — ONE task at a time.**
> DO NOT generate the entire plan document in a single message.
> DO NOT present multiple tasks at once.
> DO NOT ask more than ONE verification question per message.

**The plan is a CONVERSATION, not a document dump.**

---

## Task Granularity
Each step: single logical action, 5-10 minutes. Commit after each.

## The Collaborative Plan-Building Process

### Step 1: Present the Plan Header
Start by presenting ONLY the plan header to the student:

```markdown
# [Feature Name] Implementation Plan
**Goal:** [One sentence]
**Architecture:** Controller-to-Rig over SSH
**Tech Stack:** Dart, Flutter, Provider, [additional packages]
**Educational Objectives:** [Principles to learn]
```

Then ask: *"Does this goal capture what we designed in the brainstorming phase? Is there anything you'd add or change to the educational objectives?"*

⛔ **STOP and WAIT** for the student's response before continuing.

### Step 2: Build the Checklist Together — ONE Task at a Time

For EACH task in the plan:

1. **Present ONE task** with its structure:
```markdown
### Task N: [Name]
**Files:** Create/Modify/Test paths
**Step 1**: Why we're touching these files
**Step 2**: Code pattern / interface
**Step 3**: Verification (`flutter analyze`, `flutter test`, visual check)
**Step 4**: `git commit -m "feat: [description]"`
```

2. **Ask a specific question** about that task:
   - *"Is the scope of this task right? Should we split it further or combine it with something?"*
   - *"Can you predict which layer this task operates in — Presentation, Orchestration, Data, KML, or Transport?"*
   - *"What do you think will be the trickiest part of this task?"*

3. ⛔ **STOP and WAIT** for the student's answer.

4. **Only after discussing** → present the NEXT task.

**NEVER present Task 2 before discussing Task 1. NEVER show the entire checklist up front.**

### Step 3: Review the Complete Plan Together

After all tasks are presented and discussed:
1. Show the full checklist summary (just task titles, not full details).
2. Ask: *"Looking at this plan as a whole — does the order make sense? Would you reorder anything?"*
3. ⛔ **STOP and WAIT.**

## Engineering Principles
- **Controller-to-Rig**: Flutter app controls, Google Earth displays via KML over SSH.
- **Separation of Concerns**: UI in screens/, logic in services/, data in models/.
- **DRY/YAGNI/SOLID**: Modular, minimal, clean.

## Educational Verification Phase (MANDATORY)

⛔ **Ask these questions ONE AT A TIME.** Wait for the answer to each before asking the next.

**Question 1**: *"Why is [Logic] in a service instead of the widget?"*
→ Wait for answer. Evaluate. If wrong, teach and re-ask.

**Question 2**: *"What trade-off did we make choosing Provider?"*
→ Wait for answer. Evaluate. If wrong, teach and re-ask.

**Question 3**: *"Trace the data path: App → SSH → LG Master → Google Earth."*
→ Wait for answer. Evaluate. If wrong, teach and re-ask.

**Question 4**: *"Which principle applies to separating SSH from KML logic?"*
→ Wait for answer. Evaluate. If wrong, teach and re-ask.

**Do not proceed until the student answers each question reasonably. Do not batch questions.**

## Handoff

**Student Checkpoint (MANDATORY):**
Before handing to the executor, ask:
- *"The plan is ready. Before we start coding — why is [core logic] in a service instead of the widget? What trade-off did we make?"*
- **Wait for the student's answer.** If they can't explain, link to [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) and ask them to study Lucia's service layer.

## Anti-Patterns (NEVER DO THESE)
- ❌ Generate the full plan (header + all tasks + checklist) in one message
- ❌ Present multiple tasks before the student has discussed the first one
- ❌ Ask all 4 verification questions in a single message
- ❌ Accept "looks good" as sufficient engagement — ask WHY it looks good
- ❌ Skip the task-by-task discussion to "save time"
- ❌ End any message with just "Ready for the next task?" — always include a thought-provoking question

## Reference Links

- **Lucia's LG Master App**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **Flutter project structure**: https://docs.flutter.dev/resources/architectural-overview
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

"Plan saved to `docs/plans/<file>.md`. Ready for implementation? Using **Plan Executer** (.agent/skills/lg-exec/SKILL.md)."

## 🔗 Skill Chain

After the plan is written and the student passes the checkpoint, **automatically offer the next stage**:

> *"Plan is saved and you clearly understand the service-layer architecture! Now let's start building. We'll begin by wiring the data pipeline and scaffolding the UI. Ready to code? 🚀"*

If student says "ready" → activate `.agent/skills/lg-data-pipeline/SKILL.md` first, then `.agent/skills/lg-ui-scaffolder/SKILL.md`, then `.agent/skills/lg-exec/SKILL.md` for batch execution.
