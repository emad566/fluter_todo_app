import 'package:intl/intl.dart';

class Task {
  
  int? id;
  late String title;
  late String note;
  late int isCompleted;
  late String date;
  late String startTime;
  late String endTime;
  late int color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.remind,
    this.repeat
  });

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']?? '';
    note = json['note']?? '';
    isCompleted = json['isCompleted'] == null? 0 : int.parse(json['isCompleted']);
    date = json['date']?? DateTime.now().toString();
    startTime = json['startTime']?? '00:00:00';
    endTime = json['endTime']?? '00:00:00';
    color = json['color'] == null? 0 : int.parse(json['color']);
    remind = json['remind'] == null? 0 : int.parse(json['remind']);
    repeat = json['repeat']?? '';
  }
}
