import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  Future<void> changeTheme(ThemeMode newTheme)async{
    if(appTheme == newTheme){
      return;
    }
    appTheme = newTheme;
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setBool('isDark', appTheme==ThemeMode.dark);
    notifyListeners();
  }
  Future<void>getTheme()async{
    final SharedPreferences prefs =await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if(isDark!=null){
      if(isDark=true){
        appTheme=ThemeMode.dark;
      }
    }
    notifyListeners();
  }
}
