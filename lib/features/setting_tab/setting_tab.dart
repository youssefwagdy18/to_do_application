import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/features/setting_tab/languageBottomSheet.dart';
import 'package:todo_app/features/setting_tab/themeBottomSheet.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<AppLocalProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showLanguageBottomSheet();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 2, color: MyTheme.blueColor))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            localeProvider.appLang == 'ar'
                                ? AppLocalizations.of(context)!.arabic
                                : AppLocalizations.of(context)!.english,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: MyTheme.blueColor),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: MyTheme.blueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              AppLocalizations.of(context)!.mode,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showThemeBottomSheet();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 2, color: MyTheme.blueColor))),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            themeProvider.appTheme == ThemeMode.dark
                                ? AppLocalizations.of(context)!.dark_mode
                                : AppLocalizations.of(context)!.light_mode,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: MyTheme.blueColor),
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: MyTheme.blueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: false,
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15)),
        context: context,
        builder: (context) => const LanguageBottomSheet());
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: false,
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.15)),
        context: context,
        builder: (context) => const ThemeBottomSheet());
  }
}
