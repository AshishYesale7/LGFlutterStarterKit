# Flutter Best Practices for LG Apps

## Project Structure
- One screen per file in `screens/`.
- One service per file in `services/`.
- One model per file in `models/`.
- Reusable widgets in `widgets/` -- extract when used more than once.
- No business logic in widgets -- delegate to services.

## Platform Awareness
- The Flutter app runs on a **smartphone/tablet** as a controller.
- Android is the primary platform (phone controller for the LG rig).
- iOS is also a valid controller platform.
- Linux/macOS are for development and testing.
- Use `Platform.isLinux`, `Platform.isAndroid`, etc. for platform-specific behavior.
- For web, use `kIsWeb` from `package:flutter/foundation.dart`.

## State Management
- Use `Provider` with `ChangeNotifier`.
- Register all providers at the top in `main.dart` using `MultiProvider`.
- One ChangeNotifier per concern: `LGService`, `DataService`, etc.
- Use `context.watch<T>()` to rebuild on change, `context.read<T>()` for one-time.
- Avoid `Provider.of<T>(context, listen: true)` -- prefer `context.watch`.

## Async Operations
- All SSH/API calls are async -- use `Future<void>` with try-catch.
- Show loading states during network operations.
- Use `FutureBuilder` or `Consumer` for async UI updates.
- Implement timeouts on SSH connections (10 seconds max).
- Handle `SocketException`, `TimeoutException`, `SSHAuthenticationException`.

## Navigation
- Use named routes defined in `MaterialApp.routes`.
- Use `Navigator.pushNamed(context, '/route')`.
- Each screen is a top-level `StatefulWidget` or `StatelessWidget`.
- Pass data via constructors or read from providers, not via route arguments.

## Theme & Design
- Use Material 3 with `ThemeData(useMaterial3: true, colorSchemeSeed: ...)`.
- Support dark mode (LG demos are often in dark rooms).
- Use responsive layout: `LayoutBuilder` and `MediaQuery`.
- Minimum touch target: 48x48 dp for phone builds.

## Performance
- Use `const` constructors wherever possible.
- Use `ListView.builder` for long lists (never `ListView` with all children).
- Avoid unnecessary rebuilds -- push `Consumer` down the widget tree.
- Profile with Flutter DevTools before release.

## Error Handling Pattern
```dart
try {
  await sshService.connect();
} on SSHAuthenticationException {
  _showErrorSnackbar('Invalid credentials');
} on SocketException {
  _showErrorSnackbar('Cannot reach LG rig');
} on TimeoutException {
  _showErrorSnackbar('Connection timed out');
} catch (e) {
  _showErrorSnackbar('Unexpected error: $e');
}
```

## Testing
- Write unit tests for all services (`test/services/`).
- Write widget tests for all screens (`test/screens/`).
- Mock SSH connections -- use `mockito` or manual mocks.
- Test KML output strings with XML assertions.
- Minimum 80% coverage before release.
- Run: `flutter test --coverage`

## Build & Release
- Android APK is the primary deliverable: `flutter build apk --release`.
- Strip debug symbols: `flutter build apk --release --split-per-abi`.
- Always test on a real device before submitting.
