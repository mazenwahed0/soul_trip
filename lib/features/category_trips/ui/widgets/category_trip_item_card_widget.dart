import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solar_icon_pack/solar_icon_pack.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_image_favorite_widget.dart';

class CategoryTripItemCardWidget extends StatelessWidget {
  final HomeTripModel trip;
  final VoidCallback? onTap;
  final Widget? favoriteButton;

  const CategoryTripItemCardWidget({
    super.key,
    required this.trip,
    this.onTap,
    this.favoriteButton,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Figma: Width 343, Height ~216 (Dynamic based on content)
        width: 343.w,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(8.w), // Figma: Padding 8px
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFB), // Figma: Background #FBFBFB
          borderRadius: BorderRadius.circular(22.r), // Figma: Radius 22px
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.25,
              ), // Figma: #00000040 (approx 25%)
              blurRadius: 2, // Figma: Blur 2
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // 1. Image & Favorite Button Section
            CategoryTripImageFavoriteWidget(
              trip: trip,
              favoriteButton: favoriteButton,
            ),

            SizedBox(height: 12.h), // Gap between image and text
            // 2. Info Section (Split Left & Right)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // MARK:- Left Column (Title, Location/Duration, Category)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        trip.title,
                        style: AppTextStyles.medium14().copyWith(
                          color: const Color(0xFF262626), // Figma: #262626
                          height: 1.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(
                        height: 8.h,
                      ), // Figma: Gap 16px (Visual adjustment)
                      // Location & Duration Row
                      Row(
                        children: [
                          // Location
                          Icon(
                            Soultrip.location,
                            size: 14.sp,
                            color: const Color(0xFF001D3D), // Figma: #001D3D
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            trip.location,
                            style: AppTextStyles.regular12().copyWith(
                              color: const Color(0xFF898989), // Figma: #898989
                            ),
                          ),

                          SizedBox(width: 12.w), // Gap between loc and date
                          // Duration
                          Icon(
                            Soultrip.calendarBold,
                            size: 14.sp,
                            color: const Color(0xFF001D3D),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${trip.daysFromToday ?? 10} days',
                            style: AppTextStyles.regular12().copyWith(
                              color: const Color(0xFF898989),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12.h),

                      // Category Pill
                      if (trip.category != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primaryBlue, // #003566
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                SolarLinearIcons.meditation,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                trip.category!,
                                style: AppTextStyles.medium10().copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // -- RIGHT COLUMN (Rating, Price)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating Badge
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Soultrip.goldstar,
                            color: const Color(0xFFFFC107),
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            trip.rate.toString(),
                            style: AppTextStyles.semiBold12().copyWith(
                              color: const Color(0xFF262626),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 4.h), // Spacing
                    // Price
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${trip.price.toInt()} \$',
                            style: AppTextStyles.semiBold20().copyWith(
                              color: const Color(0xFF262626),
                            ),
                          ),
                          TextSpan(
                            text: ' / Night',
                            style: AppTextStyles.regular14().copyWith(
                              color: const Color(0xFF262626),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
