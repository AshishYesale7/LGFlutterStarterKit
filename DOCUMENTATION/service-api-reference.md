# Service API Reference

> Complete method signatures, parameters, and usage examples for every service in the starter kit.

---

## Table of Contents

- [LGService — Orchestration Facade](#lgservice--orchestration-facade)
- [KMLService — Pure KML Generation](#kmlservice--pure-kml-generation)
- [SSHService — Transport Layer](#sshservice--transport-layer)
- [EarthquakeService — API Integration Example](#earthquakeservice--api-integration-example)
- [SocketService — WebSocket Client](#socketservice--websocket-client)

---

## LGService — Orchestration Facade

**File:** `flutter_client/lib/services/lg_service.dart`  
**Extends:** `ChangeNotifier` — registered in `MultiProvider` in `main.dart`  
**Dependencies:** `SSHService`, `KMLService`, `Config`

The single entry point for all Liquid Galaxy operations. Screens interact with this service only — never with SSH or KML directly.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `isConnected` | `bool` | Whether the SSH connection to the LG rig is active |

### Methods

#### `connect()`
Establishes an SSH connection to the LG master machine.

```dart
Future<void> connect({
  required String host,
  required int port,
  required String username,
  required String password,
})
```

**Behavior:** Delegates to `SSHService.connect()`, then calls `notifyListeners()`.

---

#### `disconnect()`
Closes the SSH connection.

```dart
void disconnect()
```

---

#### `flyTo()`
Flies the Google Earth camera to specified coordinates.

```dart
Future<void> flyTo({
  required double latitude,
  required double longitude,
  double altitude = 0,
  double heading = 0,
  double tilt = 60,
  double range = 1000,
})
```

**Behavior:** Generates a `<LookAt>` KML string via `KMLService.generateFlyTo()` and writes it to `/tmp/query.txt` on the rig.

---

#### `flyToHomeCity()` ⭐ Task 2
Flies Google Earth to the configured home city (default: Lleida, Spain).

```dart
Future<void> flyToHomeCity()
```

**Behavior:** Uses `Config.homeCityLat` / `Config.homeCityLng` with `range=5000`, `tilt=60`.

---

#### `search()`
Executes a search query on Google Earth.

```dart
Future<void> search(String query)
```

**Behavior:** Writes `search=$query` to `/tmp/query.txt`.

---

#### `sendKMLPlacemark()`
Sends a KML placemark to the rig.

```dart
Future<void> sendKMLPlacemark({
  required String name,
  required double latitude,
  required double longitude,
  String description = '',
})
```

**Behavior:** Generates placemark via `KMLService.generatePlacemark()`, uploads to `/var/www/html/placemark.kml`, registers in `kmls.txt`.

---

#### `sendLogo()` ⭐ Task 2
Displays the LG logo on the left slave screen.

```dart
Future<void> sendLogo()
```

**Behavior:** Generates a `<ScreenOverlay>` via `KMLService.generateScreenOverlay()`, wraps for slave, uploads to `logo_slave_{leftScreen}.kml`.

---

#### `sendPyramid()` ⭐ Task 2
Sends a 3D extruded pyramid (4 triangular faces + square base).

```dart
Future<void> sendPyramid({
  double? latitude,
  double? longitude,
  double height = 500,
})
```

**Behavior:** Defaults to `Config.homeCityLat` / `Config.homeCityLng` if coordinates are null. Generates via `KMLService.generatePyramid()`, uploads to `/var/www/html/pyramid.kml`.

---

#### `sendOrbit()`
Sends a 360° orbital camera tour.

```dart
Future<void> sendOrbit({
  required double latitude,
  required double longitude,
  double altitude = 1000,
  double range = 5000,
  double tilt = 60,
  int duration = 30,
})
```

**Behavior:** Generates a `<gx:Tour>` with 36 `<gx:FlyTo>` steps (10° each) via `KMLService.generateOrbit()`.

---

#### `cleanLogos()` ⭐ Task 2
Removes all overlay KML files from slave screens.

```dart
Future<void> cleanLogos()
```

**Behavior:** Iterates screens 2 through `Config.totalScreens`, writes empty KML to both `logo_slave_N.kml` and `kml_slave_N.kml`.

---

#### `cleanKMLs()` ⭐ Task 2
Clears all KML data and camera commands from the rig.

```dart
Future<void> cleanKMLs()
```

**Behavior:**
1. Empties `/tmp/query.txt`
2. Empties `/var/www/html/kmls.txt`
3. Writes empty KML to all slave screen files

---

#### `rebootLG()`
Reboots all machines in the rig.

```dart
Future<void> rebootLG()
```

**Behavior:** Iterates from `totalScreens` down to 1, executing `sudo reboot` on each machine.

---

#### `shutdownLG()`
Shuts down all machines in the rig.

```dart
Future<void> shutdownLG()
```

---

#### `executeRaw()`
Executes an arbitrary SSH command on the LG master.

```dart
Future<String> executeRaw(String command)
```

**Returns:** The stdout output of the command.

---

#### `dispose()`
Closes the SSH connection and releases resources.

```dart
@override
void dispose()
```

**Behavior:** Calls `_sshService.dispose()`, then `super.dispose()`.

---

## KMLService — Pure KML Generation

**File:** `flutter_client/lib/services/kml_service.dart`  
**Design:** Pure functions only — no imports, no I/O, no state, no side effects. Fully testable in isolation.

### Methods

#### `generatePlacemark()`
Generates a KML `<Placemark>` with a `<Point>`.

```dart
String generatePlacemark({
  required String name,
  required double latitude,
  required double longitude,
  String description = '',
  double altitude = 0,
})
```

**Returns:** Complete KML document string.

---

#### `generateScreenOverlay()`
Generates a KML `<ScreenOverlay>` for logo placement.

```dart
String generateScreenOverlay({
  required String name,
  required String imageUrl,
  double overlayX = 0,
  double overlayY = 1,
  double screenX = 0.02,
  double screenY = 0.95,
  double sizeX = 0,
  double sizeY = 0.1,
})
```

**Usage:** Used by `LGService.sendLogo()` to display the app logo on slave screens.

---

#### `generateLineString()`
Generates a KML `<LineString>` for drawing paths.

```dart
String generateLineString({
  required String name,
  required List<Map<String, double>> coordinates,
  String color = 'ff0000ff',
  double width = 3,
})
```

**`coordinates`** — List of maps with keys: `longitude`, `latitude`, `altitude`.

---

#### `generateOrbit()`
Generates a `<gx:Tour>` for a 360° orbital camera tour.

```dart
String generateOrbit({
  required double latitude,
  required double longitude,
  double altitude = 1000,
  double range = 5000,
  double tilt = 60,
  int duration = 30,
})
```

**Behavior:** Creates 36 `<gx:FlyTo>` waypoints at 10° intervals around the target point.

---

#### `generatePyramid()`
Generates a 3D extruded pyramid (4 triangular faces + square base).

```dart
String generatePyramid({
  required double latitude,
  required double longitude,
  String name = '3D Pyramid',
  double height = 500,
  double baseSize = 0.002,
  String color = 'ff0088ff',
})
```

**Returns:** KML with 5 Placemarks: 4 triangular `<Polygon>` faces and 1 square base polygon.

**Coordinate note:** `baseSize` is in degrees (0.002° ≈ 222 meters).

---

#### `generateFlyTo()`
Generates the `flytoview=<LookAt>...` string for camera control.

```dart
String generateFlyTo({
  required double latitude,
  required double longitude,
  double altitude = 0,
  double heading = 0,
  double tilt = 60,
  double range = 1000,
})
```

**Returns:** The `flytoview=` prefixed LookAt string (written to `/tmp/query.txt`).

---

#### `generateEmptyKml()`
Generates an empty KML document.

```dart
String generateEmptyKml()
```

**Usage:** Used by `cleanLogos()` and `cleanKMLs()` to clear slave screen content.

---

#### `wrapForSlave()`
Wraps KML content for a specific slave screen.

```dart
String wrapForSlave(String kmlContent, int slaveNumber)
```

---

## SSHService — Transport Layer

**File:** `flutter_client/lib/services/ssh_service.dart`  
**Dependencies:** `dartssh2`

Owns the SSH connection lifecycle. Handles all command execution and SFTP file transfers.

### ConnectionStatus Enum

```dart
enum ConnectionStatus { disconnected, connecting, connected, error }
```

Defined in this file (re-exported from `models/connection_status.dart` for backward compatibility).

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `status` | `ConnectionStatus` | Current connection state |
| `isConnected` | `bool` | `true` if `_client != null && status == connected` |

### Methods

#### `connect()`
Establishes an SSH connection.

```dart
Future<void> connect({
  required String host,
  required int port,
  required String username,
  required String password,
})
```

**Behavior:** Uses `SSHSocket.connect()` with 10-second timeout. Authenticates with password.

---

#### `disconnect()`
Closes the SSH session.

```dart
void disconnect()
```

---

#### `dispose()`
Alias for `disconnect()` — lifecycle management.

```dart
void dispose()
```

---

#### `execute()`
Executes a shell command on the LG master.

```dart
Future<String> execute(String command)
```

**Throws:** `StateError` if not connected (no silent error swallowing).  
**Returns:** stdout output as `String`.

---

#### `uploadKML()`
Uploads a KML file to the rig via SFTP.

```dart
Future<void> uploadKML(String content, String filename)
```

**Behavior:**
1. Attempts SFTP upload to `/var/www/html/$filename`
2. Falls back to `printf` via SSH if SFTP fails

---

#### `downloadFile()`
Downloads a file from the rig via SFTP.

```dart
Future<String> downloadFile(String remotePath)
```

**Returns:** File contents as `String`.

---

## EarthquakeService — API Integration Example

**File:** `flutter_client/lib/services/earthquake_service.dart`  
**Dependencies:** `http`, `dart:convert`

Demonstrates the **API → Model → KML → SSH** data pipeline pattern using real USGS data.

### Methods

#### `fetchRecentEarthquakes()`

```dart
Future<List<Map<String, dynamic>>> fetchRecentEarthquakes({
  double minMagnitude = 4.0,
  int limit = 20,
})
```

**Data source:** `https://earthquake.usgs.gov/fdsnws/event/1/query` (GeoJSON format)

**Returns:** List of maps with keys:

| Key | Type | Description |
|-----|------|-------------|
| `title` | `String` | Event title |
| `magnitude` | `double` | Richter magnitude |
| `place` | `String` | Location description |
| `time` | `int` | Unix timestamp (ms) |
| `longitude` | `double` | Longitude |
| `latitude` | `double` | Latitude |
| `depth` | `double` | Depth in km |
| `url` | `String` | USGS detail page |

**Usage pattern:**
```dart
final quakes = await EarthquakeService().fetchRecentEarthquakes(minMagnitude: 4.0);
for (final q in quakes) {
  final kml = kmlService.generatePlacemark(
    name: q['title'],
    latitude: q['latitude'],
    longitude: q['longitude'],
  );
  await sshService.uploadKML(kml, 'earthquake_${q['time']}.kml');
}
```

---

## SocketService — WebSocket Client

**File:** `flutter_client/lib/services/socket_service.dart`  
**Dependencies:** `web_socket_channel`

Real-time bidirectional communication with the Node.js companion server.

### Properties

| Property | Type | Description |
|----------|------|-------------|
| `messages` | `Stream<String>` | Broadcast stream of incoming messages |
| `isConnected` | `bool` | Whether the WebSocket channel is open |

### Methods

#### `connect()`

```dart
Future<void> connect(String url)
```

**Example:** `socketService.connect('ws://localhost:3000')`

---

#### `send()`

```dart
void send(String message)
```

---

#### `disconnect()`

```dart
void disconnect()
```

---

#### `dispose()`

```dart
void dispose()
```

**Behavior:** Disconnects the WebSocket and closes the internal `StreamController`.

---

## Quick Reference — All Methods

| Service | Method | Task 2? |
|---------|--------|---------|
| **LGService** | `connect()` | |
| | `disconnect()` | |
| | `flyTo()` | |
| | `flyToHomeCity()` | ⭐ |
| | `search()` | |
| | `sendKMLPlacemark()` | |
| | `sendLogo()` | ⭐ |
| | `sendPyramid()` | ⭐ |
| | `sendOrbit()` | |
| | `cleanLogos()` | ⭐ |
| | `cleanKMLs()` | ⭐ |
| | `rebootLG()` | |
| | `shutdownLG()` | |
| | `executeRaw()` | |
| | `dispose()` | |
| **KMLService** | `generatePlacemark()` | |
| | `generateScreenOverlay()` | |
| | `generateLineString()` | |
| | `generateOrbit()` | |
| | `generatePyramid()` | |
| | `generateFlyTo()` | |
| | `generateEmptyKml()` | |
| | `wrapForSlave()` | |
| **SSHService** | `connect()` | |
| | `disconnect()` | |
| | `dispose()` | |
| | `execute()` | |
| | `uploadKML()` | |
| | `downloadFile()` | |
| **EarthquakeService** | `fetchRecentEarthquakes()` | |
| **SocketService** | `connect()` | |
| | `send()` | |
| | `disconnect()` | |
| | `dispose()` | |
