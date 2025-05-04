import 'package:flutter/material.dart';

void slideUp(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,

      // Push duration
      transitionDuration: const Duration(milliseconds: 300),

      // Pop duration
      reverseTransitionDuration: const Duration(milliseconds: 300),

      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0.0, 1.0), // Slide from bottom
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}


Future<T?> slideUp2<T>(BuildContext context, Widget page) {
  return Navigator.push<T>(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0.0, 1.0), // Slide from bottom
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));

        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

