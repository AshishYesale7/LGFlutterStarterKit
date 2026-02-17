---
name: lg-file-generator
description: Generate boilerplate files from templates
---

# LG File Generator

Generates boilerplate Dart files following project conventions.

## Templates Available
1. **Screen**: StatefulWidget with AppBar, provider access, loading/error states
2. **Service**: Class with error handling, async methods
3. **Provider**: ChangeNotifier with getters, update methods
4. **Model**: Data class with fromJson/toJson, copyWith
5. **Widget**: Reusable StatelessWidget with doc comments

## Naming Conventions
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables: `camelCase`
- Constants: `camelCase` (Dart convention)
- Private members: `_prefixed`

## File Structure
Every generated file includes:
1. Import block (dart:, package:, relative)
2. Doc comment for the class
3. Class definition with const constructor
4. Clear section comments for organization
