import 'package:flutter/material.dart';

class MyTheme {
  static const Color primaryLightColor = Color(0xffDFECDB);
  static const Color primaryDarkColor = Color(0xff060E1E);
  static const Color appBarColor = Color(0xff5D9CEC);
  static const Color primaryTaskDoneColor = Color(0xff61E757);
  static const Color primaryEditTaskColor = Color(0xff5D9CEC);
  static ThemeData lightMode = ThemeData(
      scaffoldBackgroundColor: MyTheme.primaryLightColor,
      appBarTheme: const AppBarTheme(backgroundColor: MyTheme.appBarColor),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        bodyMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        bodySmall: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      ));
  static ThemeData darkMode = ThemeData(
      scaffoldBackgroundColor: MyTheme.primaryDarkColor,
      appBarTheme: const AppBarTheme(backgroundColor: MyTheme.appBarColor),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        bodyMedium: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        bodySmall: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
      ));
}
