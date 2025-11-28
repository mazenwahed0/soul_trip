import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/utils/images.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_style.dart';
import '../../../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../../../../core/widgets/common/buttons/secondary_button.dart';

class LogoutStatusSheet extends StatelessWidget {
  const LogoutStatusSheet({
    super.key,
    required this.title,
    required this.primaryButtonText,
    required this.onPrimaryPressed,
    this.isLoading = false,
  });

  final String title;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();

    return Container(
      // Figma Height: 333
      height: 333.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: colorTheme.whiteColor,
        // Figma Radius: 30px (Top Left & Top Right only)
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      // MARK:- Title & Image (Required)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold24().copyWith(
              color: colorTheme.blackColor,
            ),
          ),

          SizedBox(height: 24.h),

          // Image
          Image.asset(
            Images.redVerfiy,
            width: 89.w, // Figma Width: 89
            height: 89.w, // Figma Height: 89
            fit: BoxFit.contain,
          ),

          // Space between Image and Buttons
          SizedBox(height: 42.h),

          // MARK:- Buttons
          Row(
            children: [
              // Primary Button (Using PrimaryShadowButton)
              Expanded(
                child: PrimaryShadowButton(
                  text: primaryButtonText!,
                  onPressed: onPrimaryPressed ?? () {},
                  isLoading: isLoading,
                  height: 48, // Match Figma Height
                  width: 164,
                  // Dynamic Color (Red for failure, Blue for success)
                  backgroundColor: colorTheme.errorColor,
                ),
              ),

              //  MARK:- Secondary Button (Right)
              SizedBox(width: 8.w), // Gap: 8px

              Expanded(
                child: SecondaryButton(
                  text: "Cancel",
                  height: 48, // Match Figma Height
                  onPressed: () => context.pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
