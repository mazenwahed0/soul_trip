import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class NotificationSectionHeaderWidget extends StatelessWidget {
  final String title;

  const NotificationSectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      color: colors.backgroundWhite,
      child: Text(title, style: AppTextStyles.bold18()),
    );
  }
}
