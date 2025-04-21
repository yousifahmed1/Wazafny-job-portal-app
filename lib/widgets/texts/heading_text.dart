import 'package:flutter/material.dart';

import '../../constants.dart';

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

  const HeadingText({
    super.key,
    required this.title,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: true,
      textAlign: textAlignment,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: darkPrimary,
      ),
    );
  }
}
