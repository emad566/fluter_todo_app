import 'package:fluter_todo_app/db/db_helper.dart';
import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  static final List<Color> taskColors = [primaryClr, pinkClr, orangeClr];

  late RxList<Task> taskList=  <Task>[].obs;

  void getTasks() async{
    debugPrint('getTasks');
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((task) => Task.fromJson(task)).toList());
  }

  Future<int> addTask({required task}) async{
    debugPrint('addTasktTasks');
    return await DBHelper.insert(task);
  }

  Future<int> deleteTask({required taskId}) async{
    debugPrint('deleteTasksks');
    return await DBHelper.delete(taskId);
  }

  Future<int> updateToCompleted({required taskId}) async{
    debugPrint('updateToCompleted');
    return await DBHelper.update(taskId);
  }
}
