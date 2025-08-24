import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  String get currentLangCode => _locale.languageCode;

  void setLocale(Locale locale) {
    if (!['en', 'ar'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }

  void toggleLang() {
    setLocale(_locale.languageCode == 'en' ? const Locale('ar') : const Locale('en'));
  }

  TextDirection get direction =>
      _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr;
}
