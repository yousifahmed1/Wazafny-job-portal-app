import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class AnswerTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AnswerTextField({
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
        const SizedBox(height: 8), // Add space between label and field
        TextFormField(
          onTap: onTap,
          onChanged: onChanged,
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
              vertical: 20.0, // Increased vertical padding
              horizontal: 16.0, // Slightly bigger horizontal padding
            ),
            errorStyle: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bordersColor),
              borderRadius: BorderRadius.circular(12.0),
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

          // Make it suitable for long text:
          minLines: 3, // Field will start tall
          maxLines: null, // Expands if user types more
        ),
      ],
    );
  }
}
