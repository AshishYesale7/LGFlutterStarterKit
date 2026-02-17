# KML Standards

## Required Structure
```xml
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>...</name>
    <!-- content -->
  </Document>
</kml>
```

## Coordinate Order
**CRITICAL**: KML coordinate order is `longitude,latitude,altitude` (NOT lat,lng!)

## Validation
- All generated KML must be valid XML
- Test with `xml` package parse
- Validate coordinate ranges: lat [-90,90], lng [-180,180]

## Screen Assignment
- Master (lg1): Main content via `/tmp/query.txt`
- Slaves: Overlays via `/var/www/html/kml_slave_<n>.kml`

## File Naming
- Placemarks: `placemark_<name>.kml`
- Overlays: `overlay_<name>.kml`  
- Tours: `tour_<name>.kml`
- Slave content: `kml_slave_<n>.kml`
