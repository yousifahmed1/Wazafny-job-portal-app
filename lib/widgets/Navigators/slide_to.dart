import 'package:flutter/material.dart';

void slideTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,

      // Push is quick
      transitionDuration: const Duration(milliseconds: 300),

      // Pop is slower and smoother
      reverseTransitionDuration: const Duration(milliseconds: 300),

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)); // Smooth curve

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
