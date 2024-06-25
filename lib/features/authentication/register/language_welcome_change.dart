import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/my_theme.dart';

class LanguageWelcomeChange extends StatefulWidget {
  const LanguageWelcomeChange({super.key});

  @override
  State<LanguageWelcomeChange> createState() => _LanguageWelcomeChangeState();
}

class _LanguageWelcomeChangeState extends State<LanguageWelcomeChange> {
  @override
  Widget build(BuildContext context) {
    var appLangProvider = Provider.of<AppLocalProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                appLangProvider.changeLanguage('en');
              },
              child: appLangProvider.appLang == 'en'
                  ? selectedLang(AppLocalizations.of(context)!.english)
                  : unSelectedLang(AppLocalizations.of(context)!.english)),
          const Spacer(),
          InkWell(
            onTap: (){
              appLangProvider.changeLanguage('ar');
            },
            child: appLangProvider.appLang=='ar'
            ?selectedLang(AppLocalizations.of(context)!.arabic):
            unSelectedLang(AppLocalizations.of(context)!.arabic),
          )
        ],
      ),
    );
  }

  selectedLang(text) {
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

  unSelectedLang(text) {
    return Row(
      children: [
        Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
