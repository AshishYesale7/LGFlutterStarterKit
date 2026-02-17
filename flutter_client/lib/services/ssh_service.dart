import 'dart:async';
import 'dart:typed_data';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_client/models/connection_status.dart';

/// Service for handling SSH communication with the Liquid Galaxy rig.
class SSHService {
  SSHClient? _client;
  
  /// Current connection status
  ConnectionStatus _status = ConnectionStatus.disconnected;
  ConnectionStatus get status => _status;
  
  /// Whether a connection is active.
  bool get isConnected => _client != null && _status == ConnectionStatus.connected;

  /// Connect to the LG master machine via SSH.
  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    _status = ConnectionStatus.connecting;
    try {
      final socket = await SSHSocket.connect(host, port,
          timeout: const Duration(seconds: 10));
      _client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );
      _status = ConnectionStatus.connected;
    } catch (e) {
      _status = ConnectionStatus.error;
      _client = null;
      rethrow;
    }
  }

  /// Disconnect from the LG rig.
  void disconnect() {
    _client?.close();
    _client = null;
    _status = ConnectionStatus.disconnected;
  }

  /// Execute a shell command on the LG master.
  Future<String> execute(String command) async {
    if (_client == null) return '';
    try {
      final result = await _client!.run(command);
      return String.fromCharCodes(result);
    } catch (e) {
      return 'Error: $e';
    }
  }

  /// Upload a file to the LG master via SFTP.
  Future<void> uploadKML(String content, String filename) async {
    if (_client == null) return;

    try {
      final sftp = await _client!.sftp();
      final file = await sftp.open('/var/www/html/$filename', mode: SftpFileOpenMode.write | SftpFileOpenMode.create | SftpFileOpenMode.truncate);
      await file.write(Stream.value(Uint8List.fromList(content.codeUnits)));
      await file.close();
    } catch (e) {
      print('SFTP Error: $e');
      // Fallback: use echo if SFTP fails (not recommended for large files but good for simple text)
      await execute("echo '$content' > /var/www/html/$filename");
    }
  }

  /// Download a file from the LG master via SFTP.
  Future<String> downloadFile(String remotePath) async {
    if (_client == null) return '';
    try {
      final sftp = await _client!.sftp();
      final file = await sftp.open(remotePath, mode: SftpFileOpenMode.read);
      final data = await file.readBytes();
      await file.close();
      return String.fromCharCodes(data);
    } catch (e) {
      return 'Error: $e';
    }
  }
}
