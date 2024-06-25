// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../fireStore_utils.dart';
import '../../model/task.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectedDate = DateTime.now();
  getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtils.getTaskCollection(uId).get();
    tasksList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();

    var taskUpdatedList = tasksList.where((task) {
      if (selectedDate.year == task.taskDate!.year &&
          selectedDate.month == task.taskDate!.month &&
          selectedDate.day == task.taskDate!.day) {
        return true;
      } else {
        return false;
      }
    }).toList();
    tasksList = taskUpdatedList;
    //

    //sorting descending
    tasksList.sort((task1, task2) {
      return task1.taskDate!.compareTo(task2.taskDate!);
    });

    notifyListeners();
  }

  changeSelectedDate(DateTime newSelectedDate,String uId) {
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
  }
}
