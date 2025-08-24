import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  String _currentLangCode = "en";

  String get currentLangCode => _currentLangCode;

  void toggleLang() {
    _currentLangCode = _currentLangCode == "en" ? "ar" : "en";
    notifyListeners();
  }

  void setLang(String code) {
    _currentLangCode = code;
    notifyListeners();
  }
  TextDirection get direction =>
      _currentLangCode == "ar" ? TextDirection.rtl : TextDirection.ltr;

}
