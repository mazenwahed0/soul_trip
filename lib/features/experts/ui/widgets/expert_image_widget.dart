import 'package:flutter/material.dart';

import 'package:soul_trip/core/theme/colors.dart';

class ExpertImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  const ExpertImage({super.key, required this.imageUrl, this.height = 520});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: ColorTheme().grayLight,
            child: Icon(Icons.error, size: 50, color: ColorTheme().grayDark),
          );
        },
      ),
    );
  }
}
