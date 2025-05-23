import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class SubHeadingText extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? fontSize;
  final TextAlign? textAlignment;
  final bool? underline;

  const SubHeadingText({
    super.key,
    required this.title,
    this.titleColor,
    this.fontSize,
    this.textAlignment,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      textAlign: textAlignment,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize ?? 18,
        color: titleColor ?? hintText,
        decoration:
            underline != false ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class SubHeadingText1 extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? fontSize;
  final TextAlign? textAlignment;

  const SubHeadingText1({
    super.key,
    required this.title,
    this.titleColor,
    this.fontSize,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlignment,
      softWrap: true,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 18,
        color: titleColor ?? hintText,
      ),
    );
  }
}

class SubHeadingText2 extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final double? fontSize;

  const SubHeadingText2({
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
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? 15,
        color: titleColor ?? hintText,
      ),
    );
  }
}
