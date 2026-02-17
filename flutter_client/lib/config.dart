/// Central configuration for the LG Flutter Starter Kit.
///
/// All connection defaults, rig geometry, and app-wide settings live here.
/// Students should modify these values to match their LG rig setup.
class Config {
  // ─── LG Rig Connection ───────────────────────────────────────────────
  /// Default SSH host for the LG master machine.
  static const String lgHost = '192.168.56.101';

  /// Default SSH port.
  static const int lgPort = 22;

  /// Default SSH username.
  static const String lgUser = 'lg';

  /// Default SSH password.
  static const String lgPassword = 'lg';

  // ─── LG Rig Geometry ─────────────────────────────────────────────────
  /// Total number of screens in the LG rig.
  static const int totalScreens = 3;

  /// The master screen number (always 1 in a standard LG setup).
  static const int masterScreen = 1;

  /// Left-most screen number.
  static int get leftScreen {
    // In a 3-screen rig: lg3 = left, lg1 = center, lg2 = right
    return totalScreens;
  }

  /// Right-most screen number.
  static int get rightScreen {
    // Screen 2 is always to the right of master
    return 2;
  }

  // ─── App Settings ────────────────────────────────────────────────────
  /// Application name displayed in UI.
  static const String appName = 'LG Flutter Starter Kit';

  /// Application version.
  static const String appVersion = '1.0.0';

  /// Node.js server URL (for optional server integration).
  static const String serverUrl = 'http://localhost:3000';

  /// Connection timeout in seconds.
  static const int connectionTimeout = 10;

  /// KML refresh interval in seconds.
  static const int kmlRefreshInterval = 2;
}
