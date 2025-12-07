import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';

import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';

import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/stars_widget.dart';

class ExpertItem extends StatelessWidget {
  ExpertItem({super.key, required this.expertModel});
  final ExpertModel expertModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push('${Routes.expertsDetailsView}?id=${expertModel.id}');
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
                    ClipOval(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(expertModel.image),
                        ),
                      ),
                    ),
                    heightSpace(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            expertModel.name,
                            style: AppTextStyles.medium16().copyWith(
                              color: ColorTheme().blackColor,
                            ),
                          ),

                          Text(
                            expertModel.location,
                            style: AppTextStyles.regular12().copyWith(
                              color: ColorTheme().grayMedium,
                            ),
                          ),
                          heightSpace(4),
                          Text(
                            "${expertModel.price.toString()} \$/ hr",
                            style: AppTextStyles.semiBold20(),
                          ),
                        ],
                      ),
                    ),
                    widthSpace(8),
                    StarsWidget(rating: expertModel.rating.toString()),
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
                        expertModel.specialization,
                        style: AppTextStyles.medium12().copyWith(
                          color: ColorTheme().whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 60,),
                    Expanded(
                      child: PrimaryShadowButton(
                        text: "Book Now",
                        onPressed: () {
                          GoRouter.of(context).push(
                            '${Routes.expertsDetailsView}?id=${expertModel.id}',
                          );
                        },
                      ),
                    ),
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
