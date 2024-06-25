import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/config/task_list/taskList_provider.dart';
import 'package:todo_app/fireStore_utils.dart';
import '../../model/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskBottomSheet extends StatefulWidget {
  const EditTaskBottomSheet({super.key});

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  late TaskListProvider taskProvider;
  late AuthProviders authProviders;
  String taskId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments as Task;
      titleController.text = args.title!;
      descController.text = args.description!;
      selectedDate = args.taskDate!;
      taskId = args.id!;
    });
  }

  @override
  Widget build(BuildContext context) {
    taskProvider = Provider.of<TaskListProvider>(context);
    authProviders = Provider.of<AuthProviders>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(35)),
      margin: const EdgeInsets.all(40),
      child: Column(children: [
        Center(
            child: Text(
          AppLocalizations.of(context)!.edit_task,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: MyTheme.darkBlackColor),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Title'),
              TextFormField(
                style: const TextStyle(color: MyTheme.blueColor),
                decoration:   InputDecoration(
                    hintText: AppLocalizations.of(context)!.edit_title_here,),
                controller: titleController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter text here';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // Text("Description"),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: 3,
                decoration:  InputDecoration(
                  hintText: AppLocalizations.of(context)!.edit_desc_here,
                ),
                controller: descController,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter text here';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                AppLocalizations.of(context)!.select_time,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: MyTheme.darkBlackColor),
              ),
              Center(
                child: TextButton(
                    onPressed: () {
                      showCalender();
                    },
                    child: Text(DateFormat.yMd().format(selectedDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.darkBlackColor))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.blueColor),
                      onPressed: () {
                        confirmEditTask();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.blueColor),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context).textTheme.titleMedium,
                      ))
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    selectedDate = chosenDate ?? DateTime.now();
    setState(() {});
  }

  confirmEditTask() {
    if (_formKey.currentState?.validate() == true) {
      Task task = Task(
        title: titleController.text,
        description: descController.text,
        taskDate: selectedDate,
        id: taskId,
      );
      FireBaseUtils.updateTaskInFireStore(
              task, authProviders.currentUser?.id ?? '')
          .timeout(const Duration(milliseconds: 30), onTimeout: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (alertContext) {
            return AlertDialog(
              title:  Text(AppLocalizations.of(context)!.task_status),
              content:  Text(AppLocalizations.of(context)!.task_is_successfully_added,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: MyTheme.darkBlackColor),),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(alertContext);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.blueColor),
                  child:  Text(
                    AppLocalizations.of(context)!.ok,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        );
        taskProvider
            .getAllTasksFromFireStore(authProviders.currentUser?.id ?? '');
      });
    }
  }
}
