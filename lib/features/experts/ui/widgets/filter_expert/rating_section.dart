import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/app_chip.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class RatingSection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  RatingSection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Rating"),
        Wrap(
          spacing: 8,
          children: [
            AppChip(
              label: "All Rating",
              selected: filter.minRating == 0 || filter.minRating == null,
              onTap: () => cubit.setRating(0),
            ),
            AppChip(
              label: "4 and above",
              selected: filter.minRating == 4,
              onTap: () => cubit.setRating(4),
            ),
            AppChip(
              label: "4.5 and above",
              selected: filter.minRating == 4.5,
              onTap: () => cubit.setRating(4.5),
            ),
          ],
        ),
        heightSpace( 20),
      ],
    );
  }
}
