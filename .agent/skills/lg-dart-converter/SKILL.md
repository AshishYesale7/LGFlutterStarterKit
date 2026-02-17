---
name: lg-dart-converter
description: Convert code between programming languages and Dart/Flutter
---

# LG Dart Converter

Converts code snippets between programming languages and Dart/Flutter.

## Supported Conversions
- JavaScript/TypeScript → Dart
- Python → Dart
- Java/Kotlin → Dart
- C#/Swift → Dart
- HTML/CSS → Flutter Widgets

## Conversion Rules
1. Maintain equivalent functionality
2. Follow Dart style conventions
3. Use appropriate Dart types (List, Map, Set)
4. Convert async patterns (Promise → Future, async/await)
5. Convert class patterns to Dart syntax

## Common Transforms
| Source | Dart |
|--------|------|
| `console.log()` | `print()` / `debugPrint()` |
| `JSON.parse()` | `jsonDecode()` |
| `fetch()` | `http.get()` |
| `.then()` | `await` |
| `interface` | `abstract class` |
| `null` checks | Null safety (`?`, `!`, `??`) |
