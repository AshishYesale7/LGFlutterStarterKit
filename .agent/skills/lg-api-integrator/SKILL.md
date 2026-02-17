---
name: lg-api-integrator
description: Integrate external APIs with LG Flutter apps
---

# LG API Integrator

Integrates external REST and WebSocket APIs with Liquid Galaxy apps.

## API Integration Pattern
```dart
class ApiService {
  final String baseUrl;
  final http.Client _client = http.Client();

  Future<T> get<T>(String endpoint, T Function(dynamic) parser) async {
    final response = await _client.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      return parser(jsonDecode(response.body));
    }
    throw ApiException('GET $endpoint failed: ${response.statusCode}');
  }
}
```

## Common LG APIs
| API | Data | Use Case |
|-----|------|----------|
| USGS Earthquake | Seismic events | Real-time earthquake viz |
| OpenWeather | Weather data | Weather overlays |
| NASA APOD | Space images | Ground overlays |
| OpenStreetMap | Map tiles | Custom overlays |

## Error Handling
- Timeout: 10s default, configurable per endpoint
- Retry: 3 attempts with exponential backoff
- Cache: Store last successful response
- Offline: Use cached data when network unavailable
