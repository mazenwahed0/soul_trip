import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/app_radio.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class AvailabilitySection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  AvailabilitySection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    final today = dayName(DateTime.now().weekday);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Availability"),
        Row(
          children: [
            AppRadio(
              label: "Available Today",
              selected: (filter.availabilityDays ?? []).contains(today),
              onTap: () => cubit.setAvailableDays([today]),
            ),
            widthSpace( 16),
            AppRadio(
              label: "Available This Week",
              selected: (filter.availabilityDays?.length ?? 0) == 7,
              onTap: () => cubit.setAvailableDays([
                "Sunday", "Monday", "Tuesday", "Wednesday",
                "Thursday", "Friday", "Saturday",
              ]),
            ),
          ],
        ),
        heightSpace( 30),
      ],
    );
  }
}
