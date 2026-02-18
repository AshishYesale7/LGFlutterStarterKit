```skill
---
name: lg-api-integrator
description: 'Integrates external REST APIs into LG Flutter apps. Handles data fetching, parsing, caching, error handling, and transformation into KML-ready models. Supports USGS, NASA, OpenWeather, and custom APIs.'
---

# Liquid Galaxy API Integrator

## Overview

This skill handles the integration of external data sources into Liquid Galaxy Flutter applications. It covers the full pipeline: **API Discovery** -> **Model Design** -> **Service Implementation** -> **KML Transformation** -> **Caching & Error Handling**.

**Announce at start:** "I'm using the lg-api-integrator skill to integrate [API Name] data."

## 🌐 Supported API Catalog

### 1. USGS Earthquake Data
- **URL**: `https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson`
- **Format**: GeoJSON
- **Use Case**: Real-time earthquake visualization on Google Earth
- **License**: Public Domain

### 2. NASA APIs
- **APOD**: `https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY`
- **NEO**: `https://api.nasa.gov/neo/rest/v1/neo/browse?api_key=DEMO_KEY`
- **EPIC**: `https://api.nasa.gov/EPIC/api/natural?api_key=DEMO_KEY`
- **Mars Rover Photos**: `https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY`
- **Format**: JSON
- **License**: Open Data (api_key required, DEMO_KEY for testing)

### 3. OpenWeather
- **URL**: `https://api.openweathermap.org/data/2.5/weather?q={city}&appid={key}`
- **Format**: JSON
- **Use Case**: Weather overlays on LG
- **License**: Free tier available (API key required)

### 4. OpenStreetMap / Nominatim
- **Geocoding**: `https://nominatim.openstreetmap.org/search?q={query}&format=json`
- **Reverse**: `https://nominatim.openstreetmap.org/reverse?lat={lat}&lon={lon}&format=json`
- **Format**: JSON
- **License**: ODbL (attribution required)

### 5. ISS Tracker
- **URL**: `http://api.open-notify.org/iss-now.json`
- **Format**: JSON
- **Use Case**: Track ISS position in real-time on LG

### 6. Countries REST
- **URL**: `https://restcountries.com/v3.1/all`
- **Format**: JSON
- **Use Case**: Country info overlays

## 🏗️ Integration Architecture

```text
External API  -->  ApiService (http)  -->  Model (dart class)
                                               |
                                          KmlService
                                               |
                                          SshService --> LG Rig
```

### Standard Service Pattern

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService<T> {
  final String baseUrl;
  final T Function(Map<String, dynamic>) fromJson;
  final Duration cacheTimeout;
  
  List<T>? _cache;
  DateTime? _lastFetch;

  ApiService({
    required this.baseUrl,
    required this.fromJson,
    this.cacheTimeout = const Duration(minutes: 5),
  });

  Future<List<T>> fetchAll({Map<String, String>? queryParams}) async {
    // Return cache if still valid
    if (_cache != null && _lastFetch != null &&
        DateTime.now().difference(_lastFetch!) < cacheTimeout) {
      return _cache!;
    }

    try {
      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List items = data is List ? data : (data['features'] ?? data['results'] ?? []);
        _cache = items.map((e) => fromJson(e as Map<String, dynamic>)).toList();
        _lastFetch = DateTime.now();
        return _cache!;
      } else {
        throw HttpException('API returned ${response.statusCode}');
      }
    } catch (e) {
      if (_cache != null) return _cache!; // Return stale cache on error
      rethrow;
    }
  }

  void clearCache() {
    _cache = null;
    _lastFetch = null;
  }
}
```

### Standard Model Pattern

```dart
class GeoDataPoint {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final double altitude;
  final Map<String, dynamic> metadata;

  GeoDataPoint({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.altitude = 0,
    this.metadata = const {},
  });

  factory GeoDataPoint.fromJson(Map<String, dynamic> json) {
    // Override per API
    throw UnimplementedError('Use API-specific factory');
  }

  /// Convert to KML-ready map
  Map<String, dynamic> toKmlMap() => {
    'name': name,
    'description': description,
    'latitude': latitude,
    'longitude': longitude,
    'altitude': altitude,
  };
}
```

## 🔄 API-to-KML Transformation Pipeline

```dart
/// Generic pipeline: Fetch -> Parse -> Transform -> KML
Future<String> apiToKml({
  required ApiService service,
  required String Function(List<Map<String, dynamic>>) kmlGenerator,
}) async {
  final items = await service.fetchAll();
  final kmlMaps = items.map((item) => item.toKmlMap()).toList();
  return kmlGenerator(kmlMaps);
}
```

## 🛡️ Error Handling Requirements

1. **Network timeout**: Always set `timeout(Duration(seconds: 10))` on HTTP calls.
2. **Stale cache fallback**: If API fails, return last successful response.
3. **Rate limiting**: Respect API rate limits. Add `Future.delayed` between batch calls.
4. **User feedback**: Show `SnackBar` or loading indicator during API calls. Never freeze the UI.
5. **Null safety**: All model fields from APIs should handle `null` gracefully.

## 📋 Integration Checklist

- [ ] API endpoint tested in browser/Postman first
- [ ] Dart model created with `fromJson` factory
- [ ] Service wraps API with caching and error handling
- [ ] Data transforms cleanly into KML format
- [ ] Loading and error states visible in UI
- [ ] API key (if needed) is NOT hardcoded — use environment variable or config
- [ ] Rate limiting respected

## ⛔️ Student Interaction — MANDATORY

**After integrating each API, STOP and walk through with the student:**
1. Show the raw API response and the parsed domain model side-by-side.
2. Ask: *"Why do we cache API responses? What happens if the API is down?"*
3. If the student cannot explain the caching/fallback strategy, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md).

**DO NOT move to the next API** until the student understands the current integration.

## Reference Links

- **Lucia's API integration patterns**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **Dart http package**: https://pub.dev/packages/http
- **Flutter JSON serialization**: https://docs.flutter.dev/data-and-backend/serialization/json
- **USGS earthquake API docs**: https://earthquake.usgs.gov/fdsnws/event/1/
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## Handoff

After integration, hand to **lg-kml-writer** (.agent/skills/lg-kml-writer/SKILL.md) to generate the KML visualization, then **lg-ssh-controller** (.agent/skills/lg-ssh-controller/SKILL.md) to send to the rig.

## 🔗 Skill Chain

After the API is integrated, tested, and the student understands the caching/error strategy, **automatically offer the next stage**:

> *"API integration complete! Data is flowing and cached properly. Now let's transform this data into KML that will look stunning on the LG rig. Ready for KML generation? 🌍"*

If student says "ready" → activate `.agent/skills/lg-kml-writer/SKILL.md`.

```
