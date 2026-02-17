---
name: lg-tester
description: Generate and run tests for LG Flutter apps
---

# LG Tester

Creates and runs unit tests, widget tests, and integration tests.

## Test Strategy
1. **Unit Tests**: Models, services, KML generation
2. **Widget Tests**: Screen rendering, user interactions
3. **Integration Tests**: Full flow (connect → send KML → verify)

## Test File Convention
- `test/unit/` — unit tests
- `test/widget/` — widget tests
- `test/integration/` — integration tests
- Test file mirrors source: `lib/services/kml_service.dart` → `test/unit/kml_service_test.dart`

## KML Test Protocol
```dart
test('generates valid placemark KML', () {
  final kml = kmlService.generatePlacemark(
    name: 'Test', latitude: 41.0, longitude: 0.6,
  );
  expect(kml, contains('<kml'));
  expect(kml, contains('<Placemark>'));
  expect(kml, contains('0.6,41.0'));
});
```

## Coverage Target
- Minimum 80% line coverage
- Run: `flutter test --coverage`
- Report: `genhtml coverage/lcov.info -o coverage/html`
