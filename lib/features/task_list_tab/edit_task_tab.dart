import 'package:flutter/material.dart';
import 'package:todo_app/features/task_list_tab/edit_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../config/my_theme.dart';

class EditTaskTab extends StatefulWidget {
  static const String routeName ='EditTask';

  const EditTaskTab({super.key});

  @override
  State<EditTaskTab> createState() => _EditTaskTabState();
}

class _EditTaskTabState extends State<EditTaskTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height*0.15,
        title: Text(AppLocalizations.of(context)!.to_do_list,
          style: MyTheme.lightMode.textTheme.titleLarge,),
      ),
      body: const EditTaskBottomSheet(),

    );
  }
  void editTaskSheet(){
    showBottomSheet(context: context, builder: (context){
      return const EditTaskBottomSheet();
    });
  }
}
