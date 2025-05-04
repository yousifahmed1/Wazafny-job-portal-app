import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class RegularTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final void Function()? ontap;
  final String? Function(String?)? validator;

  final TextInputType keyboardType;

  const RegularTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.keyboardType,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      controller: controller,
      validator: validator,
      cursorColor: loginTextColor,
      style: const TextStyle(
        color: loginTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: loginTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightPrimary),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightPrimary),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightPrimary, width: 2.0),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
