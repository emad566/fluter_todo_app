import 'package:fluter_todo_app/ui/size_config.dart';
import 'package:fluter_todo_app/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key, required this.label, this.controller, this.widget, this.hintText}) : super(key: key);
  final String label;
  final TextEditingController? controller;
  final Widget? widget;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Themes.titleStyle,
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top:0.0),
                margin: const EdgeInsets.only(left:0.0),
                width: SizeConfig.screenWidth,
                height: 50,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(5),
                //     color: whiteClr,
                //     border: Border.all(
                //       width: 1,
                //       color: Colors.grey,
                //       style: BorderStyle.solid,
                //     )
                // ),
                child: TextFormField(
                  controller: controller,
                  autofocus: false,
                  readOnly: widget == null? false : true,
                  style: Themes.subTitleStyle,
                  cursorColor: Get.isDarkMode? grey200 : Colors.grey[700],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20.0),
                    hintText: hintText?? '',
                    hintStyle: Themes.subTitleStyle.copyWith(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Get.isDarkMode? darkGreyClr : darkGreyClr.withOpacity(.3),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Get.isDarkMode? blackClr : bluishClr,
                      ),
                    ),
                    suffixIcon: widget,
                  ),
                ),
              ),
              // widget?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}
