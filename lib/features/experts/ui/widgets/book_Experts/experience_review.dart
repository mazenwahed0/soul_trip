import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class ExperienceReview extends StatelessWidget {
  const ExperienceReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorTheme().whiteColor.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "+4y",
                  style: AppTextStyles.medium16().copyWith(
                    color: ColorTheme().blackColor,
                  ),
                ),
                Text(
                  "Experience",
                  style: AppTextStyles.regular12().copyWith(
                    color: ColorTheme().grayMedium,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("+20", style: AppTextStyles.medium16()),
                Text(
                  "Fees",
                  style: AppTextStyles.regular12().copyWith(
                    color: ColorTheme().grayMedium,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("+100", style: AppTextStyles.medium16()),
                Text(
                  "Reviews",
                  style: AppTextStyles.regular12().copyWith(
                    color: ColorTheme().grayMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
