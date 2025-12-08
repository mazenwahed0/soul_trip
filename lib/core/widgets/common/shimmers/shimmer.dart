import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:soul_trip/core/theme/colors.dart';

class CShimmerEffect extends StatelessWidget {
  const CShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (colorTheme.whiteColor),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
