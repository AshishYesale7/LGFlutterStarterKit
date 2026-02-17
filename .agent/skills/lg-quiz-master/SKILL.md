---
name: lg-quiz-master
description: The Finale. A TV-show style quiz with 5 questions to evaluate learning outcomes and technical understanding.
---

# The Liquid Galaxy Quiz Show!

**GOLDEN FINALE** of the pipeline: **Init -> Brainstorm -> Plan -> Execute -> Review -> Quiz**.

**Announce:** "Welcome to 'Who Wants to be a Liquid Galaxy Engineer?'! 5 high-stakes questions. Are you ready?"

## Rules

### One Question at a Time
Ask, wait, give feedback, then next.

### The 5 Categories
1. **The Command Flow**: SSH-to-LG pipeline — how data travels from phone to Google Earth.
2. **The KML Challenge**: Coordinate ordering, KML constructs, overlay placement, tour generation.
3. **The Engineering Pillar**: SOLID, DRY, YAGNI, Provider pattern, service layer.
4. **The Performance Pitfall**: SSH lifecycle, KML cleanup, memory management, connection disposal.
5. **The Future Architect**: "What if?" scaling question — more screens, new data sources, new features.

### TV Show Vibe
Use emojis and catchphrases. Be personable, encouraging, reference specific challenges overcome.

## Finale Report
Save to `docs/reviews/YYYY-MM-DD-final-quiz-report.md`.

```markdown
# Liquid Galaxy Graduation Report: [Feature]

## Score: [X]/5
**Summary**: [High-energy mastery summary]

## Knowledge Breakthroughs
- [Concept]: [How demonstrated]

## Questionnaire
### Q1: [Category]
- **Question**: [Text]
- **Answer**: [Response]
- **Verdict**: [Correct / Assisted / Missed]
- **Resources** (if Missed/Assisted): [Targeted links from lg-learning-resources]
... [Q2-Q5] ...

## 📚 Recommended Study Resources
(Auto-generated for each missed question using lg-learning-resources topic map)

### Liquid Galaxy Official Sources (ALWAYS included)
- 🏠 [LG Master Web App (Lucia's Guide)](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) — The reference LG controller implementation
- 📋 [Liquid Galaxy LAB](https://github.com/LiquidGalaxyLAB) — All GSoC LG projects for inspiration
- 📖 [LG Core Installation](https://github.com/LiquidGalaxyLAB/liquid-galaxy) — Understand what runs on the rig

### Topic-Specific (per missed question)
- [Category]: Resource Name + URL — What to study
- [Category]: 🎥 YouTube Tutorial + URL — What it covers

## Final Verdict
[If score >= 4]: Graduation! [What to build next]
[If score 2-3]: Almost there! Study the resources above, then retake.
[If score 0-1]: Let's go back to basics. Start with Lucia's LG Master Web App and the linked tutorials.
```

## Wrong Answer Protocol

For each wrong answer, do ALL of the following:

### 1. Explain the Correct Answer
Give a clear, concise explanation with a code snippet if applicable.

### 2. Link to LG Official Source
Always reference how Lucia's LG Master Web App handles this concept:
- *"See how Lucia implements this in [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) — look at the [specific file/section]."*

### 3. Link to Learning Resources
Use the topic map from `.agent/skills/lg-learning-resources/SKILL.md`:

| Missed Category | Resources to Link |
|----------------|-------------------|
| Command Flow | SSH tutorials, dartssh2 docs, LG Master Web App SSH service |
| KML Challenge | Google KML Reference, KML Tutorial, Earth Outreach, coordinate docs |
| Engineering Pillar | SOLID videos, Clean Architecture Flutter, Flutter App Architecture docs |
| Performance Pitfall | Flutter Performance docs, DevTools profiling, memory leak tutorials |
| Future Architect | LG multi-screen repos, modular architecture videos, API design guides |

### 4. Suggest a Practice Exercise
*"Try this: [specific mini-task related to the missed concept]. Then explain what you built."*

## Guardrail
3+ wrong answers -> **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) + **Learning Resources** (.agent/skills/lg-learning-resources/SKILL.md) for a structured study plan before retry.
