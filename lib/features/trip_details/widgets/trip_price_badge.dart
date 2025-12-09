import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/colors.dart';
import '/core/theme/text_style.dart';

class TripPriceBadge extends StatelessWidget {
  final String price;

  const TripPriceBadge({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: Container(
        width: 80.w,
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: ColorTheme().primaryYellow,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            price,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold22().copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class RatingRaw extends StatelessWidget {
  final int rating;

  const RatingRaw({super.key, required this.rating});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(rating, (index) {
          const String starAssetPath = 'assets/icons/StarIcon.png';
          Color starColor = ColorTheme().primaryYellow;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Image.asset(
              starAssetPath,
              width: 18.w,
              height: 18.w,
              color: starColor,
            ),
          );
        }),
        SizedBox(width: 4.w),
        Text(rating.toStringAsFixed(1), style: AppTextStyles.regular16()),
      ],
    );
  }
}

class CardContent extends StatelessWidget {
  final int rating;
  final String price;

  const CardContent({super.key, required this.price, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.h,
      width: 340.w,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(left: 0, bottom: 0, child: RatingRaw(rating: rating)),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TripPriceBadge(price: price),
            ),
          ),
        ],
      ),
    );
  }
}
