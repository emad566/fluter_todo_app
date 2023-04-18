import 'package:fluter_todo_app/services/notification_services.dart';
import 'package:fluter_todo_app/services/theme_services.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


AppBar myAppBar ({Function? setState, BuildContext? context, String? title, bool isLeading = true}){

  return AppBar(
    leading: !isLeading? null : IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: Get.isDarkMode? whiteClr : darkGreyClr,
        size: 24,
      ),
    ),

    title: Text(
      '$title',
      style: Themes.headingStyle,
    ),

    actions: [
      const CircleAvatar(
        backgroundImage: AssetImage('assets/images/person.jpeg'),
        radius: 18,
      ),
      const SizedBox(width: 20),
      IconButton(
        onPressed: (){
          if(setState != null){
            setState(() {
              print(Get.isDarkMode);
              ThemeServices().switchTheme();
              NotifyHelper().displayNotification(title: 'Switched', body: 'body');
              // NotifyHelper().scheduleNotification();
            });
          }
        },
        icon: Get.isDarkMode?
        const Icon(Icons.nightlight_outlined, size: 24, color: whiteClr,)
        :
        const Icon(Icons.wb_sunny_outlined, size: 24, color: darkGreyClr,),
      ),
    ],
    elevation: 0,
    backgroundColor: context!.theme.colorScheme.background,
  );
}
