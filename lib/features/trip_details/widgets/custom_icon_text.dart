import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CustomIconText extends StatelessWidget {
  final String icon;
  final String text;

  const CustomIconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 18.w,
          height: 18.w,
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: ColorTheme().grayDarker,
              fontSize:AppTextStyles.medium13().fontSize,
              
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}

