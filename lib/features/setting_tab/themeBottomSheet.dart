// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/config/my_theme.dart';


class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});


  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.light);
              },
              child: themeProvider.appTheme == ThemeMode.light?
              selectedThemeMode(AppLocalizations.of(context)!.light_mode):
              unSelectedThemeMode(AppLocalizations.of(context)!.light_mode)),
            const Spacer(),
            InkWell(
              onTap: (){
                themeProvider.changeTheme(ThemeMode.dark);
              },
              child: themeProvider.appTheme ==ThemeMode.dark?
              selectedThemeMode(AppLocalizations.of(context)!.dark_mode):
              unSelectedThemeMode(AppLocalizations.of(context)!.dark_mode),
        ),]
    ));
  }
  selectedThemeMode(text){
    return Row(
      children: [
        Text(text,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: MyTheme.blueColor
        ),),
        const Spacer(),
        const Icon(Icons.check ,color: MyTheme.blueColor,)
      ],
    );
  }
  unSelectedThemeMode(text){
    return Row(
      children: [
        Text(text,style: Theme.of(context).textTheme.bodyLarge
        ),
      ],
    );
  }
}
