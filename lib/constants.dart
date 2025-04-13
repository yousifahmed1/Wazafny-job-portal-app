import 'package:flutter/material.dart';


const darkPrimary = Color(0xff201A23);
const loginTextColor = Color(0xff242645);
const primaryColor = Color(0xff6A0DAD);
const lightPrimary = Color(0xffF2E9FF);
const backgroundColor = Color(0xffFBF8FD);
const linesColor = Color(0xffC7C7C7);
const bordersColor = Color(0xff7d7c7c);
const hintText = Color(0xff8E8E8E);
const scaffoldColor = Color(0xfff6f3f7);

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



