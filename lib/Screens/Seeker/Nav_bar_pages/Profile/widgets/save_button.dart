import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color? color;

  const SaveButton({super.key, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 50,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color ?? primaryColor,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
