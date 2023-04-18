class Task {
  final int id
  ;
  final String title;
  final String note;
  final int isCompleted;
  final String date;
  final String startTime;
  final String endTime;
  final int color;
  int? remind;
  String? repeat;

  Task({
    required this.id,
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
}
