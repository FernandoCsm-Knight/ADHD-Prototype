import 'package:flutter/material.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.viewModeController});

  static const routeName = '/settings';

  final ViewModeController viewModeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButton<ThemeMode>(
          value: viewModeController.themeMode,
          onChanged: viewModeController.updateThemeMode,
          items: const [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light Theme'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark Theme'),
            )
          ],
        ),
      ),
    );
  }
}
