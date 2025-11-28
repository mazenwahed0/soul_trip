import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 164,
    this.height = 48,
  });

  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    // Logic: If onPressed is null, it's "Disabled" (Grey).
    // If onPressed is not null, it's "Default" (Blue).
    final bool isEnabled = onPressed != null;

    // -- Styles based on State
    final borderColor = isEnabled
        ? colors
              .primaryBlue // #003566
        : const Color(0xFFACACAC); // Disabled: #ACACAC

    final textColor = isEnabled ? colors.primaryBlue : colors.disabledButton;

    final shadowColor = isEnabled
        ? colors.blackColor.withValues(alpha: 0.25)
        : const Color(
            0xFF000000,
          ).withValues(alpha: 0.25); // #00000040 (25% or 40%)

    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: colors.whiteColor, // Background is white
        borderRadius: BorderRadius.circular(20), // Radius: 20px
        border: Border.all(
          color: borderColor,
          width: 1.5, // Border width: 1.5px
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 4, // Blur: 4px
            offset: const Offset(0, 0), // X:0, Y:0
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.medium16().copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
