# LG Architecture Rules

## Project Structure
```
flutter_client/
├── lib/
│   ├── config.dart              # Centralized configuration
│   ├── main.dart                # App entry point with MultiProvider
│   ├── models/
│   │   └── connection_status.dart
│   ├── providers/
│   │   ├── settings_provider.dart
│   │   └── theme_provider.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── connection_screen.dart
│   │   ├── main_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── help_screen.dart
│   │   ├── home_screen.dart     # Legacy compatibility
│   │   └── optional_files/
│   │       ├── nodejs.dart
│   │       ├── orbit.dart
│   │       ├── kml_viewer.dart
│   │       ├── earthquake.dart
│   │       └── balloon.dart
│   ├── services/
│   │   ├── ssh_service.dart
│   │   ├── lg_service.dart
│   │   ├── kml_service.dart
│   │   ├── earthquake_service.dart
│   │   └── socket_service.dart
│   ├── modules/
│   │   └── bouncing_ball/
│   │       └── screens/
│   │           └── bouncing_ball_screen.dart
│   └── widgets/               # Reusable widgets (add as needed)
├── pubspec.yaml
└── test/
```

## LG Rig Defaults
- Host: 192.168.56.101
- Port: 22
- User/Pass: lg/lg
- Screens: 3 (lg3=left, lg1=master, lg2=right)

## Screen Flow
```
Splash → Connection → Main → (Settings | Help)
```

## Provider Setup
`main.dart` uses `MultiProvider` with:
- `SettingsProvider` — connection settings with SharedPreferences
- `ThemeProvider` — light/dark/system theme
- `LGService` — LG rig operations (added as needed)
