import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/images.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const AuthLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme()
          .whiteColor, // Or a light gray if needed to see the white oval
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // MARK:- Curved Box (White Oval with Shadow)
            Positioned(
              top: -302.h, // Figma: top: -302px
              left: -145.w, // Figma: left: -145px
              child: Container(
                width: 663.w, // Figma: width: 663px
                height: 423.h, // Figma: height: 423px
                decoration: BoxDecoration(
                  color: ColorTheme().whiteColor,
                  // rectangle + elliptical radius to make an Oval
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(663.w, 423.h),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFF1C1C1C,
                      ).withValues(alpha: 0.25), // #1C1C1C40
                      blurRadius: 21,
                      offset: Offset.zero,
                    ),
                  ],
                ),
              ),
            ),

            // MARK:- Logo & App Name
            Positioned(
              top: 78.h, // Figma: top: 74px
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Images.logo,
                    width: 83.w, // Figma: width: 83px
                    height: 64.h, // Figma: height: 64px
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 8.h), // Figma: gap: 8px
                  Image.asset(
                    Images.splashText,
                    width: 87.w, // Figma: width: 87px
                    height: 29.h, // Figma: height: 29px
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),

            // MARK:- Form Container
            Positioned(
              top: 199.h, // Figma: top: 199px
              left: 16.w, // Figma: left: 16px
              right: 16.w, // width: 343px (375 - 16 - 16)
              bottom: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Title (Log In / Sign Up)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: AppTextStyles.semiBold24().copyWith(
                          color: ColorTheme().navyBlue,
                          height: 1.0,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 24.h,
                    ), // Figma: gap: 24px between title and inputs
                    // The Form Fields passed as child
                    child,

                    // Bottom padding for scrolling
                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
