/// Service for generating KML (Keyhole Markup Language) documents.
///
/// KML is the format used by Google Earth to display geographic data.
/// This service provides methods to create common KML elements.
class KMLService {
  /// Generate a simple KML placemark.
  String generatePlacemark({
    required String name,
    required double latitude,
    required double longitude,
    String description = '',
    double altitude = 0,
  }) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>$name</name>
    <Placemark>
      <name>$name</name>
      <description>$description</description>
      <Point>
        <coordinates>$longitude,$latitude,$altitude</coordinates>
      </Point>
    </Placemark>
  </Document>
</kml>''';
  }

  /// Generate a KML screen overlay (used for logos on slave screens).
  String generateScreenOverlay({
    required String name,
    required String imageUrl,
    double overlayX = 0,
    double overlayY = 1,
    double screenX = 0.02,
    double screenY = 0.95,
    double sizeX = 0,
    double sizeY = 0.1,
  }) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>$name</name>
    <ScreenOverlay>
      <name>$name</name>
      <Icon>
        <href>$imageUrl</href>
      </Icon>
      <overlayXY x="$overlayX" y="$overlayY" xunits="fraction" yunits="fraction"/>
      <screenXY x="$screenX" y="$screenY" xunits="fraction" yunits="fraction"/>
      <size x="$sizeX" y="$sizeY" xunits="fraction" yunits="fraction"/>
    </ScreenOverlay>
  </Document>
</kml>''';
  }

  /// Generate a KML LineString (path/trajectory).
  String generateLineString({
    required String name,
    required List<Map<String, double>> coordinates,
    String color = 'ff0000ff',
    double width = 3,
  }) {
    final coordString = coordinates
        .map((c) => '${c['lng']},${c['lat']},${c['alt'] ?? 0}')
        .join('\n        ');

    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>$name</name>
    <Style>
      <LineStyle>
        <color>$color</color>
        <width>$width</width>
      </LineStyle>
    </Style>
    <Placemark>
      <name>$name</name>
      <LineString>
        <tessellate>1</tessellate>
        <coordinates>
        $coordString
        </coordinates>
      </LineString>
    </Placemark>
  </Document>
</kml>''';
  }

  /// Generate a KML orbit (camera tour around a point).
  String generateOrbit({
    required double latitude,
    required double longitude,
    double altitude = 1000,
    double range = 5000,
    double tilt = 60,
    int duration = 30,
  }) {
    final buffer = StringBuffer();
    buffer.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.writeln('<kml xmlns="http://www.opengis.net/kml/2.2"');
    buffer.writeln(' xmlns:gx="http://www.google.com/kml/ext/2.2">');
    buffer.writeln('<Document>');
    buffer.writeln('  <name>Orbit</name>');
    buffer.writeln('  <gx:Tour>');
    buffer.writeln('    <name>Orbit</name>');
    buffer.writeln('    <gx:Playlist>');

    // Generate LookAt positions around 360 degrees
    for (int i = 0; i <= 360; i += 10) {
      buffer.writeln('      <gx:FlyTo>');
      buffer.writeln('        <gx:duration>${duration / 36}</gx:duration>');
      buffer.writeln('        <gx:flyToMode>smooth</gx:flyToMode>');
      buffer.writeln('        <LookAt>');
      buffer.writeln('          <longitude>$longitude</longitude>');
      buffer.writeln('          <latitude>$latitude</latitude>');
      buffer.writeln('          <altitude>$altitude</altitude>');
      buffer.writeln('          <heading>$i</heading>');
      buffer.writeln('          <tilt>$tilt</tilt>');
      buffer.writeln('          <range>$range</range>');
      buffer.writeln('          <altitudeMode>relativeToGround</altitudeMode>');
      buffer.writeln('        </LookAt>');
      buffer.writeln('      </gx:FlyTo>');
    }

    buffer.writeln('    </gx:Playlist>');
    buffer.writeln('  </gx:Tour>');
    buffer.writeln('</Document>');
    buffer.writeln('</kml>');

    return buffer.toString();
  }

  /// Wrap KML content for a specific slave screen.
  String wrapForSlave(String kmlContent, int slaveNumber) {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>Slave $slaveNumber</name>
    $kmlContent
  </Document>
</kml>''';
  }
}
