# Technical Debt Tracker

Known issues, shortcuts, and planned improvements.

## Format
| ID | Priority | Area | Description | Status |
|---|---|---|---|---|
| TD-001 | High | SSH | `ssh_service.dart` needs reconnection and keep-alive strategy | Open |
| TD-002 | Medium | KML | No KML validation step before sending to rig | Open |
| TD-003 | Medium | Config | `config.dart` hardcodes LG defaults — should read from `--dart-define` or shared_preferences | Open |
| TD-004 | Low | Server | `server/index.js` data proxy should add response caching | Open |
| TD-005 | Medium | Test | Zero test files exist — need unit + widget tests | Open |
| TD-006 | Low | CI/CD | No GitHub Actions workflow for automated testing | Open |
| TD-007 | Medium | Security | SSH password stored in plain text in config — should use secure storage | Open |
| TD-008 | Low | Docs | API service templates need example model generation | Open |
| TD-009 | Medium | UX | Connection card should persist last-used host/port via shared_preferences | Open |
| TD-010 | Low | KML | Logo overlay positioning needs per-rig calibration support | Open |

## Resolved
| ID | Area | Resolution | Date |
|---|---|---|---|
| TD-R001 | Import | Renamed `earthquake_service.dart` → `kml_service.dart` to fix broken import | Session 1 |
| TD-R002 | Structure | Moved `workflows/` from inside `skills/` to `.agent/workflows/` | Session 1 |
| TD-R003 | Skills | Rewritten all 8 existing skills from web-focus to Flutter-focus | Session 1 |
| TD-R004 | Paths | Replaced all hardcoded `/Users/victor/...` paths with relative paths | Session 1 |
