import 'package:flutter/material.dart';

class AppLocalProvider extends ChangeNotifier {
  String appLang = "en";

  ChangeLanguage(String newLang) {
    if (appLang == newLang) {
      return;
    }
    appLang = "ar";
    notifyListeners();
  }
}
