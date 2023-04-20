import 'package:fluter_todo_app/db/db_helper.dart';
import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  static final TaskController controller = Get.put(TaskController());

  static final List<Color> taskColors = [primaryClr, pinkClr, orangeClr];

  late RxList<Task> taskList = <Task>[].obs;

  void getTasks() async {
    debugPrint('getTasks');
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((task) => Task.fromJson(task)).toList());
  }

  Future<void> addTask({required task}) async {
    debugPrint('addTask');
    await DBHelper.insert(task);
    getTasks();
  }

  Future<void> deleteTask({required taskId}) async {
    debugPrint('deleteTask');
    await DBHelper.delete(taskId);
    getTasks();
  }

  Future<void> deleteAllTasks() async {
    debugPrint('deleteAllTask');
    await DBHelper.deleteAll();
    getTasks();
  }

  Future<void> updateToCompleted({required taskId}) async {
    debugPrint('updateToCompleted');
    await DBHelper.update(taskId);
    getTasks();
  }
}
