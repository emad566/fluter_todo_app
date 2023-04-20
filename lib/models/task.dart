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
    Map<String, dynamic> taskJson =  {
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
    if(id != null){
      taskJson['id'] = id;
    }

    return taskJson;
  }

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']?? '';
    note = json['note']?? '';
    isCompleted = json['isCompleted']?? 0;
    date = json['date']?? DateTime.now().toString();
    startTime = json['startTime']?? '00:00:00';
    endTime = json['endTime']?? '00:00:00';
    color = json['color']?? 0;
    remind = json['remind']?? 0;
    repeat = json['repeat']?? '';
  }
}
