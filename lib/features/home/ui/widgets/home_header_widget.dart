import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String userName;
  final String greeting;

  const HomeHeaderWidget({
    super.key,
    this.userName = 'Nora',
    this.greeting = 'Start Your Wellness Journey',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Picture
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorTheme().primaryYellow, width: 2.w),
            color: ColorTheme().grayVeryLight,
          ),
          child: Center(
            child: Icon(
              Soultrip.profile,
              size: 32.sp,
              color: ColorTheme().primaryBlue,
            ),
          ),
        ),

        SizedBox(width: 12.w),

        // Greeting Text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $userName',
                style: AppTextStyles.semiBold16().copyWith(
                  color: ColorTheme().blackColor,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                greeting,
                style: AppTextStyles.regular12().copyWith(
                  color: ColorTheme().grayMedium,
                ),
              ),
            ],
          ),
        ),

        // Notification Bell
        Container(
          width: 44.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: ColorTheme().grayVeryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Soultrip.notification,
            color: ColorTheme().primaryBlue,
            size: 24.sp,
          ),
        ),
      ],
    );
  }
}
