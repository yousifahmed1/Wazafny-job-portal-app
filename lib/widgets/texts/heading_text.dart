import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class HeadingText1 extends StatelessWidget {
  final String title;
  const HeadingText1({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 30,
        color: darkPrimary,
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String title;
  final TextAlign? textAlignment;
  final Color? titleColor;
  final double? fontSize;

  const HeadingText({
    super.key,
    required this.title,
    this.textAlignment,
    this.titleColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      textAlign: textAlignment,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 24,
        color: titleColor ?? darkPrimary,
      ),
    );
  }
}
