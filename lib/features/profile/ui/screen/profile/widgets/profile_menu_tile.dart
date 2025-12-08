import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_style.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showBorder = true,
    this.isLogout = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showBorder;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();
    // Figma: Text Color #000814
    final textColor = isLogout
        ? colorTheme.errorColor
        : const Color(0xFF000814);
    final iconColor = isLogout ? colorTheme.errorColor : colorTheme.primaryBlue;
    final borderColor = const Color(0xFFD9D9D9); // Figma: #D9D9D9

    return InkWell(
      onTap: onTap,
      child: Container(
        // Figma: Width 343 (handled by parent padding), Height 32 content + 4 top + 4 bottom
        width: 343.w,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        margin: EdgeInsets.symmetric(
          vertical: 2.h,
        ), // Note: Additional spacing (Margin) for touch target
        decoration: BoxDecoration(
          border: showBorder
              ? Border(bottom: BorderSide(color: borderColor, width: 1))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // MARK:- Left Side: Icon + Text
            Row(
              children: [
                // -- Icon: 24x24
                Icon(icon, size: 24.sp, color: iconColor),

                // -- Gap: 16px
                SizedBox(width: 16.w),

                // -- Text: Poppins 16 Medium
                Text(
                  title,
                  style: AppTextStyles.medium16().copyWith(color: textColor),
                ),
              ],
            ),

            // MARK:- Right Side: Arrow Icon (Hidden for logout)
            if (isLogout == false)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18.sp, // adjusted for visual balance within 24px box
                color: colorTheme.blackColor,
              ),
          ],
        ),
      ),
    );
  }
}
