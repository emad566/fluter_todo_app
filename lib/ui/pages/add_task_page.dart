import 'package:fluter_todo_app/controllers/task_controller.dart';
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

  final DateTime _selectedDate = DateTime.now();
  final String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now())
      .toString();

  final String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selectedRemind = 5;
  List<int> remindList = [5,10,15,20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  Color _selectedColor = pinkClr;

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
                widget: const Icon(Icons.calendar_month),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InputField(
                      label: 'Start Time',
                      hintText: _startTime,
                      widget: const Icon(Icons.alarm),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Expanded(
                    flex: 1,
                    child: InputField(
                      label: 'End Time',
                      hintText: _endTime,
                      widget: const Icon(Icons.alarm),
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
                          children: <Color>[primaryClr, pinkClr, orangeClr].map<Widget>((Color e) => GestureDetector(
                            onTap: (){
                              setState(() {
                                _selectedColor = e;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                                backgroundColor: e,
                                radius: 20.0,
                                child: (e != _selectedColor)? null : const Icon(
                                  Icons.done,
                                  color: whiteClr,
                                  size: 30,
                                ),
                              ),
                            ),
                          )).toList(),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: MyButton(label: 'Save Task', onTab: (){

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
}
