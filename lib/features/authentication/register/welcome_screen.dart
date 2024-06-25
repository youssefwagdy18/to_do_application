import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/features/authentication/login/login_screen.dart';
import 'package:todo_app/features/authentication/register/register_screen.dart';
import 'package:todo_app/features/authentication/register/theme_welcome_change.dart';
import 'language_welcome_change.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = 'WelcomeScreen';

  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLocalProvider>(context);
    return Stack(children: [
      Image.asset(themeProvider.appTheme==ThemeMode.light?
        'assets/images/welcome_screen.png':'assets/images/welcome_screen_dark.png',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      themeChange();
                    },
                    child: Text(
                      themeProvider.appTheme ==ThemeMode.dark
                          ? AppLocalizations.of(context)!.dark_mode
                          : AppLocalizations.of(context)!.light_mode,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                TextButton(
                    onPressed: () {
                      languageChange();
                    },
                    child: Text(
                      languageProvider.appLang == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.55,),
           Container(
             padding: const EdgeInsets.all(10),
             child: Center(child: Text(AppLocalizations.of(context)!.welcome_quote
                 ,style: Theme.of(context).textTheme.bodyMedium))
           ),
          SizedBox(height: MediaQuery.of(context).size.height*0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
                  child:Text(AppLocalizations.of(context)!.login
                  ,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),)),
              SizedBox(width: MediaQuery.of(context).size.width*0.05,),
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
                  style: ElevatedButton.styleFrom(backgroundColor: MyTheme.blueColor),
                  child:Text(AppLocalizations.of(context)!.register
                    ,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),))
            ],
          )
        ],
      )
    ]);
  }
  themeChange(){
    showModalBottomSheet(context: context,
        constraints: BoxConstraints.loose(Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height *0.15
        )),
        builder: (context){
      return const ThemeWelcomeChange();
        });
  }

  languageChange() {
    showModalBottomSheet(
        context: context,
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15)),
        builder: (context) {
          return const LanguageWelcomeChange();
        });
  }
}
