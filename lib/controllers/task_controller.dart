import 'dart:ui';

import 'package:fluter_todo_app/db/db_helper.dart';
import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  static final List<Color> taskColors = [primaryClr, pinkClr, orangeClr];

  late List<Task> taskList=  <Task>[].obs;

  void getTasks() async{
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList = tasks.map((task) => Task.fromJson(task)).toList();
  }

  Future<int> addTask({required task}) async{
    return await DBHelper.insert(task);
  }

  Future<int> deleteTask({required taskId}) async{
    return await DBHelper.delete(taskId);
  }

  Future<int> updateToCompleted({required taskId}) async{
    return await DBHelper.update(taskId);
  }
}
