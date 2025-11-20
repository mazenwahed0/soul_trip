import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Creates a fade transition page for smoother navigation animations
CustomTransitionPage<void> fadeTransitionPage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
