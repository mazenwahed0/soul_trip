import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';

import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/custom_button.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/stars_widget.dart';

class ExpertItem extends StatelessWidget {
  const ExpertItem({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(Routes.expertsDetailsView);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/doctor.png"),
                    ),
                    heightSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doctor Sarah Yousef",
                            style: AppTextStyles.medium16().copyWith(
                              color: ColorTheme().blackColor,
                            ),
                          ),
                          heightSpace(4),
                          Text(
                            "Luxor",
                            style: AppTextStyles.regular12().copyWith(
                              color: ColorTheme().grayMedium,
                            ),
                          ),
                          heightSpace(4),
                          Text(
                            "Price: \$100",
                            style: AppTextStyles.semiBold20(),
                          ),
                        ],
                      ),
                    ),
                    widthSpace(8),
                    StarsWidget(),
                  ],
                ),
                heightSpace(12),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorTheme().grayMedium,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "Yoga instructor",
                        style: AppTextStyles.medium12().copyWith(
                          color: ColorTheme().whiteColor,
                        ),
                      ),
                    ),
                    Expanded(child: CustomButton(text: "Meditation")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
