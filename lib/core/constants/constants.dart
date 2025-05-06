import 'package:flutter/material.dart';

const darkerPrimary = Color(0xff201A23);
const darkPrimary = Color(0xff242645);
const primaryColor = Color(0xff6A0DAD);
const lightPrimary = Color(0xffF2E9FF);
const backgroundColor = Color(0xffFBF8FD);
const offwhiteColor = Color(0xffEFF0F2);
const linesColor = Color(0xffC7C7C7);
const bordersColor = Color(0xff7d7c7c);
const hintText = Color(0xff8E8E8E);
const scaffoldColor = Color(0xfff6f3f7);
const greenColor = Color(0xff1B7908);
const lightGreenColor = Color(0xffD6F6D9);
const orangeColor = Color(0xffEFA600);
const lightOrangeColor = Color(0xffFEF4E5);
const redColor = Color(0xffC60000);
const lightRedColor = Color(0xffFEE5E5);
const whiteColor = Color(0xffFFFFFF);

const double normalPadding = 30;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}
