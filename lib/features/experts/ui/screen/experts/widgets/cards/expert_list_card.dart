import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';

class ExpertListCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String specialization;
  final double rating;
  final num price;
  final VoidCallback onBookTap;
  final VoidCallback onCardTap;

  const ExpertListCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.specialization,
    required this.rating,
    required this.price,
    required this.onBookTap,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        // Figma: Width 344, Height 140
        width: 344.w,
        height: 144.h,
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(8.w), // Figma: Padding 8px
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFB), // Figma: Background #FBFBFB
          borderRadius: BorderRadius.circular(28.r), // Figma: Radius 28px
          border: Border.all(color: const Color(0xFFEBEBEB)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x40000000), // Figma: #00000040
              blurRadius: 2, // Figma: blur 2px
              offset: const Offset(0, 0), // Figma: x:0, y:0
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- TOP SECTION (Height ~84px) ---
            SizedBox(
              height: 84.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ), // Rounded Rect per visual
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 60.w, // Adjusted for proportion
                      height: 60.w,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: colors.grayVeryLight,
                        child: const Icon(Icons.person),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w), // Gap
                  // Info Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Name
                        Text(
                          name,
                          style: AppTextStyles.semiBold16().copyWith(
                            color: const Color(0xFF000814),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),

                        // Location
                        Row(
                          children: [
                            Icon(
                              Soultrip.location,
                              size: 14.sp,
                              color: colors.primaryBlue,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              location,
                              style: AppTextStyles.regular12().copyWith(
                                color: colors.grayMedium,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        // Price (Money Section)
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${price.toStringAsFixed(0)} \$',
                                style: AppTextStyles.semiBold18().copyWith(
                                  color: const Color(0xFF000814),
                                ),
                              ),
                              TextSpan(
                                text: ' / hr',
                                style: AppTextStyles.regular12().copyWith(
                                  color: colors.grayMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rating Badge (Top Right)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.whiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: const Color(0xFFFFC107),
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          rating.toString(),
                          style: AppTextStyles.semiBold12().copyWith(
                            color: const Color(0xFF000814),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- BOTTOM SECTION (Height ~40px) ---
            Container(
              height: 38.h,
              margin: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Specialization Pill
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF898989),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      specialization,
                      style: AppTextStyles.medium12().copyWith(
                        color: colors.whiteColor,
                      ),
                    ),
                  ),

                  // Reusing PrimaryShadowButton (resized)
                  PrimaryShadowButton(
                    text: "Book Now",
                    onPressed: onBookTap,
                    width: 110, // Override default width
                    height: 40, // Override default height
                    radius: 16,
                    backgroundColor: colors.primaryBlue,
                    textStyle: AppTextStyles.semiBold14().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
