import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';

class ExpertImage extends StatelessWidget {
  final String imageUrl;
  final double height;

  // Default height set to 518, but we will override this to 450 in the view
  const ExpertImage({super.key, required this.imageUrl, this.height = 518});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375.w,
      height: height.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. The Image
          Image.network(
            imageUrl,
            fit: BoxFit.contain, // Changed to contain as requested
            alignment:
                Alignment.topCenter, // Aligns to top to keep face visible
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: ColorTheme().grayLight,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: ColorTheme().grayDark,
                ),
              );
            },
          ),

          // 2. Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFF6F6F6).withOpacity(0.0),
                  const Color(0xFFF6F6F6).withOpacity(0.0),
                  const Color(0xFFF2F2F2).withOpacity(0.5),
                ],
                stops: const [0.0, 0.43, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
