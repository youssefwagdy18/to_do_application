import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/config/task_list/taskList_provider.dart';
import 'package:todo_app/fireStore_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey1 = GlobalKey<FormState>();
  late TaskListProvider taskProvider;
  late AuthProviders authProviders;
  @override
  Widget build(BuildContext context) {
    authProviders=Provider.of<AuthProviders>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Form(
            key: formKey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter the task';
                      }
                      return null;
                    },
                    onTap: () {},
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enter_your_task,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.lightGreyColor))),
                TextFormField(
                  onTap: () {},
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter the task description';
                    }
                    return null;
                  },
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enter_task_desc,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: MyTheme.lightGreyColor)),
                ),
                Text(
                  AppLocalizations.of(context)!.select_time,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Center(
                  child: TextButton(
                      onPressed: () {
                        showCalender();
                      },
                      child: Text(
                        DateFormat.yMd().format(selectedDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 17),
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            confirmAddTask();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.blueColor,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.add,
                            style: Theme.of(context).textTheme.titleMedium,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 10)),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    selectedDate = chosenDate ?? DateTime.now();
    setState(() {});
  }

  confirmAddTask() {
    if (formKey1.currentState?.validate() == true) {
      Task task = Task(
          title: titleController.text,
          description: descriptionController.text,
          taskDate: selectedDate);
      FireBaseUtils.addTaskToFireStore(task,authProviders.currentUser?.id??'')
          .timeout(const Duration(milliseconds: 30), onTimeout: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (alertContext) {
            return AlertDialog(
              title:  const Text('Task status',style:TextStyle(color: MyTheme.darkBlackColor)),
              content: const Text('Task is successfully added',style:TextStyle(color: MyTheme.darkBlackColor)),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(alertContext);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.blueColor),
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        );
        taskProvider.getAllTasksFromFireStore(authProviders.currentUser?.id??'');
        // ignore: avoid_print
      }).onError((error, stackTrace) => print('throw'));
    }
  }
}
