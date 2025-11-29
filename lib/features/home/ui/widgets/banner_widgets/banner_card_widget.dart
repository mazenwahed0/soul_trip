import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/banner_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_book_button.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_description_tag.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_favorite_button.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_image_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_location_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/banner_widgets/banner_rating_widget.dart';

class BannerCardWidget extends StatelessWidget {
  final BannerModel banner;
  final VoidCallback? onTap;
  final VoidCallback? onBookNow;
  final VoidCallback? onFavoriteToggle;

  const BannerCardWidget({
    super.key,
    required this.banner,
    this.onTap,
    this.onBookNow,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, // Full width
        height: 200.h,
        margin: EdgeInsets.symmetric(
          horizontal: 16.w,
        ), // Equal margins on both sides
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              BannerImageWidget(imageUrl: banner.image),

              // Gradient Overlay
              _buildGradientOverlay(),

              // Content
              _buildContent(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
          stops: const [0.3, 1.0],
        ),
      ),
    );
  }

  Widget _buildContent(ColorTheme colors) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Rating & Favorite
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BannerRatingWidget(rating: banner.rate),
              BannerFavoriteButton(onToggle: onFavoriteToggle),
            ],
          ),

          const Spacer(),

          // Title
          Text(
            banner.title,
            style: AppTextStyles.semiBold18().copyWith(
              color: colors.whiteColor,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 4.h),

          // Location
          BannerLocationWidget(location: banner.location),

          SizedBox(height: 4.h),

          // Bottom Row: Description Tag & Book Now Button
          Row(
            children: [
              Expanded(
                child: BannerDescriptionTag(description: banner.description),
              ),
              SizedBox(width: 8.w),
              BannerBookButton(onPressed: onBookNow),
            ],
          ),

          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
