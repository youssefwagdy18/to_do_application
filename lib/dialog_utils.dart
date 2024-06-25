import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogUtils {
  static void showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                Text(AppLocalizations.of(context)!.loading,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),)
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String contentMsg ,
        String? posActionName,
        Function? posAction,
        String? negActionName,
        Function? negAction,
        bool isDismissible =true,
      String titleMsg=''}) {
    List<Widget>actions =[];
    posActionName ==null ? actions:
        actions.add(TextButton(
            onPressed: (){
              Navigator.pop(context);
              if(posAction!=null){
                posAction.call();
              }
            },
            child: Text(posActionName,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),)));
    negActionName ==null ? actions:
    actions.add(TextButton(
        onPressed: (){
          Navigator.pop(context);
          if(negAction!=null){
            negAction.call();
          }
        },
        child: Text(negActionName)));
    showDialog(
      barrierDismissible:isDismissible ,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(contentMsg,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Text(titleMsg,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black),),
            actions: actions,
          );
        });
  }
}
