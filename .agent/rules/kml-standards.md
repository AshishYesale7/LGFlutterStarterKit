# KML Standards for Liquid Galaxy

## KML Version
- Always use **KML 2.2** with Google Earth extensions (`gx:` namespace).
- XML declaration: `<?xml version="1.0" encoding="UTF-8"?>`
- Root element: `<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2">`

## Coordinate Order
**CRITICAL**: KML coordinates are `longitude,latitude,altitude` — NOT `lat,lon`.
- Dart parameter order should always be `latitude, longitude` (user-facing).
- Convert to `longitude,latitude` ONLY in the KML output string.
- This is the #1 source of bugs in LG apps. Always double-check coordinate order.

## Altitude Modes
| Mode | Use Case |
|---|---|
| `clampToGround` | Default, ignores altitude — pins to ground |
| `relativeToGround` | Altitude above terrain — use for elevated placemarks |
| `absolute` | Altitude above sea level — use for satellites, ISS |

## KML Constructs Used in LG Apps

### Placemarks
- Use for data points (earthquakes, locations, etc.).
- Always include `<name>`, `<description>`, and `<Point><coordinates>`.
- Use `<![CDATA[]]>` for HTML in descriptions.

### FlyTo
- Uses `gx:FlyTo` with `gx:duration` and `gx:flyToMode`.
- Two modes: `smooth` (recommended) and `bounce`.
- Duration: 2–4 seconds for nearby, 5–8 for long-distance.

### LookAt
- Camera position: `<latitude>`, `<longitude>`, `<altitude>`, `<heading>`, `<tilt>`, `<range>`.
- `tilt`: 0 = straight down, 90 = horizontal. Default: 60.
- `range`: distance from point to camera in meters.
- `heading`: 0 = North, 90 = East, 180 = South, 270 = West.

### Tours (gx:Tour)
- Use `gx:Playlist` with a sequence of `gx:FlyTo` steps.
- For orbit: 36 steps × 10° heading increment = full 360° circle.
- Step duration: 1.0–1.5 seconds for smooth orbit.
- Play via: `echo "playtour=TourName" > /tmp/query.txt`
- Stop via: `echo "exittour=true" > /tmp/query.txt`

### ScreenOverlay
- Used for logo placement on slave screens.
- Position with `<overlayXY>` and `<screenXY>` using fraction units.
- Size with `<size>` using fraction units for responsive scaling.
- Typical logo: bottom-left corner, 30% width, 15% height.

### Balloons
- Info popups anchored to placemarks.
- Use `<BalloonStyle>` in `<Style>` for custom HTML content.
- Activate with `<gx:balloonVisibility>1</gx:balloonVisibility>`.
- Background: dark theme (`ff1a1a2e`) with white text for LG visibility.

## Performance Rules
1. **Limit placemarks**: Max 500 per KML document. Paginate or cluster beyond that.
2. **Minimize file size**: Strip unnecessary whitespace in production KML.
3. **Clean up**: Always clear KML before sending new data. Never accumulate.
4. **Batch updates**: Send one KML document with all placemarks, not one per placemark.
5. **Use NetworkLink** for auto-refreshing data (poll interval: 5–30 seconds).

## XML Escaping
Always escape these characters in text content:
- `&` → `&amp;`
- `<` → `&lt;`
- `>` → `&gt;`
- `"` → `&quot;`
- `'` → `&apos;`

Use `<![CDATA[]]>` for HTML content in descriptions to avoid escaping issues.

## Testing
- Validate KML at: https://developers.google.com/kml/schema/kml22gx.xsd
- Test in Google Earth Pro desktop before sending to rig.
- Use `flutter test` to validate KML output strings match expected XML.
