# Technical Debt Tracker

Known issues, shortcuts, and planned improvements.

## Format
| ID | Priority | Area | Description | Status |
|---|---|---|---|---|
| TD-001 | High | SSH | `ssh_service.dart` needs reconnection and keep-alive strategy | Open |
| TD-002 | Medium | KML | No KML validation step before sending to rig | Open |
| TD-003 | ~~Medium~~ | ~~Config~~ | ~~`config.dart` hardcodes LG defaults~~ | **Resolved** — uses `String.fromEnvironment` |
| TD-004 | Low | Server | `server/index.js` data proxy should add response caching | Open |
| TD-005 | Medium | Test | Zero test files exist — need unit + widget tests | Open |
| TD-006 | ~~Low~~ | ~~CI/CD~~ | ~~No GitHub Actions workflow for automated testing~~ | **Resolved** — 3 workflows exist |
| TD-007 | ~~Medium~~ | ~~Security~~ | ~~SSH password stored in plain text~~ | **Resolved** — uses `flutter_secure_storage` |
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
| TD-R005 | Config | `config.dart` now supports `--dart-define` overrides via `String.fromEnvironment` | Session 12 |
| TD-R006 | Security | Credentials stored via `flutter_secure_storage` in `SettingsProvider` | Session 12 |
| TD-R007 | Architecture | Moved `ConnectionStatus` enum into `ssh_service.dart` (transport layer owns types) | Session 12 |
| TD-R008 | Bug | Fixed `cleanLogos()` to target correct `logo_slave_N.kml` filenames | Session 12 |
| TD-R009 | Bug | Fixed `scaleByDouble` compile error in workflow visualizer zoom | Session 12 |
| TD-R010 | Architecture | Removed `kml_service.dart` import from `orbit.dart` (layer boundary fix) | Session 12 |
