---
name: lg-exec
description: Use when you have a written implementation plan (from lg-plan-writer) to execute with review checkpoints and educational validation. MUST pause after each batch for student interaction.
---

# Executing Liquid Galaxy Plans

## Overview
Fourth step in the pipeline: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz (Finale)**.

**⚠️ PROMINENT GUARDRAIL**: If the student stops participating or just says "Go on," trigger the **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md). The **LG Shield** (.agent/skills/lg-shield/SKILL.md) is also always active.

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
4. **Present the plan overview to the student** — summarize total tasks, batching strategy, and estimated time.
5. Ask: *"Here's the plan: [N] tasks split into batches of 2-3. Before we start — looking at Task 1, what layer of the architecture do you think it lives in?"*
6. ⛔ **STOP and WAIT** for the student's response before starting any code.

### Step 2: Execute Batch (2-3 tasks MAX)

For each task WITHIN a batch:
1. Mark as `in_progress`.
2. **Before writing code**, briefly explain what you're about to create and WHY:
   - *"Task 2 creates `kml_service.dart`. This service generates KML XML strings — it has NO network access. Here's why we keep it separate from SSH..."*
3. Follow: Logic -> Implementation -> Verification.
4. **After each task**, provide a 2-3 sentence summary of what changed:
   - *"I created `kml_service.dart` with `generatePlacemark()` and `generateScreenOverlay()`. Both return raw KML strings. Notice how this service has zero imports from `ssh_service` — that's our layer boundary in action."*
5. Verify:
   - `flutter analyze` — zero errors
   - `dart format .` — consistent style
   - `flutter test` — all passing
   - Hot reload if app is running
6. Check Flutter-specific concerns: Provider usage, async error handling, SSH resource disposal.
7. Commit: `feat: [task name]`

⛔ **Within a 3-task batch, you still EXPLAIN each task as you go.** The student should never see 3 files appear silently. Narrate the work as a teacher would.

### Step 3: Educational Report — Presented Incrementally

⛔ **DO NOT dump the entire report in one message.** Present it in stages:

**First message — What Was Built:**
- Summarize the 2-3 tasks completed in this batch.
- Show `flutter analyze` and `flutter test` output.
- Ask: *"Before I explain the engineering principles — can you tell me which principle we applied in this batch?"*
- ⛔ **STOP and WAIT** for the student's guess.

**Second message — Engineering Principles + Visual Check:**
- Acknowledge their answer, correct if needed.
- Explain the principle that was applied (e.g., SRP, DRY).
- Wow Factor assessment — how will this look on Google Earth?
- Ask: *"How do you think this will look on the rig? What's your mental picture?"*
- ⛔ **STOP and WAIT.**

**Third message — Checklist + Journal:**
- Update `docs/plans/` status.
- Append to `docs/learning-journal.md`.
- Transition to the verification question (Step 4).

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

## 🔗 Skill Chain

After all plan tasks are executed and the student passes the final comprehension check, **automatically offer the next stage**:

> *"All tasks implemented and verified! You traced the full data flow from tap to rig. Now let's do a professional code review to make sure everything is OSS-ready. Ready for the Code Review? 🔍"*

If student says "ready" → activate `.agent/skills/lg-code-reviewer/SKILL.md`.

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
