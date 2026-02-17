import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_client/config.dart';

/// Manages LG connection settings with persistence via SharedPreferences.
class SettingsProvider extends ChangeNotifier {
  String _host = Config.lgHost;
  int _port = Config.lgPort;
  String _username = Config.lgUser;
  String _password = Config.lgPassword;
  int _totalScreens = Config.totalScreens;

  String get host => _host;
  int get port => _port;
  String get username => _username;
  String get password => _password;
  int get totalScreens => _totalScreens;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _host = prefs.getString('lg_host') ?? Config.lgHost;
    _port = prefs.getInt('lg_port') ?? Config.lgPort;
    _username = prefs.getString('lg_user') ?? Config.lgUser;
    _password = prefs.getString('lg_password') ?? Config.lgPassword;
    _totalScreens = prefs.getInt('lg_screens') ?? Config.totalScreens;
    notifyListeners();
  }

  Future<void> updateSettings({
    String? host,
    int? port,
    String? username,
    String? password,
    int? totalScreens,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (host != null) {
      _host = host;
      await prefs.setString('lg_host', host);
    }
    if (port != null) {
      _port = port;
      await prefs.setInt('lg_port', port);
    }
    if (username != null) {
      _username = username;
      await prefs.setString('lg_user', username);
    }
    if (password != null) {
      _password = password;
      await prefs.setString('lg_password', password);
    }
    if (totalScreens != null) {
      _totalScreens = totalScreens;
      await prefs.setInt('lg_screens', totalScreens);
    }

    notifyListeners();
  }

  Future<void> resetToDefaults() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lg_host');
    await prefs.remove('lg_port');
    await prefs.remove('lg_user');
    await prefs.remove('lg_password');
    await prefs.remove('lg_screens');

    _host = Config.lgHost;
    _port = Config.lgPort;
    _username = Config.lgUser;
    _password = Config.lgPassword;
    _totalScreens = Config.totalScreens;

    notifyListeners();
  }
}
