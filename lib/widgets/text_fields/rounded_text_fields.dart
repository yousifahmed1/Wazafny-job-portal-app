import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const RoundedTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
    required this.keyboardType,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null
            ? const SizedBox()
            : Text(
                labelText ?? "",
                style: const TextStyle(
                  color: loginTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
        TextFormField(
          onTap: onTap,
          onChanged: onChanged, // Pass onChanged to TextFormField
          controller: controller,
          validator: validator,
          cursorColor: loginTextColor,
          style: const TextStyle(
            color: loginTextColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, // Reduced vertical padding
              horizontal: 12.0, // Horizontal padding for aesthetics
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(
                  12.0), // Adjust radius for rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),

          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
