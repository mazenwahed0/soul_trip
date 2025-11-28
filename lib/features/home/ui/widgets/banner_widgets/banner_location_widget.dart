import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class BannerLocationWidget extends StatelessWidget {
  final String location;

  const BannerLocationWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Soultrip.location, color: colors.whiteColor, size: 14.sp),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            location,
            style: AppTextStyles.regular12().copyWith(color: colors.whiteColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
