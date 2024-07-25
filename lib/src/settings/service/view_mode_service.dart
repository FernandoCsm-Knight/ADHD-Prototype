import 'package:flutter/material.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewModeService {
  Future<ThemeMode> get themeMode async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt('themeMode') ?? ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', theme.index);
  }

  Future<ViewMode> get view async {
    final prefs = await SharedPreferences.getInstance();
    final viewIndex = prefs.getInt('view') ?? ViewMode.parent.index;
    return ViewMode.values[viewIndex];
  }

  Future<void> updateView(ViewMode view) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('view', view.index);
  }
}
