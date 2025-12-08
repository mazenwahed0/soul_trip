import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class AddNewCardButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AddNewCardButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = ColorTheme().primaryBlue;
    final TextStyle buttonTextStyle = AppTextStyles.semiBold14().copyWith(
      color: primaryBlue,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: primaryBlue, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/ic_round-plus.png',
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(width: 8.w),
            // Button Text
            Text("Add New Card", style: buttonTextStyle),
          ],
        ),
      ),
    );
  }
}
