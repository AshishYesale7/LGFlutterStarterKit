---
name: lg-code-converter
description: Converts code between languages and frameworks relevant to LG development. Transforms JavaScript/Python prototypes into production Dart/Flutter code following LG architecture patterns.
---

# Liquid Galaxy Code Converter

## Overview

This skill converts code snippets, prototypes, and reference implementations from other languages (JavaScript, Python, Kotlin, Swift) into production-quality Dart/Flutter code that follows the Liquid Galaxy Controller-to-Rig architecture.

**Announce at start:** "I'm using the lg-code-converter skill to convert [Source Language] code to Dart/Flutter."

**GUARDRAIL**: If the student doesn't understand *why* the conversion choices were made, trigger the **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md).

## Common Conversion Scenarios

### 1. JavaScript → Dart (LG Web Apps to Flutter)
Many existing LG apps (BYOP, Laser Slides) are web-based. Convert their patterns:

| JavaScript Pattern | Dart/Flutter Equivalent |
|---|---|
| `fetch()` / `XMLHttpRequest` | `http.get()` / `http.post()` |
| `WebSocket` | `dartssh2` (SSH) for LG rig communication |
| `document.getElementById()` | `Provider` + `Consumer` widget |
| `setTimeout` / `setInterval` | `Future.delayed()` / `Timer.periodic()` |
| `JSON.parse()` / `JSON.stringify()` | `jsonDecode()` / `jsonEncode()` |
| `class extends EventEmitter` | `class with ChangeNotifier` |
| `Promise` / `async/await` | `Future` / `async/await` |
| `module.exports` | Dart library exports (no special syntax) |

### 2. Python → Dart (Data Processing Scripts)
Convert Python data pipelines (API fetch → transform → KML) to Dart:

| Python Pattern | Dart Equivalent |
|---|---|
| `requests.get()` | `http.get()` |
| `json.loads()` | `jsonDecode()` |
| `f"string {var}"` | `'string $var'` or `'string ${expr}'` |
| `dict` / `list` | `Map<String, dynamic>` / `List<T>` |
| `with open() as f` | `File(path).readAsString()` |
| `class:` | `class ClassName { }` |
| `try/except` | `try/catch` |
| `__init__` | Constructor |
| `@property` | Dart getter: `Type get name => _name;` |

### 3. Kotlin/Swift → Dart (Native Mobile to Flutter)
Convert existing native LG controller apps to cross-platform Flutter:

| Native Pattern | Dart/Flutter Equivalent |
|---|---|
| `val`/`let` (immutable) | `final` |
| `var` (mutable) | `var` (no type annotation) or typed |
| `data class` / `struct` | Plain Dart class with `final` fields |
| `suspend fun` / `async` | `Future<T> functionName() async` |
| `LiveData` / `@Published` | `ChangeNotifier` + `notifyListeners()` |
| `ViewModel` | Service class registered in `MultiProvider` |
| `Coroutine` / `DispatchQueue` | `Future`, `Isolate`, `compute()` |

## Conversion Process

### Step 1: Analyze Source Code
1. Identify the code's purpose in the LG context (SSH command? KML generation? API fetch?).
2. Map source patterns to Dart equivalents.
3. Identify LG-specific logic (coordinate handling, KML XML, SSH commands).

### Step 2: Convert with Architecture Alignment
1. Place converted code in the correct Flutter file:
   - Network/SSH logic → `services/`
   - KML generation → `services/kml_service.dart` or a converter in `utils/`
   - Data models → `models/`
   - UI logic → `screens/` or `widgets/`
2. Apply Dart conventions: `///` doc comments, `final` fields, typed collections.
3. Use `Provider` for state instead of global variables.

### Step 3: Verify
1. `flutter analyze` — zero errors.
2. `flutter test` — write a test for the converted logic.
3. Compare output of original and converted code with identical inputs.

## Example: Convert JS KML Generator to Dart

**JavaScript (original):**
```javascript
function generateFlyTo(lat, lon, alt, heading, tilt, range) {
  return `<gx:FlyTo>
    <gx:duration>3</gx:duration>
    <LookAt>
      <longitude>${lon}</longitude>
      <latitude>${lat}</latitude>
      <altitude>${alt}</altitude>
      <heading>${heading}</heading>
      <tilt>${tilt}</tilt>
      <range>${range}</range>
    </LookAt>
  </gx:FlyTo>`;
}
```

**Dart (converted):**
```dart
/// Generates a KML FlyTo element for Google Earth camera navigation.
///
/// Note: KML uses longitude,latitude order internally, but this
/// method accepts latitude,longitude (the intuitive order).
String generateFlyTo({
  required double latitude,
  required double longitude,
  double altitude = 0,
  double heading = 0,
  double tilt = 60,
  double range = 15000,
  double duration = 3.0,
}) {
  return '''<gx:FlyTo>
  <gx:duration>$duration</gx:duration>
  <LookAt>
    <longitude>$longitude</longitude>
    <latitude>$latitude</latitude>
    <altitude>$altitude</altitude>
    <heading>$heading</heading>
    <tilt>$tilt</tilt>
    <range>$range</range>
  </LookAt>
</gx:FlyTo>''';
}
```

## Handoff
After conversion → `lg-code-reviewer` for quality review.
