import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wazafny/core/constants/constants.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged; // Add onChanged callback

  const SearchTextField({
    super.key,
    required this.controller,
    this.onChanged, // Add it to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        border: Border.all(
          color: linesColor, // your custom border color
          width: 2.0, // border thickness
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          cursorColor: darkPrimary,
          style: const TextStyle(
            color: darkPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SvgPicture.asset(
                "assets/Icons/search_icon.svg",
                width: 24.0,
                height: 24.0,
              ),
            ),
            hintText: "Search",
            hintStyle: const TextStyle(
              color: bordersColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: onChanged, // Set the onChanged callback
        ),
      ),
    );
  }
}
