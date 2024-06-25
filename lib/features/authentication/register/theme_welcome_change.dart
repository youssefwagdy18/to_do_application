import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import '../../../config/my_theme.dart';

class ThemeWelcomeChange extends StatefulWidget {
  const ThemeWelcomeChange({super.key});

  @override
  State<ThemeWelcomeChange> createState() => _ThemeWelcomeChangeState();
}

class _ThemeWelcomeChangeState extends State<ThemeWelcomeChange> {
  @override
  Widget build(BuildContext context) {
    AppThemeProvider appThemeProvider =Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(onTap: (){
            appThemeProvider.changeTheme(ThemeMode.light);
          },
              child: appThemeProvider.appTheme == ThemeMode.light?
              selectedItem(AppLocalizations.of(context)!.light_mode):
              unSelectedItem(AppLocalizations.of(context)!.light_mode),
          ),
          const Spacer(),
          InkWell(onTap: (){
            appThemeProvider.changeTheme(ThemeMode.dark);
          },
          child: appThemeProvider.appTheme==ThemeMode.dark?
            selectedItem(AppLocalizations.of(context)!.dark_mode):
            unSelectedItem(AppLocalizations.of(context)!.dark_mode),)
        ],
      ),
    );
  }

  selectedItem(String text){
    return Row(
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: MyTheme.blueColor)),
        const Spacer(),
        const Icon(
          Icons.check,
          color: MyTheme.blueColor,
        )
      ],
    );
  }

  unSelectedItem(String text){
    return Row(
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge),
      ],
    );
  }
}
