---
name: lg-file-generator
description: 'Generates well-structured Dart/Flutter files from templates. Creates screens, services, models, widgets, and test files following LG architecture patterns and SOLID principles.'
---

# Liquid Galaxy Dart File Generator

## Overview

This skill generates Dart/Flutter source files that follow the established Liquid Galaxy architecture patterns. It ensures consistent code structure, proper imports, documentation, and adherence to SOLID/DRY principles across all generated files.

**Announce at start:** "I'm using the lg-file-generator skill to create [File Type]: [Name]."

## File Types & Templates

### 1. Screen (StatefulWidget)

**Path pattern**: `lib/screens/<feature>_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [FeatureName] Screen
///
/// ARCHITECTURE: This screen follows the Controller pattern.
/// It reads state from Provider services and renders the phone UI.
/// No SSH, KML, or API logic should live here — delegate to services.
class FeatureNameScreen extends StatefulWidget {
  const FeatureNameScreen({super.key});

  @override
  State<FeatureNameScreen> createState() => _FeatureNameScreenState();
}

class _FeatureNameScreenState extends State<FeatureNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Name'),
      ),
      body: const Center(
        child: Text('Feature Name Screen'),
      ),
    );
  }
}
```

### 2. Service (ChangeNotifier)

**Path pattern**: `lib/services/<service_name>_service.dart`

```dart
import 'package:flutter/foundation.dart';

/// [ServiceName] Service
///
/// ARCHITECTURE: Follows the Service-Repository pattern.
/// Holds state, manages SSH/API communication, and notifies listeners.
/// Registered as a Provider in main.dart.
class ServiceNameService with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // TODO: Add service-specific state fields

  Future<void> initialize() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Initialization logic
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // TODO: Cleanup resources (close SSH connections, cancel timers)
    super.dispose();
  }
}
```

### 3. Data Model

**Path pattern**: `lib/models/<model_name>.dart`

```dart
/// [ModelName] Model
///
/// Represents a [description] entity.
/// Includes JSON serialization for API integration
/// and KML conversion for Liquid Galaxy visualization.
class ModelName {
  final String id;
  final String name;
  // TODO: Add model-specific fields (latitude, longitude, etc.)

  const ModelName({
    required this.id,
    required this.name,
  });

  /// Create from JSON (API response)
  factory ModelName.fromJson(Map<String, dynamic> json) {
    return ModelName(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  /// Convert to KML-compatible map for lg-kml-writer
  Map<String, dynamic> toKmlMap() => {
    'name': name,
    // 'latitude': latitude,
    // 'longitude': longitude,
    // 'description': description,
  };

  @override
  String toString() => 'ModelName(id: $id, name: $name)';
}
```

### 4. Reusable Widget

**Path pattern**: `lib/widgets/<widget_name>.dart`

```dart
import 'package:flutter/material.dart';

/// [WidgetName] Widget
///
/// A reusable UI component for [purpose].
/// Follows the composition-over-inheritance principle.
class WidgetName extends StatelessWidget {
  final String title;
  // TODO: Add widget parameters

  const WidgetName({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(title),
    );
  }
}
```

### 5. Unit Test

**Path pattern**: `test/<feature>_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeatureName', () {
    test('should do X when Y', () {
      // Arrange
      // Act
      // Assert
      expect(true, isTrue);
    });

    test('should handle error gracefully', () {
      // Arrange
      // Act
      // Assert
    });
  });
}
```

### 6. Feature Module

**Path pattern**: `lib/modules/<module_name>/`

A module is a self-contained feature directory:

```text
lib/modules/<module_name>/
├── screens/
│   └── <module>_screen.dart
├── services/
│   └── <module>_service.dart
├── models/
│   └── <module>_model.dart
├── widgets/
│   └── <module>_widget.dart
└── README.md  (brief feature docs)
```

## Generation Rules

1. **Naming**: Use `snake_case` for files, `PascalCase` for classes, `camelCase` for variables.
2. **Imports**: Always use relative imports within the package. Group imports: dart, package, local.
3. **Documentation**: Every public class and method gets a `///` doc comment.
4. **Architecture comment**: Every file gets an `ARCHITECTURE:` comment explaining its role.
5. **const constructors**: Use `const` wherever possible for widget constructors.
6. **Null safety**: All generated code must be null-safe. No `!` operator without justification.
7. **Tests**: For every service or model generated, also generate a corresponding test file.

## Post-Generation Checklist

- [ ] File created in correct directory
- [ ] Imports are correct and complete
- [ ] Class name matches file name convention
- [ ] Doc comments present on all public members
- [ ] `flutter analyze` passes with zero issues
- [ ] Corresponding test file created (for services/models)
- [ ] Provider registered in `main.dart` (for services)

## Handoff

After file generation, return to the calling workflow or use **lg-exec** (.agent/skills/lg-exec/SKILL.md) for implementation.
