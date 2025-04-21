import 'package:flutter/material.dart';
import 'package:wazafny/constants.dart';

class AboutTextField extends StatelessWidget {
  const AboutTextField({
    super.key,
    required TextEditingController aboutController,
  }) : _aboutController = aboutController;

  final TextEditingController _aboutController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeConfig.screenHeight * (1 / 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: bordersColor, width: 2),
      ),
      child: TextFormField(
        cursorColor: loginTextColor,
        controller: _aboutController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
              vertical: 16, horizontal: 12), // Adjust padding
        ),
        style: const TextStyle(
          color: loginTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ), // Optional: Adjust text style
      ),
    );
  }
}
