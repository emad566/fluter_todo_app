import 'package:fluter_todo_app/ui/pages/notification_screen.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.lightThem,
      darkTheme: Themes.darkThem,
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const NotificationScreen(payload: 'Notif Screen',),
    );
  }
}
