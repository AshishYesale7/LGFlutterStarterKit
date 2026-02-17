# Flutter Best Practices

## State Management
- Use Provider (ChangeNotifier) for shared state
- Use setState only for local UI state (animations, form fields)
- Never store state in static variables

## Widget Rules
- Prefer `const` constructors
- Extract reusable widgets into separate files
- Use `context.watch<T>()` for reactive rebuilds
- Use `context.read<T>()` for one-time access (event handlers)

## Performance
- Use `const` wherever possible
- Avoid rebuilding entire widget trees (use granular providers)
- Don't create objects inside `build()` methods
- Use `ListView.builder` for long lists

## Material 3
- Use `ThemeData` with `colorSchemeSeed` and `useMaterial3: true`
- Prefer `FilledButton` > `OutlinedButton` > `TextButton`
- Use `Card` for content groups
- Use `ColorScheme` colors, never hardcode

## Navigation
- Use named routes for simplicity
- Use `pushReplacementNamed` for non-reversible transitions (splash → main)
- Use `pushNamed` for reversible navigation (main → settings)
