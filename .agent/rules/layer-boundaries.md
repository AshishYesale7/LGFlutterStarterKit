# Layer Boundary Rules

## Architecture Layers
```
┌─────────────────────────────┐
│      Screens (UI)           │  ← Only imports: providers, widgets, models
├─────────────────────────────┤
│      Providers (State)      │  ← Only imports: services, models
├─────────────────────────────┤
│      Services (Logic)       │  ← Only imports: models, dart:, package:
├─────────────────────────────┤
│      Models (Data)          │  ← Only imports: dart:
└─────────────────────────────┘
```

## FORBIDDEN Imports
- Screen → Service (MUST go through Provider)
- Model → anything above it
- Provider → Screen (circular dependency)

## ALLOWED Imports
- Screen → Provider (via context.watch/read)
- Screen → Model (for type references)
- Screen → Widget (reusable UI components)
- Provider → Service (wraps service logic)
- Provider → Model (state types)
- Service → Model (data handling)

## config.dart
`Config` class is a special case — it can be imported from any layer as it contains only static constants.
