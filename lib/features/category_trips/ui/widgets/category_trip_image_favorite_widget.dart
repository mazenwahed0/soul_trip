import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';

class CategoryTripImageFavoriteWidget extends StatelessWidget {
  final HomeTripModel trip;
  final Widget? favoriteButton;

  const CategoryTripImageFavoriteWidget({
    super.key,
    required this.trip,
    this.favoriteButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return SizedBox(
      // Figma: Width 327, Height 124
      width: 327.w,
      height: 124.h,
      child: Stack(
        children: [
          // 1. The Image
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r), // Figma: Radius 14px
              child: _buildImage(colors),
            ),
          ),

          // 2. Favorite Button
          Positioned(
            top: 8.h, // Figma: Gap 8px from top
            right: 8.w, // Figma: Gap 8px from right
            child: favoriteButton ?? _buildDefaultFavoriteButton(colors),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(ColorTheme colors) {
    if (trip.image != null && trip.image!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: trip.image!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => Container(
          color: colors.grayVeryLight,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colors.primaryBlue,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: colors.grayVeryLight,
          child: Icon(Icons.image_not_supported, color: colors.grayMedium),
        ),
      );
    }
    return Container(
      color: colors.grayVeryLight,
      child: Icon(Icons.landscape, color: colors.grayMedium),
    );
  }

  Widget _buildDefaultFavoriteButton(ColorTheme colors) {
    // Figma: Width 40, Height 40, Radius 26px (Circle)
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: colors.whiteColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25), // Figma: #00000040
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Icon(
        Soultrip.hearts, // Using filled heart for visual reference
        size: 18.sp, // Figma: width 17, height 15 -> approx 18sp
        color: const Color(0xFFEA4335), // Figma: #EA4335 (Red)
      ),
    );
  }
}
