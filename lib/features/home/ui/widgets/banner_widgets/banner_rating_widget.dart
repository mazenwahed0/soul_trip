import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class BannerRatingWidget extends StatelessWidget {
  final double rating;

  const BannerRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Soultrip.goldstar, color: colors.primaryYellow, size: 14.sp),
          SizedBox(width: 4.w),
          Text(
            rating.toStringAsFixed(1),
            style: AppTextStyles.semiBold12().copyWith(
              color: colors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
