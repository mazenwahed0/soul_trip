import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeaderWidget({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold18().copyWith(color: colors.blackColor),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See All',
              style: AppTextStyles.medium14().copyWith(
                color: colors.grayMedium,
              ),
            ),
          ),
      ],
    );
  }
}
