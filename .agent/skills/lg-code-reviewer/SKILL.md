---
name: lg-code-reviewer
description: Review code quality and architecture compliance
---

# LG Code Reviewer

Reviews code for quality, architecture compliance, and LG best practices.

## Review Checklist
1. **Layer Boundaries**: Screens don't import services directly (use providers)
2. **State Management**: Provider pattern used correctly, no setState for shared state
3. **Error Handling**: All async operations have try/catch
4. **KML Validity**: Generated KML is well-formed XML
5. **SSH Safety**: No shell injection, credentials not logged
6. **Code Style**: Follows dart conventions, proper doc comments
7. **Performance**: No unnecessary rebuilds, proper use of const

## Review Report Format
```markdown
## Code Review: <feature>
### Summary
### Issues Found
- [CRITICAL] ...
- [WARNING] ...
- [SUGGESTION] ...
### Architecture Compliance
### Recommendation
```

## Output
Reviews written to `docs/reviews/<date>-<feature>-review.md`
