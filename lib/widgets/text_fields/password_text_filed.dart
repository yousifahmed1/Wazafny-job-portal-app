import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/core/constants/constants.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? Function(String?)? validator;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      cursorColor: darkPrimary,
      style: const TextStyle(
        color: darkPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            _obscureText ? 'assets/Icons/eyeOff.svg' : 'assets/Icons/eyeOn.svg',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        labelText: widget.labelText,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelStyle: const TextStyle(
          color: darkPrimary,
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
      keyboardType: TextInputType.visiblePassword,
    );
  }
}
