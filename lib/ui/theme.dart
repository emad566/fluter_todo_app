import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color whiteClr = Colors.white;
const Color blackClr = Colors.black;
const primaryClr = bluishClr;
const errorClr = Colors.red;
var grey200 = Colors.grey[200];
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final ThemeData lightThem = ThemeData(
    primaryColor: primaryClr,
    scaffoldBackgroundColor: whiteClr,
    colorScheme: ThemeData().colorScheme.copyWith(
      background: whiteClr,
      brightness: Brightness.light,
    ),
  );

  static final ThemeData darkThem = ThemeData(
    primaryColor: darkGreyClr,
    scaffoldBackgroundColor: darkGreyClr,
    colorScheme: ThemeData().colorScheme.copyWith(
      background: darkGreyClr,
      brightness: Brightness.dark,
    ),
  );

  static TextStyle get headingStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
          color: Get.isDarkMode? whiteClr : blackClr,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
    );
  }
  static TextStyle get subHeadingStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode? whiteClr : blackClr,
        fontSize: 20 ,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  static TextStyle get titleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode? whiteClr : blackClr,
        fontSize: 18 ,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  static TextStyle get subTitleStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode? whiteClr : blackClr,
        fontSize: 16 ,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  static TextStyle get bodyStyle {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode? whiteClr : blackClr,
        fontSize: 14 ,
        fontWeight: FontWeight.w400,
      ),
    );
  }
  static TextStyle get body2Style {
    return GoogleFonts.lato(
      textStyle: TextStyle(
        color: Get.isDarkMode? grey200 : whiteClr,
        fontSize: 14 ,
        fontWeight: FontWeight.w400,
      ),
    );
  }

}