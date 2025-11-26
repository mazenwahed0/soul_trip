import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/category_model.dart';
import 'package:soul_trip/core/theme/colors.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItemWidget({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBlue : colors.backgroundWhite,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? colors.primaryBlue : colors.grayVeryLight,
            width: 1.w,
          ),
        ),
        child: Icon(
          category.icon,
          color: isSelected ? colors.whiteColor : colors.grayMedium,
          size: 24.sp,
        ),
      ),
    );
  }
}
