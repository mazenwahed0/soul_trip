import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class HomeTripsCardWidget extends StatelessWidget {
  final HomeTripModel trip;

  const HomeTripsCardWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Container(
      width: 160.w,
      margin: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image (network or placeholder)
            _buildBackgroundImage(colors),

            // Gradient overlay at bottom
            _buildGradientOverlay(),

            // Content
            _buildContent(colors),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(ColorTheme colors) {
    if (trip.image != null && trip.image!.isNotEmpty) {
      return Image.network(trip.image!, fit: BoxFit.cover);
    }

    return Container(
      color: colors.grayVeryLight,
      child: const Icon(Icons.landscape, color: Colors.grey),
    );
  }

  Widget _buildGradientOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ColorTheme colors) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // OFF badge at top-left
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '${trip.off}% OFF',
                style: AppTextStyles.semiBold12().copyWith(
                  color: colors.primaryBlue,
                ),
              ),
            ),
          ),

          const Spacer(),

          // Location text
          Text(
            trip.location,
            style: AppTextStyles.regular12().copyWith(color: colors.whiteColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 4.h),

          // Title text
          Text(
            trip.title,
            style: AppTextStyles.semiBold14().copyWith(
              color: colors.whiteColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
