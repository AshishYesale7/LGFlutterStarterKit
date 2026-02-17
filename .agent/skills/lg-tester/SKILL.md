---
name: lg-tester
description: Creates and manages unit tests, widget tests, and integration tests for LG Flutter apps. Covers SSH mock testing, KML validation, Provider testing, and service layer verification.
---

# Liquid Galaxy Tester

## Overview

This skill generates comprehensive tests for Liquid Galaxy Flutter controller applications. It covers unit tests for services, widget tests for screens, and integration tests for the full SSH → KML → LG rig pipeline.

**Announce at start:** "I'm using the lg-tester skill to create tests for [Component]."

**GUARDRAIL**: If the student skips testing or says "tests aren't needed," trigger the **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md). Testing is non-negotiable for OSS quality.

## 🧪 Test Structure

```
flutter_client/test/
├── services/
│   ├── kml_service_test.dart     # KML generation tests
│   ├── ssh_service_test.dart     # SSH mock tests
│   ├── lg_service_test.dart      # Facade integration tests
│   └── <api>_service_test.dart   # API service tests
├── models/
│   └── <model>_test.dart         # Model serialization tests
├── screens/
│   └── home_screen_test.dart     # Widget tests
└── utils/
    └── coordinate_test.dart      # Utility function tests
```

## 📋 Test Categories

### 1. KML Service Tests (Critical)

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:lg_flutter_client/services/kml_service.dart';

void main() {
  late KMLService kmlService;

  setUp(() {
    kmlService = KMLService();
  });

  group('KML Generation', () {
    test('generates valid KML XML header', () {
      final kml = kmlService.generatePlacemark(
        name: 'Test',
        latitude: 41.3851,
        longitude: 2.1734,
      );
      expect(kml, contains('<?xml version="1.0" encoding="UTF-8"?>'));
      expect(kml, contains('<kml xmlns='));
    });

    test('coordinate order is longitude,latitude in KML output', () {
      final kml = kmlService.generatePlacemark(
        name: 'Barcelona',
        latitude: 41.3851,
        longitude: 2.1734,
      );
      // KML coordinate order: lon,lat,alt
      expect(kml, contains('<coordinates>2.1734,41.3851,'));
    });

    test('FlyTo generates valid LookAt element', () {
      final kml = kmlService.generateFlyTo(
        latitude: 41.3851,
        longitude: 2.1734,
        range: 15000,
        tilt: 60,
      );
      expect(kml, contains('<longitude>2.1734</longitude>'));
      expect(kml, contains('<latitude>41.3851</latitude>'));
      expect(kml, contains('<range>15000'));
      expect(kml, contains('<tilt>60'));
    });

    test('orbit generates 36 steps for full 360 degrees', () {
      final kml = kmlService.generateOrbit(
        latitude: 41.3851,
        longitude: 2.1734,
        range: 10000,
        tilt: 60,
      );
      // 36 FlyTo steps for 360-degree orbit
      final flyToCount = RegExp(r'<gx:FlyTo>').allMatches(kml).length;
      expect(flyToCount, equals(36));
    });

    test('clean KML produces empty document', () {
      final kml = kmlService.generateCleanKML();
      expect(kml, contains('<kml'));
      expect(kml, contains('</kml>'));
      // Should not contain any Placemark or other content
      expect(kml, isNot(contains('<Placemark>')));
    });
  });

  group('KML Edge Cases', () {
    test('handles special characters in names', () {
      final kml = kmlService.generatePlacemark(
        name: 'M&M\'s "Shop" <Store>',
        latitude: 0,
        longitude: 0,
      );
      // Should use CDATA or escape XML entities
      expect(kml, isNot(contains('<Store>')));
    });

    test('handles extreme coordinates', () {
      final kml = kmlService.generatePlacemark(
        name: 'South Pole',
        latitude: -90.0,
        longitude: 180.0,
      );
      expect(kml, contains('-90.0'));
      expect(kml, contains('180.0'));
    });
  });
}
```

### 2. SSH Service Mock Tests

```dart
import 'package:flutter_test/flutter_test.dart';

