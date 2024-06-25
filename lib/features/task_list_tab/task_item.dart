// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/config/task_list/taskList_provider.dart';
import 'package:todo_app/features/task_list_tab/edit_task_tab.dart';
import 'package:todo_app/fireStore_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<TaskListProvider>(context);
    var authProviders = Provider.of<AuthProviders>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTaskTab.routeName,
                    arguments: widget.task);
              },
              backgroundColor: MyTheme.lightGreyColor,
              label: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              foregroundColor: Colors.white,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            )
          ],
        ),
        startActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                showDialog(
                  context: context,
                  builder: (alertContext) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!.task_status,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: MyTheme.darkBlackColor)),
                      content: Text(
                        AppLocalizations.of(context)!.are_you_sure_to_delete_the_task,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.darkBlackColor),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            FireBaseUtils.deleteTaskFromFireStore(widget.task,authProviders.currentUser?.id??'')
                                .timeout(const Duration(milliseconds: 10),
                                    onTimeout: () {});
                            Navigator.pop(alertContext);
                            listProvider.getAllTasksFromFireStore(authProviders.currentUser?.id??'');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.blueColor),
                          child:  Text(
                            AppLocalizations.of(context)!.ok,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(alertContext);
                            listProvider.getAllTasksFromFireStore(authProviders.currentUser?.id??'');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.blueColor),
                          child:  Text(
                    AppLocalizations.of(context)!.cancel,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: MyTheme.lightWhiteColor),
          height: MediaQuery.of(context).size.height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.task.isDone!
                      ? MyTheme.greenColor
                      : MyTheme.blueColor,
                ),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: widget.task.isDone!
                              ? MyTheme.greenColor
                              : MyTheme.blueColor),
                    ),
                    Text(widget.task.description ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: MyTheme.darkBlackColor))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (widget.task.isDone == false) {
                    widget.task.isDone = true;
                  } else {
                    widget.task.isDone = false;
                  }
                  FireBaseUtils.editIsDone(widget.task,authProviders.currentUser?.id??'');
                  setState(() {});
                },
                child: widget.task.isDone!
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: MyTheme.greenColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.blueColor),
                        child: Icon(
                          Icons.check,
                          color: MyTheme.lightWhiteColor,
                          size: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
