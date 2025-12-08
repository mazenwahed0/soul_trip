import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/app_chip.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class CategorySection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  CategorySection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    final categories = [
      "wellnessCoach",
      "Relaxation Expert",
      "Yoga Instructor",
      "Psychologist",
      "Physical Therapist",
      "Spa Therapist",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Category"),
        Wrap(
          spacing: 8,
          children: categories
              .map(
                (c) => AppChip(
                  label: c,
                  selected: filter.specialization == c,
                  onTap: () => cubit.setSpecialization(c),
                ),
              )
              .toList(),
        ),
        heightSpace( 20),
      ],
    );
  }
}
