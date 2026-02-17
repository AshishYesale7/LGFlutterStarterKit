import 'package:flutter/material.dart';
import 'package:flutter_client/services/ssh_service.dart';
import 'package:flutter_client/services/kml_service.dart';
import 'package:flutter_client/config.dart';

/// High-level service for interacting with the Liquid Galaxy rig.
///
/// Wraps SSHService and KMLService to provide a clean API for
/// common LG operations: fly to, orbit, send KML, reboot, etc.
class LGService extends ChangeNotifier {
  final SSHService _sshService = SSHService();
  final KMLService _kmlService = KMLService();

  bool get isConnected => _sshService.isConnected;

  /// Connect to the LG master.
  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    await _sshService.connect(
      host: host,
      port: port,
      username: username,
      password: password,
    );
    notifyListeners();
  }

  /// Disconnect from the LG rig.
  void disconnect() {
    _sshService.disconnect();
    notifyListeners();
  }

  /// Fly to a specific location on Google Earth.
  Future<void> flyTo({
    required double latitude,
    required double longitude,
    double altitude = 1000,
    double heading = 0,
    double tilt = 60,
    double range = 1000,
  }) async {
    final flytoCmd =
        'echo "flytoview=<LookAt>'
        '<longitude>$longitude</longitude>'
        '<latitude>$latitude</latitude>'
        '<altitude>$altitude</altitude>'
        '<heading>$heading</heading>'
        '<tilt>$tilt</tilt>'
        '<range>$range</range>'
        '<altitudeMode>relativeToGround</altitudeMode>'
        '</LookAt>" > /tmp/query.txt';
    await _sshService.execute(flytoCmd);
  }

  /// Execute a search query on Google Earth.
  Future<void> search(String query) async {
    await _sshService.execute('echo "search=$query" > /tmp/query.txt');
  }

  /// Send a KML placemark to the LG rig.
  Future<void> sendKMLPlacemark({
    required String name,
    required double latitude,
    required double longitude,
    String description = '',
  }) async {
    final kml = _kmlService.generatePlacemark(
      name: name,
      latitude: latitude,
      longitude: longitude,
      description: description,
    );
    await _sshService.uploadKML(kml, 'placemark.kml');
    // Load via kmls.txt
    await _sshService.execute(
      'echo "http://localhost/placemark.kml" > /var/www/html/kmls.txt',
    );
  }

  /// Show the project logo on the left-most slave screen.
  Future<void> showLogo() async {
    final logoKML = _kmlService.generateScreenOverlay(
      name: 'Logo',
      imageUrl: 'https://liquidgalaxy.eu/wp-content/uploads/2024/01/LG-logo.png',
    );
    final slaveScreen = Config.leftScreen;
    await _sshService.uploadKML(logoKML, 'logo_slave_$slaveScreen.kml');
  }

  /// Clean all KML from the rig.
  Future<void> cleanLogo() async {
    await _sshService.execute('echo "" > /tmp/query.txt');
    await _sshService.execute('echo "" > /var/www/html/kmls.txt');
    // Clear slave KMLs
    for (int i = 2; i <= Config.totalScreens; i++) {
      await _sshService.execute('echo "" > /var/www/html/kml_slave_$i.kml');
    }
  }

  /// Reboot all machines in the LG rig.
  Future<void> rebootLG() async {
    for (int i = Config.totalScreens; i >= 1; i--) {
      final machineHost = 'lg$i';
      try {
        await _sshService.execute(
          'sshpass -p ${Config.lgPassword} ssh -o StrictHostKeyChecking=no '
          '${Config.lgUser}@$machineHost "sudo reboot"',
        );
      } catch (_) {
        // Machine may disconnect immediately on reboot
      }
    }
  }

  /// Shut down all machines in the LG rig.
  Future<void> shutdownLG() async {
    for (int i = Config.totalScreens; i >= 1; i--) {
      final machineHost = 'lg$i';
      try {
        await _sshService.execute(
          'sshpass -p ${Config.lgPassword} ssh -o StrictHostKeyChecking=no '
          '${Config.lgUser}@$machineHost "sudo poweroff"',
        );
      } catch (_) {
        // Machine may disconnect immediately on shutdown
      }
    }
  }

  /// Execute a raw SSH command.
  Future<String> executeRaw(String command) async {
    return await _sshService.execute(command);
  }
}
