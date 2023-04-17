import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onTab}) : super(key: key);
  final String label;
  final Function onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onTab(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.center,
        width: 100,
        // height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Get.isDarkMode? blackClr : primaryClr,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: whiteClr,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
