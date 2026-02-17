# Dart Style Rules

## Naming
- Classes: `PascalCase` (e.g., `SSHService`, `KMLService`)
- Files: `snake_case.dart` (e.g., `ssh_service.dart`)
- Variables/functions: `camelCase` (e.g., `isConnected`, `flyTo`)
- Constants: `camelCase` (Dart convention, NOT SCREAMING_CASE)
- Private members: `_prefixed` (e.g., `_client`, `_status`)

## Imports
Order: dart: → package: → relative
```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_client/config.dart';
```

## Documentation
- All public APIs must have `///` doc comments
- Classes need a summary of purpose
- Complex methods need parameter and return documentation

## Error Handling
- All async methods must have try/catch
- Use specific exceptions, not generic `Exception`
- Log errors with `print` in development, structured logging in production

## Null Safety
- Prefer non-nullable types
- Use `?` only when null is a valid state
- Use `!` only when null is logically impossible (with comment explaining why)
- Prefer `??` for defaults over null checks
- Never use magic numbers — extract to named constants.
- Screen-related constants go in `config.dart`.
