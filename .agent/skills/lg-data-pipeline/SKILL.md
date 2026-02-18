---
name: lg-data-pipeline
description: 'Enforces and generates the strict API → Domain → KML → Transport data pipeline. Ensures external API data flows through clean contracts before reaching the LG rig.'
---

# LG Data Pipeline — API-to-Rig Data Flow Generator

Manages the end-to-end data transformation pipeline:
**External API → Provider Contract → Domain Model → KML Feature → KML Payload → LG Transport**

**Announce:** "Data Pipeline skill activated. Building the clean path from API data to LG visualization."

**⚠️ PROMINENT GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) and **LG Shield** (.agent/skills/lg-shield/SKILL.md) are active at all times. If the student can't explain why we separate API providers from KML generation, STOP and invoke the Critical Advisor.

## The Pipeline Contract

Every data visualization in an LG app follows this exact flow:

```
┌─────────────────────────────────────────────────────────────────┐
│                     DATA PIPELINE                                │
│                                                                  │
│  External API         lib/providers/         lib/models/         │
│  (USGS, NASA, etc.)   *_provider.dart        *_model.dart        │
│       │                     │                     │              │
│       ▼                     ▼                     ▼              │
│   HTTP Response  →  Provider Contract  →  Domain Model           │
│                                               │                  │
│                                               ▼                  │
│                     lib/services/         lib/services/           │
│                     kml_service.dart      ssh_service.dart        │
│                          │                     │                 │
│                          ▼                     ▼                 │
│                     KML Payload  ────→  SSH Transport  → LG Rig  │
└─────────────────────────────────────────────────────────────────┘
```

### Layer Rules
| Layer | Input | Output | Forbidden |
|-------|-------|--------|-----------|
| **Provider** | HTTP response (JSON/XML) | Domain model(s) | KML strings, SSH calls, widget refs |
| **Domain Model** | Raw data | Clean typed Dart class | Business logic, side effects |
| **KML Feature** | Domain model(s) | Valid KML XML string | Network calls, SSH, file I/O |
| **Transport** | KML string + SSH config | Command execution | KML generation, data parsing |

## Workflow

### Step 1 — Define the Provider Contract
For each external API, create a provider class in `lib/providers/`:

```dart
/// lib/providers/geocoding_provider.dart
///
/// Contract for geocoding lookups. The implementation can be swapped
/// (OpenCage, Nominatim, Google Geocoding) without changing downstream code.
abstract class GeocodingProvider {
  Future<List<GeocodingResult>> search(String query);
  Future<GeocodingResult?> reverse(double latitude, double longitude);
}
```

The provider:
- Owns the HTTP call.
- Parses JSON into a **domain model**.
- Exposes **only domain data** downstream (no raw JSON leaking out).

### Step 2 — Define Domain Models
Create immutable data classes in `lib/models/`:

```dart
/// lib/models/geocoding_result.dart
class GeocodingResult {
  final String name;
  final double latitude;
  final double longitude;
  final String? country;
  final String? formattedAddress;

  const GeocodingResult({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.country,
    this.formattedAddress,
  });
}
```

Rules:
- Pure data — no methods that perform I/O.
- Immutable (`final` fields, `const` constructor).
- No KML logic, no SSH references.

### Step 3 — Build KML Features
Each visualization type gets a dedicated KML generator method in `KMLService`
(or a separate feature class for complex visualizations):

```dart
/// Takes domain models, produces a KML payload string.
String generateGeocodingKML(List<GeocodingResult> results) {
  // Domain model → KML XML
  // Uses longitude,latitude,altitude coordinate order
  // Returns complete, valid KML 2.2 document
}
```

KML features can compose multiple KML elements:
- Point placemarks from coordinates
- Polygon/LineString geometries from route data
- `<gx:Tour>` sequences from ordered location lists
- `<TimeStamp>` / `<TimeSpan>` for time-based animation
- `<ScreenOverlay>` for legends and logos
- 3D extruded polygons for volumetric data

### Step 4 — Wire to Transport
The `LGService` facade orchestrates the final step:

```dart
Future<void> visualizeGeocodingResults(List<GeocodingResult> results) async {
  final kml = _kmlService.generateGeocodingKML(results);
  await _sshService.sendKML(kml);
}
```

The UI calls `lgService.visualizeGeocodingResults(results)` — it never touches
KML strings or SSH commands.

## KML Payload Standard

All KML generator methods must produce payloads that:
- Start with `<?xml version="1.0" encoding="UTF-8"?>`
- Use `xmlns="http://www.opengis.net/kml/2.2"` namespace
- Use `xmlns:gx="http://www.google.com/kml/ext/2.2"` for tours/animations
- Use `longitude,latitude,altitude` coordinate order (NOT lat,lon)
- Escape special XML characters (`&`, `<`, `>`, `"`, `'`)
- Are under 2 MB when serialized

## Adding a New API Integration

Checklist for adding any new external API to the pipeline:

1. [ ] Create provider contract in `lib/providers/`
2. [ ] Create domain model(s) in `lib/models/`
3. [ ] Add KML generator method to `KMLService` (or new feature class)
4. [ ] Add orchestration method to `LGService`
5. [ ] Add UI trigger in the appropriate screen
6. [ ] Add the API URL to `config.dart`
7. [ ] Run `lg-shield` boundary validation
8. [ ] Write unit tests for provider, model, and KML generator

## Output
For each new API integration, produces:
- Provider contract file
- Domain model file
- KML generator method
- LGService orchestration method
- Entry in `docs/plans/` describing the pipeline

## ⛔️ Student Interaction — MANDATORY

**After building each pipeline stage, STOP and explain:**
1. Show the data transformation at that stage (Raw JSON → Model → KML coordinates).
2. Ask: *"Why do we convert the raw API response into a domain model instead of passing JSON directly to KML generation?"*
3. If the student cannot explain the separation, demonstrate by tracing a single data point through all layers.
4. Link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md) for Data Pipeline and KML topics.

**DO NOT move to the next pipeline stage** until the student can explain the current transformation.

## Reference Links

- **Lucia's kml_service.dart**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **KML Reference (Google)**: https://developers.google.com/kml/documentation/kmlreference
- **Dart JSON serialization**: https://docs.flutter.dev/data-and-backend/serialization/json
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## Handoff
Passes generated code to `lg-code-reviewer` for quality checks and to
`lg-shield` for boundary validation.

## 🔗 Skill Chain

After the data pipeline is wired and the student passes the checkpoint, **automatically offer the next stage**:

> *"Data pipeline is solid! Clean contracts from API to KML. Now let's scaffold the Flutter screens that will use these services. Ready for the UI Scaffolder? 📱"*

If student says "ready" → activate `.agent/skills/lg-ui-scaffolder/SKILL.md`.
