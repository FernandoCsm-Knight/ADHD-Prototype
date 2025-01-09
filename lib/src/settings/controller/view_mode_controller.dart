import 'package:flutter/material.dart';
import 'package:prototype/src/common/design/app_theme_data.dart';
import 'package:prototype/src/common/types/view_mode.dart';
import 'package:prototype/src/settings/service/view_mode_service.dart';

class ViewModeController with ChangeNotifier {
  final ViewModeService _viewModeService = ViewModeService();

  late ThemeMode _themeMode;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;
  late ViewMode _view;

  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
  ViewMode get view => _view;

  void toggleView() {
    _view = _view == ViewMode.parent ? ViewMode.child : ViewMode.parent;
    
    if (_view == ViewMode.parent) {
      _lightTheme = AppThemeData.lightParentTheme;
      _darkTheme = AppThemeData.darkParentTheme;
    } else {
      _lightTheme = AppThemeData.lightChildTheme;
      _darkTheme = AppThemeData.darkChildTheme;
    }

    notifyListeners();
  }

  void toggleThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();
    _viewModeService.updateThemeMode(_themeMode);
  }

  Future<void> loadSettings() async {
    _themeMode = await _viewModeService.themeMode;
    _view = await _viewModeService.view;
    _lightTheme = _view == ViewMode.parent
        ? AppThemeData.lightParentTheme
        : AppThemeData.lightChildTheme;
    _darkTheme = _view == ViewMode.parent
        ? AppThemeData.darkParentTheme
        : AppThemeData.darkChildTheme;

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _viewModeService.updateThemeMode(newThemeMode);
  }
}
