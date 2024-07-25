import 'package:flutter/material.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/settings/controller/locale_controller.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeController = LocaleController();
  final viewModeController = ViewModeController();
  final taskController = TaskController();

  await viewModeController.loadSettings();
  await localeController.loadLocale();

  runApp(
    MyApp(
      localeController: localeController,
      viewModeController: viewModeController,
      taskController: taskController,
    ),
  );
}
