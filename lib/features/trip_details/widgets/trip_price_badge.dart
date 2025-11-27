import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/theme/colors.dart';
import 'package:flutter/widget_previews.dart';
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
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          price,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular24().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class RatingRaw extends StatelessWidget {
  final int rating;

  const RatingRaw({super.key, required this.rating});

  // Assuming this is inside a StatelessWidget/StatefulWidget like RatingRow
  // with a property 'final double rating;'

  @override
  Widget build(BuildContext context) {
    const int starCount = 5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(starCount, (index) {
          const String starAssetPath = 'assets/icons/StarIcon.png';

          Color starColor = index < rating
              ? ColorTheme().primaryYellow
              : Colors.grey;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Image.asset(
              starAssetPath,
              width: 16.w,
              height: 16.w,
              color: starColor,
            ),
          );
        }),
        SizedBox(width: 4.w),
        Text(
          rating.toStringAsFixed(1),
          style: AppTextStyles.regular16(),
        ),
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
      padding: EdgeInsets.only(left: 12.w),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: 
           RatingRaw(rating: rating),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: TripPriceBadge(price: price),
          ),
        ],
      ),
    );
  }
}

@Preview(name: "CardBottomLayout")
Widget cardBottomLayoutPreview() {
  return ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
      return MaterialApp(
        theme: ThemeData(primaryColor: Colors.yellow),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CardContent(rating: 3.0.toInt(), price: "700"),
          ),
        ),
      );
    },
  );
}
