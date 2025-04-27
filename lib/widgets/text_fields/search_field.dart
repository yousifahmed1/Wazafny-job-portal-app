import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;

  const SearchTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(70),
        border: Border.all(
          color: linesColor, // your custom border color
          width: 2.0,        // border thickness
        ),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          cursorColor: loginTextColor,
          style: const TextStyle(
            color: loginTextColor,
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
        ),
      ),
    );
  
  }
}
