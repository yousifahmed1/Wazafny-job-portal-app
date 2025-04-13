import 'package:flutter/material.dart';

import '../../constants.dart';

class SubHeadingText extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? fontSize;

  const SubHeadingText({
    super.key,
    required this.title,
    this.titleColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? 18,
        color: titleColor ?? hintText,
      ),
    );
  }
}

class SubHeadingText1 extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? fontSize;

  const SubHeadingText1({
    super.key,
    required this.title,
    this.titleColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 18,
        color: titleColor ?? hintText,
      ),
    );
  }
}
