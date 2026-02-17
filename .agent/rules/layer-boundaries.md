# Layer Boundary Rules

## Principle
Strict separation of concerns is enforced across all layers of the Flutter app.
Each layer has a single responsibility and communicates through well-defined contracts.
No layer may bypass or shortcut through another.

## The Five Layers

```
┌─────────────────────────────────────────────────────┐
│  PRESENTATION   screens/, widgets/                   │
│  Reads state from providers. Dispatches user actions.│
├─────────────────────────────────────────────────────┤
│  ORCHESTRATION  services/lg_service.dart             │
│  Facade that coordinates KML + SSH + API operations. │
├─────────────────────────────────────────────────────┤
│  DATA PROVIDERS services/*_service.dart, providers/  │
│  Fetch external data. Return domain models only.     │
├─────────────────────────────────────────────────────┤
│  KML GENERATION services/kml_service.dart            │
│  Produce KML XML from domain models. Stateless.      │
├─────────────────────────────────────────────────────┤
│  TRANSPORT      services/ssh_service.dart            │
│  Execute SSH commands to LG rig. No data logic.      │
└─────────────────────────────────────────────────────┘
```

## Import Matrix

| File in… | May import from… | Must NOT import from… |
|----------|------------------|-----------------------|
| `screens/` | `services/lg_service.dart`, `models/`, `widgets/`, `config.dart` | `dartssh2`, `package:http`, `kml_service.dart`, `ssh_service.dart` |
| `widgets/` | `models/`, `config.dart` | Any service, `dartssh2`, `package:http` |
| `lg_service.dart` | `ssh_service.dart`, `kml_service.dart`, `models/`, API services | `screens/`, `widgets/`, `package:flutter/material.dart` |
| `kml_service.dart` | `models/`, `dart:convert` | `dartssh2`, `ssh_service.dart`, `package:http`, `screens/` |
| `ssh_service.dart` | `dartssh2`, `dart:convert` | `kml_service.dart`, `models/`, `screens/`, API services |
| `*_provider.dart` | `package:http`, `models/`, `dart:convert` | `dartssh2`, `kml_service.dart`, `screens/` |

## Data Flow Direction

```
External API  →  Provider  →  Domain Model  →  KML Generator  →  KML String  →  SSH Transport  →  LG Rig
```

Data flows **one direction only** — left to right.
No layer may call back to a layer on its left.

## Enforcement

### Automated (by lg-shield)
- Static analysis of import statements.
- Grep scan for forbidden patterns in each layer.

### Manual (by lg-critical-advisor)
- Code review challenge: "Which layer does this logic belong to?"
- Architectural trace: student must draw the data flow for any feature.

## Violations

| Violation | Severity | Resolution |
|-----------|----------|------------|
| UI imports `dartssh2` | **BLOCK** | Move logic to LGService |
| UI generates KML strings | **BLOCK** | Move to KMLService |
| UI calls `http.get()` | **BLOCK** | Create a provider service |
| KML service opens SSH | **BLOCK** | Pass KML to LGService, let it call SSH |
| SSH service generates KML | **BLOCK** | KML generation belongs in KMLService |
| Provider returns raw JSON | **WARN** | Must parse to domain model |
| Service imports widget | **BLOCK** | Services have no UI awareness |

## Security Extensions
- Credentials must go through `flutter_secure_storage`, not `SharedPreferences`.
- API keys must live in `.env` or secure storage, not in source code.
- `.gitignore` must exclude all credential/key files.
