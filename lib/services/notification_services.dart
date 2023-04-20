// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '/models/task.dart';
import '/ui/pages/notification_screen.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String selectedNotificationPayload = '';

  final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  initializeNotification() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();

    final InitializationSettings initializationSettings = InitializationSettings(
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async { Get.dialog( Text(body!)); },
      ),
      android: const AndroidInitializationSettings('appicon'),
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload!);
      }
    );
  }

  displayNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker'
    );

    DarwinNotificationDetails  iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes, Task task) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    var formattedDate = DateFormat.yMd().parse(task.date);
    final tz.TZDateTime formattedLocalDate = tz.TZDateTime.from(formattedDate, tz.local);


    if(task.remind != null){
      scheduledDate = scheduledDate.subtract(Duration(minutes: task.remind!));
    }

    if (scheduledDate.isBefore(now)) {
      if(task.repeat == 'Daily'){
        scheduledDate = tz.TZDateTime(tz.local, formattedLocalDate.year, formattedLocalDate.month, formattedLocalDate.day +1, hour, minutes);
      }
      if(task.repeat == 'Weekly'){
        scheduledDate = tz.TZDateTime(tz.local, formattedLocalDate.year, formattedLocalDate.month, formattedLocalDate.day +7, hour, minutes);
      }
      if(task.repeat == 'Monthly'){
        scheduledDate = tz.TZDateTime(tz.local, formattedLocalDate.year, formattedLocalDate.month +1 , formattedLocalDate.day, hour, minutes);
      }

      if(task.remind != null){
        scheduledDate = scheduledDate.subtract(Duration(minutes: task.remind!));
      }
    }


    return scheduledDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  scheduledNotification (int hour, int minutes, Task task) async{
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        task.title,
        task.note,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        _nextInstanceOfTenAM(hour, minutes, task),

        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')
        ),

        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '${task.title}|${task.note}|${task.startTime}'
    );
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is $payload');
      await Get.to(() => NotificationScreen(payload: payload,));
    });
  }

  Future<void> cancelNotification({required dynamic id}) async{
    await flutterLocalNotificationsPlugin.cancel(id!);
  }

  Future<void> cancelAllNotification() async{
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

