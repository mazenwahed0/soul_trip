import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.image,
    required this.onTap,
    this.isLoading = false,
  });

  final String image;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(20), // Radius: 20px
      child: Container(
        width: 88.w, // Figma Width: 88
        height: 52.h, // Figma Height: 52
        padding: const EdgeInsets.all(3), // Padding: 3px
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFB), // Background: #FBFBFB
          borderRadius: BorderRadius.circular(20), // Radius: 20px
          boxShadow: [
            BoxShadow(
              // Color: #00000040 (Black with ~25% opacity)
              color: const Color(0xFF000000).withValues(alpha: 0.25),
              blurRadius: 2, // Blur: 2px
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                )
              : Image.asset(
                  image,
                  width: 24.w, // Icon Width: 24
                  height: 24.h, // Icon Height: 24
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
