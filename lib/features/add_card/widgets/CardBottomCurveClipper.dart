import 'package:flutter/material.dart';

class CardBottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    const curveHeight = 18; // shallow curve like your UI

    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, h - curveHeight)

      // smooth upward curve
      ..quadraticBezierTo(
        w / 2, h + curveHeight,  // control point (goes down slightly)
        w, h - curveHeight,      // end point
      )

      ..lineTo(w, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
