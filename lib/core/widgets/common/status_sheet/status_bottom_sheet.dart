import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';
import '../../../utils/constant.dart';
import '../buttons/primary_shadow_button.dart';

enum SheetType { success, failure }

class StatusBottomSheet extends StatelessWidget {
  const StatusBottomSheet({
    super.key,
    this.type = SheetType.success,
    required this.title,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.isLoading = false,
  });

  final SheetType type;
  final String title;

  // Buttons are Optional
  final String? primaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final bool isLoading;

  final String? secondaryButtonText;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();

    // Image based on Type
    final String imageAsset = type == SheetType.success
        ? ConstantVariable.yellowVerfiy
        : ConstantVariable.redVerfiy;

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
      // 1. Title & Image (Required)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // MARK:- Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold24().copyWith(
              color: colorTheme.blackColor,
            ),
          ),

          SizedBox(height: 24.h),

          // MARK:- Image
          Image.asset(
            imageAsset,
            width: 89.w, // Figma Width: 89
            height: 89.w, // Figma Height: 89
            fit: BoxFit.contain,
          ),

          // 2. Buttons Section (Optional)
          if (primaryButtonText != null) ...[
            // Spacer between Image and Buttons
            Spacer(),

            Row(
              children: [
                // MARK:- Primary Button (Using PrimaryShadowButton)
                Expanded(
                  child: PrimaryShadowButton(
                    text: primaryButtonText!,
                    onPressed: onPrimaryPressed ?? () {},
                    isLoading: isLoading,
                    height: 48, // Match Figma Height
                    width: 164,
                    // Dynamic Color (Red for failure, Blue for success)
                    backgroundColor: type == SheetType.failure
                        ? colorTheme.errorColor
                        : colorTheme.primaryBlue,
                  ),
                ),

                //  MARK:- Secondary Button (Right)
                if (secondaryButtonText != null) ...[
                  SizedBox(width: 8.w), // Gap: 8px

                  Expanded(
                    child: SizedBox(
                      height: 48.h, // Fixed Height: 48
                      child: OutlinedButton(
                        onPressed: onSecondaryPressed ?? () => context.pop(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(8), // Padding: 8px
                          side: BorderSide(
                            color: colorTheme.primaryBlue,
                            width: 1.5, // BorderWidth: 1.5px
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ), // Radius: 20px
                          ),
                        ),
                        child: Text(
                          secondaryButtonText!,
                          style: AppTextStyles.semiBold16().copyWith(
                            color: colorTheme.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
