import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazafny/constants.dart'; // Assuming loginTextColor is defined here

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final String? title; // Make it nullable and optional
  final Color? buttonColor;

  const CustomAppBar({
    super.key,
    required this.onBackPressed,
    this.title, // Optional parameter
    this.buttonColor, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: title != null
            ? Text(
                title!,
                style: const TextStyle(
                  color: loginTextColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              )
            : null, // If title is null, no title is displayed
        leading: IconButton(
          enableFeedback: false,
          onPressed: onBackPressed,
          icon: SvgPicture.asset(
            "assets/Icons/backArrow.svg",
            width: 30,
            height: 30,
            color: buttonColor ?? loginTextColor,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 20.0); // Default AppBar height + padding
}

class ForgetPasswordCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onBackPressed;

  const ForgetPasswordCustomAppBar({
    super.key,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0), // Adjust the value as needed
      child: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Forget Password",
          style: TextStyle(
            color: loginTextColor,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          enableFeedback: false,
          onPressed: onBackPressed,
          icon: SvgPicture.asset(
            "assets/Icons/backArrow.svg",
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 20.0); // Default AppBar height + padding
}

class JobCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final String? title; // Make it nullable and optional

  const JobCustomAppBar({
    super.key,
    required this.onBackPressed,
    this.title, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: title != null
                ? Text(
                    title!,
                    style: const TextStyle(
                      color: loginTextColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null, // If title is null, no title is displayed
            leading: IconButton(
              enableFeedback: false,
              onPressed: onBackPressed,
              icon: SvgPicture.asset(
                "assets/Icons/Exit.svg",
                width: 22,
                height: 22,
              ),
            ),
          ),
          Spacer(),
          Divider(thickness: 0.5,height: 1,color: linesColor,)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight + 20.0); // Default AppBar height + padding
}
