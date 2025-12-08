import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class BannerBookButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BannerBookButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.primaryYellow,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Book Now',
          style: AppTextStyles.semiBold12().copyWith(color: colors.blackColor),
        ),
      ),
    );
  }
}
