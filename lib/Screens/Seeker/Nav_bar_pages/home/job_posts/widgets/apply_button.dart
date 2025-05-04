import 'package:flutter/material.dart';
import 'package:wazafny/core/constants/constants.dart';

class ApplyButton extends StatelessWidget {
    final VoidCallback onTap;

  const ApplyButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set your container color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Shadow color
            spreadRadius: 10, // Spread of the shadow
            blurRadius: 50, // Blur effect
            offset: const Offset(
                0, 0), // Position of the shadow (x, y)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 30, horizontal: 15),
        child: GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Apply Now",
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
