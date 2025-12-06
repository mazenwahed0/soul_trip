import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/wishlist/ui/widgets/add_to_wishlist_button.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/empty_wishlist_icon.svg',
              width: 150.w,
              height: 150.h,
            ),
            SizedBox(height: 30.h),
            Text(
              'No Trips In Your Wishlist',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: colors.grayMedium,
              ),
            ),
            SizedBox(height: 40.h),
            AddToWishlistButton(
              onPressed: () {
                // Navigate to home screen
                context.push(Routes.categoriesTripsView);

                // Testing print
                debugPrint("Button Pressed! Go to Home");
              },
            ),
          ],
        ),
      ),
    );
  }
}
