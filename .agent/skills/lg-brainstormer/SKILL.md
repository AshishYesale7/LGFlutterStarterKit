---
name: lg-brainstormer
description: 'You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements, and design before implementation.'
---

# Brainstorming Ideas Into Designs

## Overview

Help turn ideas into fully formed designs and specs through natural collaborative dialogue. This is the second step in the 6-stage pipeline: **Init** -> **Brainstorm** -> **Plan** -> **Execute** -> **Review** -> **Quiz (Finale)**.

**GUARDRAIL**: If the student is agreeing too easily without asking "How" or "Why", you **MUST** trigger the **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md).

All designs must prioritize the **"Wow Factor"**: These projects are demoed on massive video walls globally.

## LG App Model (Non-Negotiable)
A Liquid Galaxy app is a **smartphone/tablet controller** that commands a multi-screen Google Earth rig.
- The **Flutter app runs on a phone** — it is the remote control.
- The **LG rig** (3, 5, or 7 Linux machines) runs Google Earth — it is the display.
- Communication: Flutter App → SSH → LG Master → Google Earth renders KML on all screens.
- **DO NOT** design the Flutter app to render across multiple screens. Google Earth handles that.
- **DO NOT** propose game/physics-based architectures. LG apps visualize geographic data, NOT games.

### What LG Apps ARE (Reference Real Projects)
Browse these for inspiration — they are all real GSoC Liquid Galaxy projects:
- [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) — Lucia's reference controller (Flutter+Node.js)
- [LG AI Travel Generator](https://github.com/LiquidGalaxyLAB/LG-AI-fictional-travel-itinerary-generator) — AI + KML tours
- [LG Gesture & Voice Control](https://github.com/LiquidGalaxyLAB/LG-Gesture-And-Voice-Control) — Advanced input methods
- [All LG Projects](https://github.com/LiquidGalaxyLAB) — 100+ GSoC projects
- [LG Mobile Applications](https://www.liquidgalaxy.eu/2018/06/mobile-applications.html) — Official app showcase
- [GSoC 2026 Ideas](https://www.liquidgalaxy.eu/2025/11/GSoC2026.html) — Current year project ideas

### What LG Apps ARE NOT
- ❌ Games (no physics engines, no sprites, no collision detection)
- ❌ Social media apps
- ❌ Chat applications
- ❌ Apps that run entirely on the phone without controlling the rig
- ❌ Web apps that don't interact with Google Earth

## Educational Purpose

- **Architectural Clarity**: Explain the **Controller-to-Rig** model. App "controls", Google Earth "displays."
- **Engineering Principles**: Separation of Concerns, DRY, SOLID.
- **Critical Thinking**: Ask the student to evaluate trade-offs.
- **Flutter-Specific**: Provider vs Riverpod, service layer patterns, SSH lifecycle management.

## The Process

**Understanding the idea:**
- Check current project state (files, docs, commits).
- Ask questions one at a time.
- Prefer multiple choice when possible.
- Focus on: purpose, data source, visual impact on Google Earth, success criteria.
- **LG Context**: Which data to visualize? (Earthquakes, satellites, volcanoes, education, historic sites, etc.)

**Exploring approaches:**
- Propose 2-3 approaches with trade-offs.
- Lead with recommended option.
- **LG Trade-offs**: API polling vs static data, KML placemarks vs tours, dartssh2 lifecycle, on-demand vs cached visualization.

**Presenting the design:**
- Break into 200-300 word sections.
- Highlight design patterns in each section.
- Ask validation after each section.
- Cover: architecture, data pipeline, KML strategy, visual impact on LG, testing (`flutter test`).

## After the Design

**Documentation:**
- Write to `docs/plans/YYYY-MM-DD-<topic>-design.md`.
- Update `docs/architecture-map.md`.
- Include "Learning Objectives" section.
- Commit to git.

**Student Checkpoint (MANDATORY):**
Before moving to implementation, ask the student:
- *"In your own words, describe the data flow: where does the data come from, how does it become KML, and how does it reach Google Earth?"*
- *"What's the most visually impressive part of this design on the LG rig?"*
- **Wait for answers. DO NOT auto-continue.**

**Implementation:**
- Ask: "Ready to set up for implementation?"
- Use **Plan Writer** (.agent/skills/lg-plan-writer/SKILL.md) to create task list.

## Key Principles
- **Visual Impact** — must be impressive on massive Google Earth displays
- **One question at a time** — don't overwhelm
- **Multiple choice preferred** — easier to answer
- **YAGNI ruthlessly** — remove unnecessary features
- **Explore alternatives** — propose 2-3 approaches before settling
- **Incremental validation** — present design in sections
