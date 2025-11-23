import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/experience_review.dart';
import 'package:soul_trip/features/experts/ui/widgets/stars_widget.dart';

class Aboutdoctor extends StatelessWidget {
  const Aboutdoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ColorTheme().whiteColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(16),
              color: ColorTheme().whiteColor.withOpacity(0.5),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "D/ Sarah Yousef",
                        style: AppTextStyles.medium16().copyWith(
                          color: ColorTheme().blackColor,
                        ),
                      ),
                      Text(
                        "Luxor",
                        style: AppTextStyles.regular12().copyWith(
                          color: ColorTheme().grayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                StarsWidget(),
              ],
            ),
          ),
          ExperienceReview(),
        ],
      ),
    );
  }
}
