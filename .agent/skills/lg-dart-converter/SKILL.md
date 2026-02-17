---
name: lg-dart-converter
description: Convert code between programming languages and Dart/Flutter
---

# Liquid Galaxy Data Converter

## Overview

This skill handles all data format conversions needed in Liquid Galaxy Flutter applications. The LG ecosystem requires frequent transformation between API responses (JSON/GeoJSON), Dart models, KML XML, and coordinate systems.

**Announce at start:** "I'm using the lg-dart-converter skill to convert [Source Format] to [Target Format]."

## 🔄 Conversion Matrix

| Source | Target | Use Case |
|--------|--------|----------|
| GeoJSON | KML | USGS/OSM data -> Google Earth |
| JSON | Dart Model | API response -> typed class |
| CSV | KML Placemarks | Spreadsheet data -> Earth pins |
| Dart Model | KML | App state -> visualization |
| Lat/Lon (DD) | DMS | Display formatting |
| DMS | Lat/Lon (DD) | User input parsing |
| KML | Dart Model | Import existing KML data |
| JSON | CSV | Data export |

## 🗺️ GeoJSON to KML Converter

```dart
/// Converts GeoJSON FeatureCollection to KML Document
class GeoJsonToKmlConverter {
  /// Convert a full GeoJSON FeatureCollection to KML
  static String convert(Map<String, dynamic> geoJson, {String documentName = 'Converted Data'}) {
    final features = geoJson['features'] as List? ?? [];
    final buffer = StringBuffer();

    buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.writeln('<kml xmlns="http://www.opengis.net/kml/2.2">');
    buffer.writeln('<Document>');
    buffer.writeln('  <name>$documentName</name>');

    for (final feature in features) {
      final props = feature['properties'] as Map<String, dynamic>? ?? {};
      final geometry = feature['geometry'] as Map<String, dynamic>? ?? {};
      final type = geometry['type'] as String? ?? '';
      final coords = geometry['coordinates'];

      final name = props['name'] ?? props['title'] ?? props['place'] ?? 'Unnamed';
      final desc = _buildDescription(props);

      switch (type) {
        case 'Point':
          buffer.writeln(_pointToKml(name.toString(), desc, coords));
          break;
        case 'LineString':
          buffer.writeln(_lineStringToKml(name.toString(), desc, coords));
          break;
        case 'Polygon':
          buffer.writeln(_polygonToKml(name.toString(), desc, coords));
          break;
        case 'MultiPoint':
          for (final coord in coords) {
            buffer.writeln(_pointToKml(name.toString(), desc, coord));
          }
          break;
      }
    }

    buffer.writeln('</Document>');
    buffer.writeln('</kml>');
    return buffer.toString();
  }

  static String _pointToKml(String name, String desc, List coords) {
    return '''
    <Placemark>
      <name>$name</name>
      <description><![CDATA[$desc]]></description>
      <Point>
        <coordinates>${coords[0]},${coords[1]},${coords.length > 2 ? coords[2] : 0}</coordinates>
      </Point>
    </Placemark>''';
  }

  static String _lineStringToKml(String name, String desc, List coords) {
    final coordStr = coords
        .map((c) => '${c[0]},${c[1]},${c.length > 2 ? c[2] : 0}')
        .join('\n          ');
    return '''
    <Placemark>
      <name>$name</name>
      <description><![CDATA[$desc]]></description>
      <LineString>
        <coordinates>$coordStr</coordinates>
      </LineString>
    </Placemark>''';
  }

  static String _polygonToKml(String name, String desc, List coords) {
    final outerRing = coords[0] as List;
    final coordStr = outerRing
        .map((c) => '${c[0]},${c[1]},${c.length > 2 ? c[2] : 0}')
        .join('\n            ');
    return '''
    <Placemark>
      <name>$name</name>
      <description><![CDATA[$desc]]></description>
      <Polygon>
        <outerBoundaryIs>
          <LinearRing>
            <coordinates>$coordStr</coordinates>
          </LinearRing>
        </outerBoundaryIs>
      </Polygon>
    </Placemark>''';
  }

  static String _buildDescription(Map<String, dynamic> props) {
    return props.entries
        .where((e) => e.value != null)
        .map((e) => '<b>${e.key}</b>: ${e.value}')
        .join('<br/>');
  }
}
```

## 📊 CSV to KML Converter

