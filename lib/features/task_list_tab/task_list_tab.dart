import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/auth_provider/auth_providers.dart';
import 'package:todo_app/config/my_theme.dart';
import 'package:todo_app/config/app_localization/app_local_provider.dart';
import 'package:todo_app/config/task_list/taskList_provider.dart';
import 'package:todo_app/features/task_list_tab/task_item.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();




  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskListProvider>(context);
    var localeProvider = Provider.of<AppLocalProvider>(context);
    var authProviders =Provider.of<AuthProviders>(context);
    if (taskProvider.tasksList.isEmpty) {
       taskProvider.getAllTasksFromFireStore(authProviders.currentUser?.id??'');
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: EasyInfiniteDateTimeLine(
            showTimelineHeader: false,
            dayProps: EasyDayProps(
              todayStyle: DayStyle(
                dayNumStyle: Theme.of(context).textTheme.bodyLarge!,
                dayStrStyle: Theme.of(context).textTheme.bodySmall!,
                monthStrStyle: Theme.of(context).textTheme.bodySmall!,
              ),
              activeDayStyle: DayStyle(
                  dayNumStyle: Theme.of(context).textTheme.bodyLarge!,
                  dayStrStyle: Theme.of(context).textTheme.bodySmall!,
                  monthStrStyle: Theme.of(context).textTheme.bodySmall!,
                  decoration: BoxDecoration(
                    color: MyTheme.blueColor,
                    borderRadius: BorderRadius.circular(10),
                  )),
              borderColor: MyTheme.lightWhiteColor,
              height: MediaQuery.of(context).size.height * 0.13,
              inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                color: MyTheme.lightWhiteColor,
                borderRadius: BorderRadius.circular(10),
              )),
            ),
            activeColor: MyTheme.blueColor,
            controller: _controller,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            locale: localeProvider.appLang,
            onDateChange: (date) {
              taskProvider.changeSelectedDate(date,authProviders.currentUser?.id??'');
            },
            focusDate: taskProvider.selectedDate,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                task: taskProvider.tasksList[index],
              );
            },
            itemCount: taskProvider.tasksList.length,
          ),
        )
      ],
    );
  }
}
