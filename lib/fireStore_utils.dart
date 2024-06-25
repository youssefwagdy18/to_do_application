// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/model/task.dart';

class FireBaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Task.collectionName)
        .withConverter(
            fromFirestore: ((snapshot, _) =>
                Task.fromFireStore(snapshot.data()!)),
            toFirestore: (task, _) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task,String uId) {
    var collectionRef = getTaskCollection(uId);
    var taskDocRef = collectionRef.doc();
    // id => auto generated
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task,String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTaskInFireStore(Task task,String uId) {
    var updateTask =
        getTaskCollection(uId).doc(task.id).update(task.toFireStore());
    return updateTask;
  }

  static Future<void> editIsDone(Task task,String uId) {
    var isDoneEdit =
        getTaskCollection(uId).doc(task.id).update({'isDone': task.isDone});
    return isDoneEdit;
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.routeName)
        .withConverter(
            fromFirestore: (snapshot, _) =>
                MyUser.fromFireStore(snapshot.data()),
            toFirestore: (myUser, _) => myUser.toFireStore(myUser));
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    var querySnapShot = await getUserCollection().doc(uId).get();
    return querySnapShot.data();
  }
}
