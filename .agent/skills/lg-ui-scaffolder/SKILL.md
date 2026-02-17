---
name: lg-ui-scaffolder
description: Scaffold Flutter UI screens following Material 3 patterns
---

# LG UI Scaffolder

Creates Flutter screens following Material 3 and LG app conventions.

## Screen Template
Every screen follows this structure:
1. AppBar with title and navigation actions
2. Body with SingleChildScrollView or ListView
3. Cards for grouped content
4. Action buttons for LG operations
5. Status indicators for connection state

## Material 3 Conventions
- Use `ColorScheme` from theme, never hardcode colors
- Use `FilledButton`, `OutlinedButton`, `TextButton` hierarchy
- Use `const` constructors wherever possible
- Use `Card` with `Padding` for content groups

## Screen Checklist
- [ ] Stateful or Stateless decision documented
- [ ] Provider access via `context.watch` or `context.read`
- [ ] Loading states handled
- [ ] Error states with user feedback
- [ ] Responsive layout considerations
