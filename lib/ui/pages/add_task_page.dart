import 'package:fluter_todo_app/controllers/task_controller.dart';
import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:fluter_todo_app/ui/widgets/button.dart';
import 'package:fluter_todo_app/ui/widgets/components.dart';
import 'package:fluter_todo_app/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late DateTime _selectedDate = DateTime.now();
  late String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now())
      .toString();

  late String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5,10,15,20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ThemeData().colorScheme.primary,
      appBar: myAppBar(setState: setState, context: context, title: 'Add Task'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              InputField(
                label: 'Title',
                controller: _titleController,
                hintText: 'Enter title here',
              ),
              const SizedBox(height: 10,),
              InputField(
                label: 'Note',
                controller: _noteController,
                hintText: 'Enter note here',
              ),
              const SizedBox(height: 10,),
              InputField(
                label: 'Date',
                hintText: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: (){
                    _getDateFromUser();
                  },
                  icon: const Icon(Icons.calendar_month)
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputField(
                      label: 'Start Time',
                      hintText: _startTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime:true);
                        },
                        icon: const Icon(Icons.alarm)
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    flex: 1,
                    child: InputField(
                      label: 'End Time',
                      hintText: _endTime,
                      widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStartTime:false);
                        },
                        icon: const Icon(Icons.alarm)
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                label: 'Remind',
                hintText: '$_selectedRemind minutes early',
                widget: DropdownButton(
                  elevation: 4,
                  underline: Container(height: 0,),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? val){
                    setState(() {
                      _selectedRemind = int.parse(val!) ;
                    });
                  },
                  items: remindList
                      .map(
                        (int e) => DropdownMenuItem(
                          value: '$e',
                          child: Text('$e'),
                        ),
                      )
                      .toList(),
                ),

              ),
              const SizedBox(height: 10,),
              InputField(
                label: 'Repeat',
                hintText: _selectedRepeat,
                widget: DropdownButton(
                  elevation: 4,
                  underline: Container(height: 0,),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? val){
                    setState(() {
                      _selectedRepeat = val! ;
                    });
                  },
                  items: repeatList
                      .map(
                        (String e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  ).toList(),
                ),

              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color',
                          style: Themes.subHeadingStyle,
                        ),
                        Row(
                          children: TaskController.taskColors.asMap().entries.map<Widget>((item) {
                            Color color = item.value;

                            return GestureDetector(
                            onTap: (){
                              setState(() {
                                _selectedColor = item.key;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                backgroundColor: color,
                                radius: 20.0,
                                child: (item.key != _selectedColor)? null : const Icon(
                                  Icons.done,
                                  color: whiteClr,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyButton(label: 'Save Task', onTab: (){
                      _validateDate();
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _validateDate(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if(_titleController.text.isEmpty && _noteController.text.isEmpty){
      Get.snackbar(
        'required',
        'All Fields are required',
        snackPosition: SnackPosition.BOTTOM,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red,)
      );
    }

  }

  _addTaskToDb() async{
    int value = await _taskController.addTask(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind
      ),
    );

    print ('$value');
  }

  void _getDateFromUser() async {
   DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );

   if(pickedDate == null) return;
   setState(() {
     _selectedDate = pickedDate;
   });

  }

  void _getTimeFromUser({ required bool isStartTime}) async{
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: isStartTime?
        TimeOfDay.fromDateTime(DateTime.now())
          :
        TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 15)))
      ,
    );

    if(pickedTime == null) {
      debugPrint('Canceled or something error');
      return;
    }

    setState(() {
      String formattedTime = pickedTime.format(context);

      isStartTime?
        _startTime = formattedTime
        :
        _endTime = formattedTime;
    });
  }

}
