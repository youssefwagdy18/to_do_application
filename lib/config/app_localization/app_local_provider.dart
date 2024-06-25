import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalProvider extends ChangeNotifier {
   String appLang = "en";

  Future<void>changeLanguage(String newLang) async{
    if (appLang == newLang) {
      return;
    }
    appLang = newLang;
    notifyListeners();
    SharedPreferences prefs =await SharedPreferences.getInstance();
    prefs.setString('lang', newLang);
  }
   Future<void> getLang() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? lang = prefs.getString('lang');
     if (lang != null) {
       appLang = lang;
     }
     notifyListeners();
   }

}
