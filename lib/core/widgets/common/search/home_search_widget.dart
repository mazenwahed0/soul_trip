import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class HomeSearchBarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String hintText;
  final bool showFilter;
  final bool autofocus;

  // Color Customization
  final Color? searchBackgroundColor;
  final Color? filterIconColor;
  final List<BoxShadow>? boxShadow;

  const HomeSearchBarWidget({
    super.key,
    this.onTap,
    this.onFilterTap,
    this.controller,
    this.onChanged,
    this.hintText = "Search",
    this.showFilter = true,
    this.autofocus = false,
    this.searchBackgroundColor,
    this.filterIconColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    final bgColor = searchBackgroundColor ?? colors.offWhite;
    final iconColor = filterIconColor ?? colors.primaryBlue;

    return Container(
      width: 343.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: bgColor, // Main background (Off-White)
        borderRadius: BorderRadius.circular(30.r), // Pill Shape
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08), // Shadow
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: Row(
        children: [
          // MARK:- Left Side: Search Icon & Text
          Expanded(
            child: GestureDetector(
              onTap: onTap, // Navigation if needed
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  SizedBox(width: 16.w),
                  Icon(
                    Soultrip.search,
                    color: colors.grayMedium, // Grey Icon
                    size: 22.sp,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    // IgnorePointer allows the GestureDetector to handle taps
                    // prevents keyboard from opening if we just want to navigate
                    child: IgnorePointer(
                      ignoring: onTap != null,
                      child: TextField(
                        controller: controller,
                        onChanged: onChanged,
                        // If we are navigating (onTap exists), disable direct editing
                        enabled: onTap == null,
                        autofocus: autofocus,
                        style: AppTextStyles.regular16().copyWith(
                          color: colors.blackColor,
                          height: 1.2,
                        ),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: AppTextStyles.regular16().copyWith(
                            color: colors.grayMedium, // Grey Text
                            height: 1.2,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // MARK:- Right Side: Filter Button (Conditional)
          if (showFilter)
            GestureDetector(
              // Use specific filter callback or default to main tap
              onTap: onFilterTap ?? onTap,
              child: Container(
                width: 56.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: colors.whiteColor,
                  border: const Border(
                    left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Center(
                  child: Icon(Soultrip.filter, color: iconColor, size: 22.sp),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
