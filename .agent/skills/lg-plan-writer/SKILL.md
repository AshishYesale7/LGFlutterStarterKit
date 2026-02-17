---
name: lg-plan-writer
description: Write detailed implementation plans for LG features
---

# LG Plan Writer

Creates structured implementation plans for Liquid Galaxy features.

## Plan Structure
1. **Goal**: What the feature achieves
2. **Architecture Impact**: Which layers are affected
3. **Tasks**: Ordered list of implementation steps (max 10)
4. **Dependencies**: Required packages or services
5. **Testing Strategy**: How to verify correctness
6. **KML Integration**: How it connects to Google Earth

## Output Format
Plans are written to `docs/plans/<date>-<feature>-design.md`

## Rules
- Each task must be atomic (completable in one commit)
- Tasks must respect layer boundaries (screen → provider → service)
- Each task needs a test strategy
- Plans reference specific files and line numbers
