---
name: lg-kml-craftsman
description: Expert KML creation for Liquid Galaxy displays
---

# LG KML Craftsman

Expert-level KML creation for Liquid Galaxy multi-screen displays.

## KML Elements
| Element | Use Case |
|---------|----------|
| `Placemark` | Points of interest |
| `ScreenOverlay` | Logos, HUD elements on slave screens |
| `LineString` | Paths, routes, trajectories |
| `Polygon` | Area boundaries, regions |
| `GroundOverlay` | Images mapped to geography |
| `NetworkLink` | Dynamic content from server |
| `gx:Tour` | Animated camera tours |

## KML Best Practices
1. Always include XML declaration and KML namespace
2. Use CDATA for HTML descriptions
3. Validate coordinates: `longitude,latitude,altitude` (note order!)
4. Use `altitudeMode` appropriately (clampToGround, relativeToGround, absolute)
5. Keep file sizes small for fast loading

## Multi-Screen KML
- Master screen: Main content via `/tmp/query.txt`
- Slave screens: Overlays via `/var/www/html/kml_slave_<n>.kml`
- Dynamic: NetworkLinks refresh from `/var/www/html/`

## Tour Writing
```xml
<gx:Tour>
  <gx:Playlist>
    <gx:FlyTo>
      <gx:duration>3</gx:duration>
      <gx:flyToMode>smooth</gx:flyToMode>
      <LookAt>...</LookAt>
    </gx:FlyTo>
  </gx:Playlist>
</gx:Tour>
```
