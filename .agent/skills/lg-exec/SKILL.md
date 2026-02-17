---
name: lg-exec
description: Use when you have a written implementation plan (from lg-plan-writer) to execute with review checkpoints and educational validation. MUST pause after each batch for student interaction.
---

# Executing Liquid Galaxy Plans

## Overview
Fourth step in the pipeline: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**.

**GUARDRAIL**: If the student stops participating or just says "Go on," trigger the **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md).

**Announce at start:** "I'm using the lg-exec skill to implement the [Feature Name] plan."

---

## ⛔️ MANDATORY: NO AUTO-CONTINUE RULE

> **YOU MUST STOP AND WAIT for the student's response after EVERY batch.**
> DO NOT execute the next batch automatically.
> DO NOT interpret silence as consent to continue.
> DO NOT chain batches together without an explicit student response.

**If the student says any of these, TRIGGER the Critical Advisor:**
- "Go on"
- "Continue"
- "Do it all"
- "Skip"
- "Just build it"
- "Keep going"
- Any response that shows NO engagement with what was just built.

**Instead, the student MUST demonstrate:**
- They understood what was built ("I see, so the SSH service sends the KML to...")
- They can answer the verification question you pose
- They have an opinion or question about the next batch

**This is NON-NEGOTIABLE. The agent exists to TEACH, not just to generate code.**

---

## The Process

### Step 1: Load and Review Plan
1. Read the plan file in `docs/plans/`.
2. Identify architectural questions.
3. Ensure names/structures follow Dart/Flutter conventions.
4. Raise concerns before starting.

### Step 2: Execute Batch (2-3 tasks MAX)

For each task:
1. Mark as `in_progress`.
2. Follow: Logic -> Implementation -> Verification.
3. Explain why this task matters architecturally.
4. Verify:
   - `flutter analyze` — zero errors
   - `dart format .` — consistent style
   - `flutter test` — all passing
   - Hot reload if app is running
5. Check Flutter-specific concerns: Provider usage, async error handling, SSH resource disposal.
6. Commit: `feat: [task name]`

### Step 3: Educational Report + Mandatory Pause

Per batch, present the report:
- **What was built**: Summary of the 2-3 tasks completed.
- **Verification**: Output of `flutter analyze` and `flutter test`.
- **Engineering Principles**: Which principle was applied (e.g., SRP, DRY).
- **Visual Check**: Wow Factor assessment — how will this look on Google Earth?
- **Checklist**: Update `docs/plans/` status.
- **Learning Journal**: Append to `docs/learning-journal.md`.

### Step 4: ⛔️ STOP — Student Interaction Checkpoint

**After presenting the report, you MUST:**

1. **Ask a verification question** specific to what was just built:
   - *"Walk me through what happens when the user taps the FlyTo button — which layers are involved?"*
   - *"Why did we put the KML generation in kml_service.dart instead of in the screen?"*
   - *"What would break if we skipped the clearKML() call before sending new data?"*

2. **Wait for the student's answer.** DO NOT PROCEED until they respond.

3. **Evaluate the answer:**
   - ✅ **Correct**: Acknowledge, then ask: *"Ready for the next batch? Here's what's coming: [preview of next 2-3 tasks]."*
   - ⚠️ **Partially correct**: Guide them toward the full answer. Link to resources via `.agent/skills/lg-learning-resources/SKILL.md`.
   - ❌ **Wrong or "I don't know"**: Explain the concept. Link to Lucia's implementation: *"See how this is done in [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App)."* Then re-ask.
   - 🚫 **"Just continue" / no engagement**: Trigger Critical Advisor immediately.

4. **Only after a satisfactory response**, proceed to Step 2 for the next batch.

### Step 5: Between Batches — Emulator Check

If an emulator is running (`flutter devices` shows a device):
- Run the app: `flutter run -d <device-id>`
- Ask the student to verify the new feature visually
- Capture a screenshot: `adb exec-out screencap -p > docs/screenshots/batch_N.png`
- *"Does the screen look right? What would you change about the layout?"*

### Step 6: Final Review
1. Full validation: `flutter analyze && flutter test && dart format --set-exit-if-changed .`
2. Mark plan as complete.
3. Show the student a summary: *"We've completed all [N] tasks from the plan. Here's what the app can do now: [summary]."*
4. **Final comprehension check**: Ask one big-picture question — *"Trace the full data flow from the user tapping 'Visualize' to the KML appearing on the LG rig."*
5. Hand to **Code Reviewer** (.agent/skills/lg-code-reviewer/SKILL.md).

## When to Stop
- Blocker encountered
- Plan has logic gaps
- Verification fails repeatedly
- Student can't answer 2+ verification questions → hand to **Learning Resources** (.agent/skills/lg-learning-resources/SKILL.md)
- **Don't guess — ask for clarification**

## Anti-Patterns (NEVER DO THESE)
- ❌ Execute all tasks in one go without pausing
- ❌ Ask "Ready for the next batch?" and then immediately start it
- ❌ Skip verification questions to save time
- ❌ Accept "yes" / "ok" / "continue" as proof of understanding
- ❌ Generate more than 3 tasks before stopping for interaction
- ❌ Run the full pipeline without the student seeing intermediate results
