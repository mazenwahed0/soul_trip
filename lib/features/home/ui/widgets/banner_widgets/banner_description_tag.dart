import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class BannerDescriptionTag extends StatelessWidget {
  final String description;

  const BannerDescriptionTag({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.primaryBlue,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Soultrip.fitnessFill, color: colors.whiteColor, size: 12.sp),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              description,
              style: AppTextStyles.regular10().copyWith(
                color: colors.whiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
