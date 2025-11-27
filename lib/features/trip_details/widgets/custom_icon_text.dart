import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CustomIconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomIconText({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18.w,
          color: ColorTheme().primaryBlue,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: ColorTheme().grayDarker,
            fontSize:AppTextStyles.medium13().fontSize,
          ),
        ),
      ],
    );
  }
}

@Preview(name: "CustomIconText Preview") 
Widget preview() {
  return ScreenUtilInit(
    child: const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomIconText(
            icon: Icons.location_on,
            text: 'Sample Location',
          ),
        ),
      ),
    ),
  );
}