import 'package:fluter_todo_app/models/task.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController{

  final List<Task> taskList=  [
    Task(
      color: 3,
      title: 'Fist task',
      date: '2023-04-19',
      startTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 1)))
                .toString(),

      endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 2)))
                .toString(),
      id: 1,
      isCompleted: 0,
      note: 'Task not note note not sdsd vewf',
      remind: 5,
    ),

    Task(
      color: 2,
      title: 'Fist task',
      date: '2023-04-19',
      startTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 1)))
                .toString(),

      endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 2)))
                .toString(),
      id: 1,
      isCompleted: 0,
      note: 'Task not note note not sdsd vewf',
      remind: 5,
    ),

    Task(
      color: 0,
      title: 'Fist task',
      date: '2023-04-19',
      startTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 1)))
                .toString(),

      endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 2)))
                .toString(),
      id: 1,
      isCompleted: 1,
      note: 'Task not note note not sdsd vewf',
      remind: 5,
    ),

    Task(
      color: 1,
      title: 'Fist task',
      date: '2023-04-19',
      startTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 1)))
                .toString(),

      endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 2)))
                .toString(),
      id: 1,
      isCompleted: 1,
      note: 'Task not note note not sdsd vewf',
      remind: 5,
    ),

    Task(
      color: 0,
      title: 'Fist task',
      date: '2023-04-19',
      startTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 1)))
                .toString(),

      endTime: DateFormat('hh:mm a')
                .format(DateTime.now().add(const Duration(minutes: 2)))
                .toString(),
      id: 1,
      isCompleted: 0,
      note: 'Task not note note not sdsd vewf',
      remind: 5,
    )
  ];

  void getTasks(){

  }
}
