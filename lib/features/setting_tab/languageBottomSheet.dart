// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:todo_app/config/my_theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});


  @override
  State<LanguageBottomSheet> createState() => LanguageBottomSheetState();
}

class LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLocalProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: (){
            provider.changeLanguage('en');
            },
            child: provider.appLang == 'en'?
                selectedLang(AppLocalizations.of(context)!.english):
                unSelectedLang(AppLocalizations.of(context)!.english)
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              provider.changeLanguage('ar');
            },
            child: provider.appLang == 'ar'?
            selectedLang(AppLocalizations.of(context)!.arabic):
            unSelectedLang(AppLocalizations.of(context)!.arabic)
          )
        ],
      ),
    );
  }
  selectedLang(text){
    return Row(
      children: [
        Text(text,
              style:
              Theme.of(context).textTheme.bodyLarge!.
              copyWith(color:
              MyTheme.blueColor)
          ),
        const Spacer(),
        const Icon(Icons.check,color: MyTheme.blueColor,)
      ],);
  }
  unSelectedLang(text){
    return Row(
      children: [
        Text(text,
            style: Theme.of(context).textTheme.bodyLarge),

      ],);
  }
}
