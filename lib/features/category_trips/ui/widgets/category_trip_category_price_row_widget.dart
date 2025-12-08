import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CategoryTripCategoryPriceRowWidget extends StatelessWidget {
  final HomeTripModel trip;

  const CategoryTripCategoryPriceRowWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Category pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: colors.primaryBlue,
          ),
          child: Row(
            children: [
              Icon(
                Soultrip.mdiMeditation,
                size: 16.sp,
                color: colors.whiteColor,
              ),
              SizedBox(width: 4.w),
              Text(
                trip.category ?? '',
                style: AppTextStyles.medium12().copyWith(
                  color: colors.whiteColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              '${trip.price.toStringAsFixed(0)} \$',
              style: AppTextStyles.semiBold22().copyWith(
                color: colors.blackColor,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              ' / Night',
              style: AppTextStyles.regular12().copyWith(
                color: colors.blackColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
