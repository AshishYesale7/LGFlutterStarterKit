---
name: lg-kml-writer
description: 'Writes KML files for geographic visualizations on Liquid Galaxy — placemarks, tours, overlays, polygons, and balloons following Google KML standards.'
---

# LG KML Writer

Writes KML files for geographic data visualization on Liquid Galaxy. This is the **foundation KML skill** — it handles standard KML elements. For artistic/advanced compositions, hand off to `lg-kml-craftsman`.

**Announce:** "KML Writer activated. Generating KML for [visualization type]."

## When to Invoke
- After `lg-data-pipeline` provides domain models with geo data.
- When building new visualization KML (placemarks, tours, overlays).
- Before `lg-ssh-controller` sends KML to the rig.

## Supported Outputs

1. **Point Placemarks**: Single location markers with icons and balloons
2. **Multi-point**: Collection of related placemarks in a Document
3. **Paths**: LineStrings connecting waypoints
4. **Areas**: Polygons defining regions with fill
5. **Screen Overlays**: Logo and legend overlays
6. **Ground Overlays**: Image overlays projected onto terrain
7. **Tours**: Animated flythrough sequences (`gx:Tour`)

## KML Structure Template

```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
     xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>{{document_name}}</name>
    <Style id="{{style_id}}">
      <IconStyle><color>{{aaBBGGRR}}</color></IconStyle>
      <LineStyle><color>{{aaBBGGRR}}</color><width>2</width></LineStyle>
      <PolyStyle><color>{{aaBBGGRR}}</color></PolyStyle>
    </Style>
    <!-- Placemarks, Tours, Overlays here -->
  </Document>
</kml>
```

## Data-to-KML Pipeline

```
Raw Data → Parse → Validate Coordinates → Generate KML Elements → Wrap in Document → Upload to LG
```

## Coordinate Validation — CRITICAL

| Field | Range | Common Bug |
|-------|-------|------------|
| Latitude | -90 to 90 | Swapped with longitude |
| Longitude | -180 to 180 | Swapped with latitude |
| Altitude | >= 0 | Negative values crash GE |
| **KML order** | `longitude,latitude,altitude` | **NOT lat,lng!** This is the #1 KML bug |

```dart
/// WRONG — most common KML bug
'<coordinates>$latitude,$longitude,0</coordinates>'

/// RIGHT — KML uses lon,lat,alt
'<coordinates>$longitude,$latitude,$altitude</coordinates>'
```

## Color Format — KML uses `aaBBGGRR`

```
aa = alpha (ff = opaque, 7f = 50% transparent)
BB = blue
GG = green
RR = red

Examples:
  ff0000ff  = opaque red
  ff00ff00  = opaque green
  ffff0000  = opaque blue
  7f00ff00  = 50% transparent green
```

**NOT** `#RRGGBB` like CSS/HTML. This is the #2 most common KML bug.

## KML Element Patterns

### Placemark with Balloon

```dart
String buildPlacemark({
  required String name,
  required String description,
  required double lat,
  required double lon,
  double alt = 0,
  String styleId = 'default',
}) => '''
<Placemark>
  <name>$name</name>
  <description><![CDATA[$description]]></description>
  <styleUrl>#$styleId</styleUrl>
  <Point>
    <altitudeMode>relativeToGround</altitudeMode>
    <coordinates>$lon,$lat,$alt</coordinates>
  </Point>
</Placemark>
''';
```

### FlyTo LookAt

```dart
String buildLookAt({
  required double lat,
  required double lon,
  double range = 1000,
  double tilt = 60,
  double heading = 0,
}) => '''
<LookAt>
  <longitude>$lon</longitude>
  <latitude>$lat</latitude>
  <range>$range</range>
  <tilt>$tilt</tilt>
  <heading>$heading</heading>
  <altitudeMode>relativeToGround</altitudeMode>
</LookAt>
''';
```

### Orbit Tour

