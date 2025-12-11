import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/app_chip.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class LocationSection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  LocationSection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Location"),
        Wrap(
          spacing: 8,
          children: ["Luxor", "Giza", "Aswan", "Siwa"]
              .map(
                (loc) => AppChip(
                  label: loc,
                  selected: filter.location == loc,
                  onTap: () => cubit.setLocation(loc),
                  selectedColor: Color(0xFF0D2C5E),
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  textColor: filter.location == loc
                      ? Colors.white
                      : Colors.black87,
                ),
              )
              .toList(),
        ),
        heightSpace(20),
      ],
    );
  }
}
