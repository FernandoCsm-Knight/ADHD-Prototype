import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:prototype/src/calendar/screen/calendar_screen.dart';
import 'package:prototype/src/common/controller/task_controller.dart';
import 'package:prototype/src/common/main_screen.dart';
import 'package:prototype/src/common/models/task.dart';
import 'package:prototype/src/settings/controller/locale_controller.dart';
import 'package:prototype/src/settings/controller/view_mode_controller.dart';
import 'package:prototype/src/tasks/task_screen.dart';
import 'package:provider/provider.dart';

import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.localeController,
    required this.viewModeController,
    required this.taskController,
  });

  final LocaleController localeController;
  final ViewModeController viewModeController;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ViewModeController>(
          create: (_) => viewModeController,
        ),
        ChangeNotifierProvider<TaskController>(
          create: (_) => taskController,
        ),
        ChangeNotifierProvider<LocaleController>(
          create: (_) => localeController,
        ),

        // Add other providers here
      ],
      child: Consumer2<ViewModeController, LocaleController>(
        builder: (context, viewModeController, localeController, child) {
          return MaterialApp(
            restorationScopeId: 'app',
            localizationsDelegates: localeController.localizationsDelegates,
            supportedLocales: localeController.supportedLocales,
            locale: localeController.locale,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: viewModeController.lightTheme,
            darkTheme: viewModeController.darkTheme,
            themeMode: viewModeController.themeMode,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(viewModeController: viewModeController);

                    case CalendarScreen.routeName:
                      return const CalendarScreen();

                    case TaskScreen.routeName:
                      return TaskScreen(task: routeSettings.arguments as Task);

                    case MainScreen.routeName:
                    default:
                      return const MainScreen();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
