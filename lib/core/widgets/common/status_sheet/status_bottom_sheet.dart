import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';
import '../../../utils/constant.dart';
import '../buttons/primary_shadow_button.dart';

class StatusBottomSheet extends StatelessWidget {
  const StatusBottomSheet({
    super.key,
    required this.title,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.isLoading = false,
  });

  final String title;

  // Buttons are Optional
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
            ConstantVariable.yellowVerfiy,
            width: 89.w, // Figma Width: 89
            height: 89.w, // Figma Height: 89
            fit: BoxFit.contain,
          ),

          // MARK:- Primary Button (Optional)
          if (primaryButtonText != null) ...[
            // Space between Image and Button
            SizedBox(height: 32.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Primary Button (Using PrimaryShadowButton)
                PrimaryShadowButton(
                  text: primaryButtonText!,
                  onPressed: onPrimaryPressed ?? () {},
                  isLoading: isLoading,
                  height: 48, // Match Figma Height
                  width: 164.w,
                  backgroundColor: colorTheme.primaryBlue,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
