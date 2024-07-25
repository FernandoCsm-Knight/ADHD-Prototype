import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:prototype/src/settings/service/locale_service.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class LocaleController with ChangeNotifier {
  final LocaleService _localeService = LocaleService();
  
  final List<Locale> supportedLocales = AppLocalizations.supportedLocales;
  final List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    AppLocalizations.delegate,
    SfGlobalLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  late Locale _locale;

  Locale get locale => _locale;

  Future<void> loadLocale() async {
    _locale = await _localeService.locale;

    notifyListeners();
  }

  Future<void> updateLocale(Locale newLocale) async {
    if (newLocale == _locale) return;

    _locale = newLocale;
    await _localeService.updateLocale(_locale);

    notifyListeners();
  }
}