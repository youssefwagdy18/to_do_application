import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/config/task_list/taskList_provider.dart';
import 'package:todo_app/features/authentication/login/login_screen.dart';
import 'package:todo_app/features/authentication/register/register_screen.dart';
import 'package:todo_app/features/authentication/register/welcome_screen.dart';
import 'package:todo_app/features/home_screen.dart';
import 'package:todo_app/features/task_list_tab/edit_task_tab.dart';
import 'package:todo_app/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppThemeProvider>(
            create: (context) => AppThemeProvider()..getTheme()),
        ChangeNotifierProvider<AppLocalProvider>(
            create: (context) => AppLocalProvider()..getLang()),
        ChangeNotifierProvider<TaskListProvider>(
            create: (context) => TaskListProvider()),
        ChangeNotifierProvider<AuthProviders>(
            create: (context) => AuthProviders())
      ],
      child: const MyApp(),
    ),
  );
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
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        EditTaskTab.routeName: (context) => const EditTaskTab(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen()
      },
    );
  }

}
