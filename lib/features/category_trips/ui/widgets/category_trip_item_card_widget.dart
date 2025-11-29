import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_image_favorite_widget.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_location_rating_row_widget.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_category_price_row_widget.dart';

class CategoryTripItemCardWidget extends StatelessWidget {
  final HomeTripModel trip;
  final VoidCallback? onTap;

  const CategoryTripItemCardWidget({super.key, required this.trip, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colors.backgroundWhite,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.grayVeryLight, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + favorite
            CategoryTripImageFavoriteWidget(trip: trip),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    trip.title,
                    style: AppTextStyles.semiBold16().copyWith(
                      color: colors.blackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),

                  // Location + date + rating
                  SizedBox(height: 8.h),
                  CategoryTripLocationRatingRowWidget(trip: trip),
                  SizedBox(height: 8.h),

                  // Category + price
                  CategoryTripCategoryPriceRowWidget(trip: trip),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
