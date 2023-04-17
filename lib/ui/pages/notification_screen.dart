import 'package:fluter_todo_app/ui/theme.dart';
import 'package:fluter_todo_app/ui/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);

  final String payload;
  @override
  // ignore: library_private_types_in_public_api
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(setState: setState, context: context, title: _payload.toString().split('|')[0]),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Column(
              children: [
                Text(
                  'Hello World',
                  style: TextStyle(
                      color: Get.isDarkMode? Colors.white : Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 26
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'You have a new reminder',
                  style: TextStyle(
                      color: Get.isDarkMode? Colors.grey[100] : darkGreyClr,
                      fontWeight: FontWeight.w300,
                      fontSize: 20
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildNotificationItem(icon: Icons.text_format, title: 'Title', content: 'title'),
                      const SizedBox(height: 10,),
                      buildNotificationItem(icon: Icons.text_format, title: 'Title', content: 'title'),
                      const SizedBox(height: 10,),
                      buildNotificationItem(icon: Icons.text_format, title: 'Title', content: 'title'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }

  Column buildNotificationItem({
    required IconData icon,
    required String title,
    required String content
  }) {
    // String title;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
          ),
        ),
      ],
    );
  }
}
