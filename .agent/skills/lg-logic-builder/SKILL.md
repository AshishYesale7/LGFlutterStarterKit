---
name: lg-logic-builder
description: Build business logic and data processing for LG features
---

# LG Logic Builder

Implements business logic following the layered architecture.

## Architecture Rules
- **Models** (`lib/models/`): Pure data classes, no imports from other layers
- **Services** (`lib/services/`): Business logic, API calls, SSH commands
- **Providers** (`lib/providers/`): State management, wraps services for UI
- **Screens** (`lib/screens/`): UI only, gets data from providers

## Data Flow
```
API/SSH → Service → Provider → Screen (UI)
User Input → Screen → Provider → Service → SSH/API
```

## Implementation Steps
1. Define the data model
2. Create or extend the service
3. Create or extend the provider
4. Wire to the UI via provider

## Validation
- Models should have `fromJson`/`toJson` if dealing with API data
- Services should handle errors gracefully
- Providers should use `notifyListeners()` after state changes
