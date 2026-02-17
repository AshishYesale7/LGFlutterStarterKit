---
name: lg-kml-writer
description: Write KML files for various geographic visualizations
---

# LG KML Writer

Writes KML files for geographic data visualization on Liquid Galaxy.

## Supported Outputs
1. **Point Placemarks**: Single location markers
2. **Multi-point**: Collection of related placemarks
3. **Paths**: LineStrings connecting waypoints
4. **Areas**: Polygons defining regions
5. **Overlays**: Screen and ground overlays
6. **Tours**: Animated flythrough sequences

## Data-to-KML Pipeline
```
Raw Data → Parse → Validate → Generate KML → Upload to LG
```

## Coordinate Validation
- Latitude: -90 to 90
- Longitude: -180 to 180
- Altitude: >= 0
- KML order: `longitude,latitude,altitude` (NOT lat,lng!)

## Style Templates
```xml
<Style id="default">
  <IconStyle><color>ff0000ff</color></IconStyle>
  <LineStyle><color>ff00ff00</color><width>2</width></LineStyle>
  <PolyStyle><color>7f0000ff</color></PolyStyle>
</Style>
```
