# Dart Style Rules for LG Flutter Apps

## Formatting
- Use `dart format` with default line length (80 chars).
- Run `flutter analyze` before every commit — zero warnings policy.
- Use trailing commas on all multi-line argument lists, collections, and parameters.

## Naming Conventions
| Kind | Convention | Example |
|---|---|---|
| Classes | UpperCamelCase | `EarthquakeService`, `KMLBuilder` |
| Files | snake_case | `earthquake_service.dart`, `kml_builder.dart` |
| Variables, params | lowerCamelCase | `screenCount`, `flyToRange` |
| Constants | lowerCamelCase | `defaultTilt`, `maxScreens` |
| Private members | `_` prefix | `_sshClient`, `_isConnected` |
| Enums | UpperCamelCase values | `ConnectionState.connected` |
| Extensions | UpperCamelCase + Extension | `StringExtension`, `DateTimeExtension` |

## Imports
- Order: `dart:` → `package:flutter/` → `package:` → relative imports.
- Use relative imports within `lib/`.
- Never use `package:` imports for files within the same package.

## Documentation
- Every public class, method, and field MUST have a `///` doc comment.
- Use `///` (not `/** */`).
- First line is a single-sentence summary. Add blank line then details if needed.
- Include `@param` descriptions for non-obvious parameters.
- Include code examples for complex utilities.

## Null Safety
- Prefer non-nullable types — use `late` or default values over `?` where possible.
- Use `required` for named parameters that must be provided.
- Only use `!` (null assertion) when guaranteed non-null. Add a comment explaining why.

## State Management (Provider)
- One `ChangeNotifier` per service/domain concern.
- Call `notifyListeners()` after state changes, not before.
- Never call `notifyListeners()` from `dispose()`.
- Use `context.read<T>()` for one-time reads, `context.watch<T>()` for rebuilds.
- Keep ChangeNotifiers in `services/` or `providers/`, not in widgets.

## Error Handling
- Wrap all async operations in try-catch.
- Use custom exception classes: `LGConnectionException`, `KMLParseException`, etc.
- Never silently catch and ignore errors — at minimum `debugPrint`.
- Return `Result<T, E>` or `bool` for operations that can fail, not void.

## Constants
- Define in a dedicated `constants.dart` or domain-specific constants file.
- Never use magic numbers — extract to named constants.
- Screen-related constants go in `config.dart`.
