import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:fluter_todo_app/controllers/task_controller.dart';
import 'package:fluter_todo_app/services/notification_services.dart';
import 'package:fluter_todo_app/ui/pages/add_task_page.dart';
import 'package:fluter_todo_app/ui/size_config.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:fluter_todo_app/ui/widgets/button.dart';
import 'package:fluter_todo_app/ui/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.requestIOSPermissions();
    notifyHelper.initializeNotification();
  }

  final TaskController _taskController = Get.put(TaskController());
  late DateTime _selectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: myAppBar(setState: setState, context: context, title: 'To Do App', isLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizeConfig.orientation == Orientation.portrait?
              Column(
                  children: addTaskeDateList(),
              )
              :
              Row(
                children: addTaskeDateList(),
              ),

            if(SizeConfig.orientation == Orientation.portrait)
            const SizedBox(height: 70,),
            Expanded(child: _showTasks()),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  List<Widget> addTaskeDateList() {
    return [
      _addTask(),
      const SizedBox(height: 10,),
      SizeConfig.orientation == Orientation.portrait? _addDateBar() : Expanded(child: _addDateBar()),
      const SizedBox(height: 10,),
    ];
  }

  _addTask() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizeConfig.orientation == Orientation.portrait?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _addtaskList(),
        )
        :
        Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _addtaskList(),
    ),
    );
  }

  List<Widget> _addtaskList() {
    return [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: Themes.subHeadingStyle,
            ),
            Text(
              'Today',
              style: Themes.headingStyle,
            ),
          ],
        ),
        const SizedBox(height: 20,),
        MyButton(
          label: '+ Add Task',
          onTab: () async{
            await Get.to(()=> const AddTaskPage());
            _taskController.getTasks();
          },
        ),
      ];
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 6, left: 20),
      child: DatePicker(
        _selectedDate,
        initialSelectedDate: _selectedDate,
        onDateChange: (DateTime date){
          // setState(() {
            _selectedDate = date;
          // });
        },
        // width: 70,
        // height: 100,
        monthTextStyle: !Get.isDarkMode? defaultMonthTextStyle : defaultMonthTextStyle.copyWith(color: whiteClr),
        dayTextStyle: !Get.isDarkMode? defaultDayTextStyle : defaultDayTextStyle.copyWith(color: whiteClr),
        dateTextStyle: !Get.isDarkMode? defaultDateTextStyle : defaultDateTextStyle.copyWith(color: whiteClr),
        selectedTextColor: Colors.white,
        selectionColor: !Get.isDarkMode? primaryClr : blackClr,
        deactivatedColor: AppColors.defaultDeactivatedColor,
      ),
    );
  }

  _showTasks() {
    return Container(
      child: _noTasks(),
    );
  }

  _noTasks() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/task.svg',
                    color: primaryClr.withOpacity(0.5),
                    height: 90,
                    semanticsLabel: 'Task',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    width: SizeConfig.orientation == Orientation.portrait? double.infinity : SizeConfig.screenWidth*.7,
                    child: Text(
                      'You do not have any task yet, Add new task to make your days to make your day products',
                      style: Themes.subHeadingStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
