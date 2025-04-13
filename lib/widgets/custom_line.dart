import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 1,
        color: linesColor,
      ),
    );
  }
}
