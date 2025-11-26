import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onTap,
    this.backgroundColor = const Color(0xFFEBEBEB),
    this.iconColor = Colors.black,
  });

  /// Optional back action or colors
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => context.pop(),
      child: Container(
        width: 40.w, // Fixed Width: 40
        height: 40.w, // Fixed Height: 40
        decoration: BoxDecoration(
          color: backgroundColor, // Background: #EBEBEB or #FBFBFB

          borderRadius: BorderRadius.circular(31), // Radius: 31px (Circular)
        ),
        // Note: Alignment to center icon 'arrow_back_ios' have internal padding
        alignment: Alignment.center,
        child: Padding(
          // Note: Adjusting padding to center the arrow
          // (Without it iOS arrow looks too far to the right)
          padding: const EdgeInsets.only(right: 2.0),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18.sp, // Matches Figma ~14.4px height spec
            color: iconColor, // Default arrow color
            weight: 2.0, // matches the "border-width: 2px" look
          ),
        ),
      ),
    );
  }
}
