import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key, required this.rating});
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Soultrip.goldstar, color: ColorTheme().primaryYellow, size: 24),
        SizedBox(width: 4.w),
        Text(rating, style: AppTextStyles.medium14()),
      ],
    );
  }
}
