import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/features/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'Splash screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, LayoutScreen.routeName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var splashProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
        body: splashProvider.isDark()
            ? Image.asset(
                'assets/images/splash_dark.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              )
            : Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ));
  }
}
