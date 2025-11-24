import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/category_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CategoryTripCardWidget extends StatelessWidget {
  final CategoryTripModel category;
  final VoidCallback? onTap;

  const CategoryTripCardWidget({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 170.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              // Background image
              _buildBackgroundImage(colors),

              // Dark gradient at bottom
              _buildGradientOverlay(),

              // Text + arrow
              Positioned(
                left: 0,
                right: 0,
                bottom: 16.h,
                child: _buildContent(colors),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(ColorTheme colors) {
    if (category.image != null && category.image!.isNotEmpty) {
      return Image.network(category.image!, fit: BoxFit.cover);
    }

    return Container(color: colors.grayVeryLight);
  }

  Widget _buildGradientOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ColorTheme colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              category.categoryName,
              style: AppTextStyles.semiBold18().copyWith(
                color: colors.whiteColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(color: colors.whiteColor, width: 1.w),
              ),
              borderRadius: BorderRadius.circular(36),
              color: Colors.transparent,
            ),
            child: Icon(
              Icons.arrow_forward,
              size: 20.sp,
              color: ColorTheme().whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
