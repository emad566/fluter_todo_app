import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/extra/color.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:fluter_todo_app/controllers/task_controller.dart';
import 'package:fluter_todo_app/models/task.dart';
import 'package:fluter_todo_app/services/notification_services.dart';
import 'package:fluter_todo_app/ui/pages/add_task_page.dart';
import 'package:fluter_todo_app/ui/size_config.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:fluter_todo_app/ui/widgets/button.dart';
import 'package:fluter_todo_app/ui/widgets/components.dart';
import 'package:fluter_todo_app/ui/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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

            if(SizeConfig.orientation == Orientation.portrait && _taskController.taskList.isEmpty)
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
    return ListView.builder(
      scrollDirection: SizeConfig.orientation == Orientation.landscape? Axis.horizontal : Axis.vertical,
      itemBuilder: (BuildContext context, int index){
        Task task = _taskController.taskList[index];
        var hour = int.parse(task.startTime.split(':')[0]);
        var minutes = int.parse(task.startTime.split(':')[1].split(' ')[0]);

        // var date = DateFormat.jm().parse(task.startTime);
        // var mTime = DateFormat('HH:mm').format(date);

        NotifyHelper().scheduleNotification(hour, minutes, task);

        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 1000),
          child: SlideAnimation(
            horizontalOffset: 300,
            child: FadeInAnimation(
              child: GestureDetector(
                onTap: () => _showBottomSheet(context, task),
                child: TaskTile(task: task,),
              ),
            ),
          ),
        );
      },
      itemCount: _taskController.taskList.length,
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

  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)?
            task.isCompleted == 1? SizeConfig.screenHeight *0.6 : SizeConfig.screenHeight *0.8
            :task.isCompleted == 1? SizeConfig.screenHeight *0.35 : SizeConfig.screenHeight *0.50,
          color: Get.isDarkMode? darkHeaderClr : whiteClr,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              task.isCompleted == 1 ?
                  Container()
                  : _buildBottomSheet(
                    label: 'Task Completed',
                    onTap: (){
                      Get.back();
                    },
                    clr: primaryClr
                  ),
              Divider(color: Get.isDarkMode? Colors.grey : darkGreyClr,),
              _buildBottomSheet(
                  label: 'Delete Task',
                  onTap: (){
                    Get.back();
                  },
                  clr: primaryClr
              ),
              Divider(color: Get.isDarkMode? Colors.grey : darkGreyClr,),
              _buildBottomSheet(
                  label: 'Cancel',
                  onTap: (){
                    Get.back();
                  },
                  clr: primaryClr
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      )
    );
  }

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color clr,
    bool  isClose = false
  }){
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(top: 18),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose?
                Get.isDarkMode? Colors.grey[600]! : Colors.grey[300]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose? Colors.transparent : clr,
        ),
        child: Text(
          label,
          style: isClose?
                Themes.titleStyle
                :
                Themes.titleStyle.copyWith(
                    color: whiteClr,
                  ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
