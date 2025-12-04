import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/soultrip_icons.dart';

class FavCircleButton extends StatelessWidget {
  final VoidCallback? onToggle;
  final int count;
  final bool isFavorite;

  const FavCircleButton({
    super.key,
    this.onToggle,
    required this.count,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();
    return GestureDetector(
      onTap: onToggle,
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: colors.whiteColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Soultrip.hearts : Icons.favorite_border,
              color: isFavorite ? Colors.red : colors.primaryBlue,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 4.w),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}
