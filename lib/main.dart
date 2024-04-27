import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/features/layout_screen.dart';
import 'package:todo_app/features/splash_screen/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppThemeProvider>(
          create: (context) => AppThemeProvider()),
      ChangeNotifierProvider<AppLocalProvider>(
          create: (context) => AppLocalProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var localeProvider = Provider.of<AppLocalProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: themeProvider.appTheme,
      initialRoute: SplashScreen.routeName,
      title: 'Localizations Sample App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(localeProvider.appLang),
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        LayoutScreen.routeName: (context) => LayoutScreen(),
      },
    );
  }
}