/// Mock SSH client for testing without a real LG rig.
class MockSSHService {
  bool _connected = false;
  final List<String> executedCommands = [];

  bool get isConnected => _connected;

  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    _connected = true;
  }

  Future<String> execute(String command) async {
    if (!_connected) throw Exception('Not connected');
    executedCommands.add(command);
    return 'OK';
  }

  void disconnect() {
    _connected = false;
  }
}

void main() {
  late MockSSHService mockSSH;

  setUp(() {
    mockSSH = MockSSHService();
  });

  group('SSH Connection', () {
    test('connects successfully', () async {
      await mockSSH.connect(
        host: '192.168.1.100',
        port: 22,
        username: 'lg',
        password: 'lg',
      );
      expect(mockSSH.isConnected, isTrue);
    });

    test('throws when executing without connection', () {
      expect(
        () => mockSSH.execute('echo test'),
        throwsException,
      );
    });

    test('disconnect updates state', () async {
      await mockSSH.connect(
        host: '192.168.1.100',
        port: 22,
        username: 'lg',
        password: 'lg',
      );
      mockSSH.disconnect();
      expect(mockSSH.isConnected, isFalse);
    });
  });

  group('SSH Commands for LG', () {
    setUp(() async {
      await mockSSH.connect(
        host: 'localhost',
        port: 2222,
        username: 'lg',
        password: 'lg',
      );
    });

    test('sendKML writes to correct path', () async {
      final kml = '<kml>...</kml>';
      await mockSSH.execute(
        "echo '$kml' > /var/www/html/kml/slave_0.kml",
      );
      expect(mockSSH.executedCommands.last, contains('slave_0.kml'));
    });

    test('flyTo writes to query.txt', () async {
      await mockSSH.execute(
        'echo "flytoview=<LookAt>...</LookAt>" > /tmp/query.txt',
      );
      expect(mockSSH.executedCommands.last, contains('/tmp/query.txt'));
    });

    test('clearKML empties all slave files', () async {
      await mockSSH.execute(
        "echo '' > /var/www/html/kml/slave_0.kml",
      );
      expect(mockSSH.executedCommands.last, contains("echo ''"));
    });
  });
}
```

### 3. Model Tests

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Model serialization', () {
    test('fromJson creates valid model from API response', () {
      final json = {
        'id': '12345',
        'properties': {
          'mag': 4.5,
          'place': '10km NE of Barcelona',
          'time': 1700000000000,
        },
        'geometry': {
          'coordinates': [2.1734, 41.3851, 10.0],
        },
      };

      // Test your model's fromJson factory
      // final earthquake = Earthquake.fromJson(json);
      // expect(earthquake.magnitude, equals(4.5));
      // expect(earthquake.latitude, equals(41.3851));
      // expect(earthquake.longitude, equals(2.1734));
    });

    test('toKmlMap produces correct coordinate order', () {
      // Verify that toKmlMap returns lon,lat (KML order)
      // final kmlMap = earthquake.toKmlMap();
      // Longitude should come before latitude in coordinates
    });
  });
}
```

### 4. Widget Tests

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('HomeScreen', () {
    testWidgets('shows connect button when disconnected', (tester) async {
      // Build with a mock LGService that returns isConnected = false
      // Verify 'Connect to LG Rig' button is present
    });

    testWidgets('shows visualization controls when connected', (tester) async {
      // Build with a mock LGService that returns isConnected = true
      // Verify earthquake, fly-to, orbit buttons are present
    });
  });
}
```

## 🎯 Coverage Targets

| Component | Target | Priority |
|---|---|---|
| KML generation | 95% | Critical — bugs cause invisible errors |
| SSH commands | 80% | High — mock-based testing |
| Models (fromJson/toKml) | 90% | High — data pipeline correctness |
| Services (business logic) | 80% | High — app reliability |
| Widgets (UI) | 60% | Medium — visual verification is manual |

## 🏃 Running Tests

```bash
# All tests
cd flutter_client && flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/services/kml_service_test.dart

# Verbose output
flutter test --reporter expanded
```

## Handoff
After tests written → `lg-code-reviewer` for review. Tests must pass before any release.