```dart
String buildOrbit({
  required double lat,
  required double lon,
  double range = 5000,
  double tilt = 60,
  int steps = 36,
  double durationPerStep = 1.2,
}) {
  final buffer = StringBuffer();
  buffer.writeln('<gx:Tour><name>Orbit</name><gx:Playlist>');
  for (int i = 0; i < steps; i++) {
    final heading = i * (360.0 / steps);
    buffer.writeln('''
  <gx:FlyTo>
    <gx:duration>$durationPerStep</gx:duration>
    <gx:flyToMode>smooth</gx:flyToMode>
    <LookAt>
      <longitude>$lon</longitude>
      <latitude>$lat</latitude>
      <range>$range</range>
      <tilt>$tilt</tilt>
      <heading>$heading</heading>
      <altitudeMode>relativeToGround</altitudeMode>
    </LookAt>
  </gx:FlyTo>''');
  }
  buffer.writeln('</gx:Playlist></gx:Tour>');
  return buffer.toString();
}
```

### Screen Overlay (Logo)

```dart
String buildLogoOverlay({
  required String logoUrl,
  double overlayX = 0,
  double overlayY = 1,
  double sizeX = 0.15,
}) => '''
<ScreenOverlay>
  <name>App Logo</name>
  <Icon><href>$logoUrl</href></Icon>
  <overlayXY x="$overlayX" y="$overlayY" xunits="fraction" yunits="fraction"/>
  <screenXY x="0" y="1" xunits="fraction" yunits="fraction"/>
  <size x="$sizeX" y="0" xunits="fraction" yunits="fraction"/>
</ScreenOverlay>
''';
```

## Style Templates

```xml
<Style id="default">
  <IconStyle><color>ff0000ff</color></IconStyle>
  <LineStyle><color>ff00ff00</color><width>2</width></LineStyle>
  <PolyStyle><color>7f0000ff</color></PolyStyle>
</Style>
```

## KML Validation Checklist

- [ ] All coordinates use `longitude,latitude,altitude` order
- [ ] Colors use `aaBBGGRR` format (not `#RRGGBB`)
- [ ] XML entities are escaped (`&amp;`, `&lt;`, etc.)
- [ ] Total payload < 2 MB (LG performance limit)
- [ ] KML validates against schema (open in Google Earth Pro)
- [ ] `<Document>` wraps all elements
- [ ] CDATA used for HTML in `<description>` balloons

## ⛔️ Student Interaction — MANDATORY

**After generating KML, STOP and show the student:**
1. Open the generated KML in Google Earth Pro to verify it renders correctly.
2. Highlight the coordinate order (`lon,lat,alt`) and color format (`aaBBGGRR`).
3. Ask: *"If I swap latitude and longitude in this KML, where would the placemarks appear?"*
4. If the student cannot answer, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md) — KML & Google Earth topic.

**DO NOT move to the next KML element type** until the student understands coordinate order.

## Reference Links

- **KML Reference (Google)**: https://developers.google.com/kml/documentation/kmlreference
- **KML Tutorial**: https://developers.google.com/kml/documentation/kml_tut
- **gx:Tour documentation**: https://developers.google.com/kml/documentation/touring
- **Lucia's KML patterns**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **KML color reference**: https://developers.google.com/kml/documentation/kmlreference#colorstyle
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## Handoff

After KML generation → **lg-ssh-controller** (.agent/skills/lg-ssh-controller/SKILL.md) for rig upload, then **lg-code-reviewer** (.agent/skills/lg-code-reviewer/SKILL.md) for quality checks.

## 🔗 Skill Chain

After KML is generated, validated, and the student understands coordinate order and color format, **automatically offer the next stage**:

> *"KML is generated and validated! Now let's send it to the LG rig via SSH. Ready to see it on Google Earth? 🚀"*

If student says "ready" → activate `.agent/skills/lg-ssh-controller/SKILL.md`.
