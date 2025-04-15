import 'package:flutter/material.dart';

import '../constants.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text, this.btnColor, this.txtColor,
  });
  final String text;
  final Color? btnColor;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.07,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: btnColor ?? primaryColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: txtColor ??Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.size,
    this.btnColor,
  });
  final double? height;
  final double? width;
  final String text;
  final double? size;
  final Color? btnColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: btnColor ?? primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: size ?? 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.size,
    this.borderColor,
  });
  final double? height;
  final double? width;
  final String text;
  final double? size;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? darkPrimary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: darkPrimary,
              fontWeight: FontWeight.w700,
              fontSize: size ?? 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
