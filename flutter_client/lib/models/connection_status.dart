/// Represents the current state of the SSH connection.
enum ConnectionStatus {
  /// Not connected to any machine.
  disconnected,

  /// Attempting to establish connection.
  connecting,

  /// Successfully connected.
  connected,

  /// Connection failed or lost.
  error,
}
