import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_client/providers/settings_provider.dart';
import 'package:flutter_client/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ─── Connection Settings ────────────────────────────────────
          Text(
            'Connection',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow('Host', settings.host),
                  _buildInfoRow('Port', settings.port.toString()),
                  _buildInfoRow('Username', settings.username),
                  _buildInfoRow('Screens', settings.totalScreens.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ─── Theme Settings ─────────────────────────────────────────
          Text(
            'Appearance',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                // ignore: deprecated_member_use
                RadioListTile<ThemeMode>(
                  title: const Text('System'),
                  value: ThemeMode.system,
                  // ignore: deprecated_member_use
                  groupValue: themeProvider.themeMode,
                  // ignore: deprecated_member_use
                  onChanged: (mode) => themeProvider.setThemeMode(mode!),
                ),
                // ignore: deprecated_member_use
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  // ignore: deprecated_member_use
                  groupValue: themeProvider.themeMode,
                  // ignore: deprecated_member_use
                  onChanged: (mode) => themeProvider.setThemeMode(mode!),
                ),
                // ignore: deprecated_member_use
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  // ignore: deprecated_member_use
                  groupValue: themeProvider.themeMode,
                  // ignore: deprecated_member_use
                  onChanged: (mode) => themeProvider.setThemeMode(mode!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ─── Reset ──────────────────────────────────────────────────
          OutlinedButton.icon(
            onPressed: () async {
              await settings.resetToDefaults();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings reset to defaults')),
                );
              }
            },
            icon: const Icon(Icons.restore),
            label: const Text('Reset to Defaults'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
