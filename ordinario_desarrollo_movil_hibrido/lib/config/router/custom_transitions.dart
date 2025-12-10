import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({required Widget child})
      : super(
          child: child,
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