```dart
/// Converts CSV data with lat/lon columns to KML placemarks
class CsvToKmlConverter {
  /// Convert CSV string to KML
  /// [latColumn] and [lonColumn] are 0-based column indices
  /// [nameColumn] is optional for placemark naming
  static String convert(
    String csvData, {
    int latColumn = 0,
    int lonColumn = 1,
    int? nameColumn,
    bool hasHeader = true,
    String separator = ',',
  }) {
    final lines = csvData.split('\n').where((l) => l.trim().isNotEmpty).toList();
    final startIndex = hasHeader ? 1 : 0;
    final buffer = StringBuffer();

    buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.writeln('<kml xmlns="http://www.opengis.net/kml/2.2">');
    buffer.writeln('<Document><name>CSV Import</name>');

    for (int i = startIndex; i < lines.length; i++) {
      final columns = lines[i].split(separator).map((c) => c.trim()).toList();
      if (columns.length <= latColumn || columns.length <= lonColumn) continue;

      final lat = double.tryParse(columns[latColumn]);
      final lon = double.tryParse(columns[lonColumn]);
      if (lat == null || lon == null) continue;

      final name = nameColumn != null && columns.length > nameColumn
          ? columns[nameColumn]
          : 'Point ${i - startIndex + 1}';

      buffer.writeln('''
    <Placemark>
      <name>$name</name>
      <Point><coordinates>$lon,$lat,0</coordinates></Point>
    </Placemark>''');
    }

    buffer.writeln('</Document></kml>');
    return buffer.toString();
  }
}
```

## 🧮 Coordinate Converters

```dart
/// Coordinate system conversions
class CoordinateConverter {
  /// Decimal Degrees to Degrees Minutes Seconds
  static String toDMS(double decimal, {bool isLatitude = true}) {
    final direction = isLatitude
        ? (decimal >= 0 ? 'N' : 'S')
        : (decimal >= 0 ? 'E' : 'W');
    final abs = decimal.abs();
    final degrees = abs.floor();
    final minutes = ((abs - degrees) * 60).floor();
    final seconds = ((abs - degrees - minutes / 60) * 3600).toStringAsFixed(2);
    return '$degrees° $minutes\' $seconds" $direction';
  }

  /// DMS string to Decimal Degrees
  static double fromDMS(int degrees, int minutes, double seconds, String direction) {
    double dd = degrees + minutes / 60 + seconds / 3600;
    if (direction == 'S' || direction == 'W') dd *= -1;
    return dd;
  }

  /// Calculate distance between two points (Haversine formula)
  static double distanceKm(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in km
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  static double _toRadians(double degrees) => degrees * pi / 180;
}
```

## 📦 JSON to Dart Model Generator

### Pattern for generating model classes from JSON:

```dart
/// Utility to analyze a JSON structure and suggest a Dart model
class JsonModelAnalyzer {
  /// Analyze JSON and return suggested Dart class code
  static String generateModelCode(
    Map<String, dynamic> sampleJson,
    String className,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('class $className {');

    // Fields
    for (final entry in sampleJson.entries) {
      final type = _dartType(entry.value);
      buffer.writeln('  final $type ${_camelCase(entry.key)};');
    }

    buffer.writeln();

    // Constructor
    buffer.writeln('  const $className({');
    for (final key in sampleJson.keys) {
      buffer.writeln('    required this.${_camelCase(key)},');
    }
    buffer.writeln('  });');

    buffer.writeln();

    // fromJson
    buffer.writeln('  factory $className.fromJson(Map<String, dynamic> json) {');
    buffer.writeln('    return $className(');
    for (final entry in sampleJson.entries) {
      buffer.writeln('      ${_camelCase(entry.key)}: json[\'${entry.key}\'] as ${_dartType(entry.value)},');
    }
    buffer.writeln('    );');
    buffer.writeln('  }');

    buffer.writeln('}');
    return buffer.toString();
  }

  static String _dartType(dynamic value) {
    if (value is int) return 'int';
    if (value is double) return 'double';
    if (value is bool) return 'bool';
    if (value is List) return 'List<dynamic>';
    if (value is Map) return 'Map<String, dynamic>';
    return 'String';
  }

  static String _camelCase(String s) {
    final parts = s.split(RegExp(r'[_\-\s]'));
    return parts.first +
        parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
  }
}
```

## 📋 Conversion Checklist

- [ ] Source data format identified and validated
- [ ] Target format requirements documented
- [ ] Edge cases handled (null values, missing fields, malformed data)
- [ ] Coordinate order verified (KML uses lon,lat — not lat,lon!)
- [ ] Character encoding preserved (UTF-8)
- [ ] Special characters in XML properly escaped or wrapped in `CDATA`
- [ ] Output validated against target schema

## Handoff

After conversion, hand to the appropriate skill:
- If KML was generated -> **lg-kml-writer** for refinement
- If Dart model was generated -> **lg-file-generator** for file creation
- If data is ready for display -> **lg-ssh-controller** for rig deployment

```
