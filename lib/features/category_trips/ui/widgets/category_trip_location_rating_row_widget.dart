import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CategoryTripLocationRatingRowWidget extends StatelessWidget {
  final HomeTripModel trip;

  const CategoryTripLocationRatingRowWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Soultrip.location, size: 16.sp, color: colors.primaryBlue),
                SizedBox(width: 4.w),
                Text(
                  trip.location,
                  style: AppTextStyles.regular13().copyWith(
                    color: colors.grayMedium,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Soultrip.calendarBold,
                  size: 14.sp,
                  color: colors.primaryBlue,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${trip.daysFromToday ?? 0} days',
                  style: AppTextStyles.regular12().copyWith(
                    color: colors.grayMedium,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Soultrip.star, size: 20.sp, color: Colors.amberAccent),
                SizedBox(width: 4.w),
                Text(
                  trip.rate.toStringAsFixed(1),
                  style: AppTextStyles.medium12().copyWith(
                    color: colors.grayMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
