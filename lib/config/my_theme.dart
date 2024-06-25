import 'package:flutter/material.dart';


class MyTheme {
  static const Color backgroundLightColor = Color(0xffDFECDB);
  static const Color backgroundDarkColor = Color(0xff060E1E);
  static const Color lightWhiteColor = Color(0xffffffff);
  static const Color darkBlackColor = Color(0xff141922);
  static const Color redColor = Color(0xffEC4B4B);
  static const Color greenColor = Color(0xff61E757);
  static const Color blueColor = Color(0xff5D9CEC);
  static const Color lightGreyColor = Color(0xffA9A9A9);
  static const Color darkGreyColor = Color(0xff545455);
  static ThemeData lightMode = ThemeData(
      scaffoldBackgroundColor: MyTheme.backgroundLightColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.white,
                width: 5,
              ))),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: lightWhiteColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: blueColor))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: blueColor,
          unselectedItemColor: lightGreyColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      appBarTheme:
          const AppBarTheme(backgroundColor: MyTheme.blueColor, elevation: 0),
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
      scaffoldBackgroundColor: MyTheme.backgroundDarkColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: blueColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.white,
                width: 5,
              ))),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: blueColor,
          unselectedItemColor: darkGreyColor,
          backgroundColor: Colors.transparent,
          elevation: 0),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: darkGreyColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 3, color: blueColor))),
      appBarTheme:
           const AppBarTheme(backgroundColor: MyTheme.blueColor, elevation: 0),
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
