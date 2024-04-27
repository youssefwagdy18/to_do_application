import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  notifyListeners();
}
