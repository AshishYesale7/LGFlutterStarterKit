# Node.js Companion Server

> Optional Express + WebSocket server for API proxying, KML generation, and real-time communication.

---

## Table of Contents

- [Overview](#overview)
- [Setup](#setup)
- [REST API Endpoints](#rest-api-endpoints)
- [WebSocket API](#websocket-api)
- [Dependencies](#dependencies)
- [Configuration](#configuration)
- [Integration with Flutter](#integration-with-flutter)

---

## Overview

The Node.js companion server is **optional** — the Flutter app communicates directly with the LG rig via SSH and works independently. The server provides:

- **API proxying** — Fetch external data server-side (avoids CORS issues, reduces client complexity)
- **KML generation** — Server-side KML creation for complex use cases
- **WebSocket** — Real-time bidirectional communication between Flutter and server
- **Sample data** — Built-in city data for testing without external APIs

**Location:** `server/`

---

## Setup

### Quick Start

```bash
cd server
npm install
npm start
```

Output: `Server running on port 3000`

### Development Mode (Auto-Reload)

```bash
npm run dev
```

Uses `nodemon` to auto-restart on file changes.

### Custom Port

```bash
PORT=8080 npm start
```

### Verify

```bash
curl http://localhost:3000/health
# → { "status": "healthy", "uptime": 12.345 }
```

---

## REST API Endpoints

### `GET /`

Health check.

**Response:**
```json
{
  "status": "ok",
  "server": "LG Starter Kit Node Server"
}
```

---

### `GET /health`

Server uptime and health status.

**Response:**
```json
{
  "status": "healthy",
  "uptime": 123.456
}
```

---

### `GET /api/status`

Server information and available endpoints.

**Response:**
```json
{
  "server": "LG Starter Kit Node Server",
  "version": "1.0.0",
  "endpoints": ["/", "/health", "/api/status", "/api/kml/generate", "/api/data"]
}
```

---

### `POST /api/kml/generate`

Generate KML content server-side.

**Request body:**
```json
{
  "type": "placemark",
  "lat": 41.6176,
  "lng": 0.6200,
  "name": "Lleida",
  "description": "Home city"
}
```

**Supported types:** `placemark`

**Response:**
```json
{
  "success": true,
  "kml": "<?xml version=\"1.0\" encoding=\"UTF-8\"?>..."
}
```

---

### `GET /api/data`

Sample city data for testing.

**Response:**
```json
{
  "data": [
    {
      "name": "Lleida",
      "latitude": 41.6176,
      "longitude": 0.6200,
      "description": "Historic city in Catalonia"
    },
    {
      "name": "Barcelona",
      "latitude": 41.3874,
      "longitude": 2.1686,
      "description": "Capital of Catalonia"
    },
    {
      "name": "Madrid",
      "latitude": 40.4168,
      "longitude": -3.7038,
      "description": "Capital of Spain"
    }
  ]
}
```

---

## WebSocket API

**URL:** `ws://localhost:3000`

### Connection

```
Client connects → Server sends: "Welcome to LG Starter Kit WebSocket Server"
```

### Message Echo

```
Client sends: "Hello"
Server responds: "Server received: Hello (timestamp: 2026-02-18T10:30:00.000Z)"
```

### Events

| Event | Description |
|-------|-------------|
| `connection` | Client connected — logged to console |
| `message` | Message received — echoed with timestamp |
| `close` | Client disconnected — logged to console |

### Flutter Integration

```dart
final socketService = SocketService();
await socketService.connect('ws://localhost:3000');

socketService.messages.listen((msg) {
  debugPrint('Server: $msg');
});

socketService.send('Hello from Flutter');
```

---

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `express` | ^4.18.2 | HTTP framework |
| `cors` | ^2.8.5 | Cross-origin request handling |
| `ws` | ^8.16.0 | WebSocket server |
| `nodemon` (dev) | ^3.0.2 | Auto-reload during development |

---

## Configuration

| Variable | Default | Override |
|----------|---------|---------|
| `PORT` | `3000` | `PORT=8080 npm start` |

The server listens on all interfaces by default.

---

## Integration with Flutter

### HTTP Client

The Flutter app uses the `http` package to call REST endpoints:

```dart
import 'package:http/http.dart' as http;

final response = await http.get(Uri.parse('${Config.serverUrl}/api/data'));
final cities = jsonDecode(response.body)['data'];
```

### WebSocket Client

The Flutter app uses `SocketService` (wraps `web_socket_channel`):

```dart
final socket = SocketService();
await socket.connect(Config.serverUrl.replaceFirst('http', 'ws'));
socket.messages.listen((msg) => handleMessage(msg));
socket.send(jsonEncode({'type': 'request', 'data': 'earthquakes'}));
```

### Config Reference

The server URL is defined in `flutter_client/lib/config.dart`:

```dart
static const String serverUrl = 'http://localhost:3000';
```

Update this to match your server deployment.
