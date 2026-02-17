---
name: lg-exec
description: Execute planned tasks in batches with verification
---

# LG Exec

Executes implementation tasks in controlled batches of 2-3 items.

## Execution Protocol
1. Pick 2-3 tasks from the plan
2. Implement each task
3. After each batch:
   - Run `flutter analyze`
   - Run `flutter test`
   - Launch emulator via `lg-emulator-manager` to visually validate
   - Write learning journal entry
   - Commit after each task
   - Push to GitHub remote after each batch

## Error Handling
- If `flutter analyze` fails → fix immediately before next batch
- If tests fail → debug with `lg-debugger`
- If stuck → consult `lg-critical-advisor`

## Commit Convention
```
<type>(<scope>): <description>

Types: feat, fix, refactor, docs, test, chore
Scope: ssh, kml, ui, service, provider, config
```
