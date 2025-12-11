import 'package:flutter/material.dart';

import 'package:soul_trip/core/theme/text_style.dart';

class ExperienceReview extends StatelessWidget {
  final int years;
  final int reviews;
  final num fees;

  const ExperienceReview({
    super.key,
    required this.years,
    required this.reviews,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _item("+${years}y", "Experience"),
            _item("+$fees", "Fees"),
            _item("+$reviews", "Reviews"),
          ],
        ),
      ),
    );
  }

  Widget _item(String val, String label) {
    return Column(
      children: [
        Text(val, style: AppTextStyles.medium16()),
        Text(label, style: AppTextStyles.regular12()),
      ],
    );
  }
}
