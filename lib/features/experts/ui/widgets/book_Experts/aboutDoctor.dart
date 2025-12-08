import 'package:flutter/material.dart';

import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';

import 'package:soul_trip/features/experts/ui/widgets/book_Experts/experience_review.dart';
import 'package:soul_trip/features/experts/ui/widgets/stars_widget.dart';

class Aboutdoctor extends StatelessWidget {
  final ExpertModel expert;

  const Aboutdoctor({super.key, required this.expert});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),

              color: Colors.white.withOpacity(0.7),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expert.name, style: AppTextStyles.medium16()),

                    Text(expert.location, style: AppTextStyles.regular12()),
                  ],
                ),
                StarsWidget(rating: expert.rating.toString()),
              ],
            ),
          ),

          ExperienceReview(
            years: expert.experienceYears,
            reviews: expert.reviewsCount,
            fees: expert.fees,
          ),
        ],
      ),
    );
  }
}
