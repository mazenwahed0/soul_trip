import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icon_pack/solar_icon_pack.dart';

import '../../../../core/theme/colors.dart';

class SaveCircleButton extends StatelessWidget {
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool isSaved;

  const SaveCircleButton({
    super.key,
    this.size = 44,
    this.iconSize = 20,
    this.backgroundColor = Colors.white,
    this.onTap,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Center(
          child: Icon(
            isSaved ? SolarBoldIcons.bookmark : SolarLinearIcons.bookmark,
            size: iconSize.sp,
            color: isSaved ? ColorTheme().primaryBlue : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
