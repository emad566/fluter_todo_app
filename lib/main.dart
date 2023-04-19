import 'package:fluter_todo_app/db/db_helper.dart';
import 'package:fluter_todo_app/services/notification_services.dart';
import 'package:fluter_todo_app/services/theme_services.dart';
import 'package:fluter_todo_app/ui/pages/home_page.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  await DBHelper.initDB();
  await GetStorage.init();
  runApp( const MyApp());


}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ThemeServices().theme;
    return GetMaterialApp(
      theme: Themes.lightThem,
      darkTheme: Themes.darkThem,
      themeMode: themeMode,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
