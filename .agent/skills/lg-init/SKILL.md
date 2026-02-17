---
name: lg-init
description: Initialize a new LG Flutter project from scratch
---

# LG Init

Initializes a new Liquid Galaxy Flutter project with the standard architecture.

## CRITICAL: Separate Directory Rule

New apps MUST be created in a **separate sibling directory**, NOT inside `LGFlutterStarterKit`.

```
parent/
├── LGFlutterStarterKit/   ← READ-ONLY template (this repo)
└── <new-app-name>/         ← Student's app (NEW directory + NEW repo)
```

## Phase 0: Create Separate Project Directory (NEW — MANDATORY)

Before ANY code generation:

1. **Determine project location**: Ask student for project name → create `../<project-name>/` (sibling to starter kit)
2. **Create directory**: `mkdir -p ../<project-name>`
3. **Copy starter kit scaffolding**: Copy `flutter_client/`, `.github/`, `.gitignore`, `server/` into new directory
4. **Initialize Git**: `cd ../<project-name> && git init`
5. **Create GitHub repo**: Hand off to `lg-github-agent` for `gh repo create`

## Phase 1: Gather Requirements
- Ask student for: project name, description, target platforms, number of screens
- Determine which optional modules to include (Node.js, earthquake viz, etc.)

## Phase 2: Scaffold Architecture
- Create layered directory structure:
  - `lib/screens/` — UI pages
  - `lib/services/` — Business logic (SSH, LG, KML)
  - `lib/providers/` — State management
  - `lib/models/` — Data classes
  - `lib/widgets/` — Reusable widgets

## Phase 3: Configure Dependencies
- Set up `pubspec.yaml` with required packages
- Run `flutter pub get`
- Verify with `flutter analyze`

## Phase 4: Verify Toolchain
- Check Flutter SDK, Dart SDK, Android SDK
- Verify emulator availability
- Run `flutter doctor`
