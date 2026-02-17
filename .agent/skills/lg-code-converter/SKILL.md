---
name: lg-code-converter
description: Convert between different code formats and architectures
---

# LG Code Converter

Converts between different code formats, architectures, and data representations.

## Conversions
1. **JSON ↔ Dart Model**: Generate Dart classes from JSON
2. **XML ↔ KML**: Validate and transform KML documents
3. **REST ↔ WebSocket**: Convert API patterns
4. **Stateful ↔ Provider**: Refactor state management

## JSON to Dart Model
```dart
// From: {"name": "Lleida", "lat": 41.6, "lng": 0.6}
class Location {
  final String name;
  final double lat;
  final double lng;

  Location({required this.name, required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json['name'] as String,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {'name': name, 'lat': lat, 'lng': lng};
}
```
