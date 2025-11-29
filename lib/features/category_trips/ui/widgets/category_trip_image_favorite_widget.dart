import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';

class CategoryTripImageFavoriteWidget extends StatelessWidget {
  final HomeTripModel trip;

  const CategoryTripImageFavoriteWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: Stack(
        children: [
          _buildImage(colors),
          Positioned(
            top: 12.h,
            right: 12.w,
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.backgroundWhite.withValues(alpha: 0.9),
              ),
              child: Icon(
                Icons.favorite_border,
                size: 18.sp,
                color: colors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(ColorTheme colors) {
    if (trip.image != null && trip.image!.isNotEmpty) {
      return Image.network(
        trip.image!,
        height: 160.h,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
    return Container(
      height: 160.h,
      width: double.infinity,
      color: colors.grayVeryLight,
    );
  }
}
