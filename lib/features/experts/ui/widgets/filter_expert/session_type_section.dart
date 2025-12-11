import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/app_radio.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class SessionTypeSection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  SessionTypeSection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Session Type"),
        Row(
          children: [
            AppRadio(
              label: "Online",
              selected: filter.sessionType == "online",
              onTap: () => cubit.setSessionType("online"),
              size: 22,
            ),
            SizedBox(width: 20),
            AppRadio(
              label: "In Person",
              selected: filter.sessionType == "offline",
              onTap: () => cubit.setSessionType("offline"),
              size: 22,
            ),
          ],
        ),
        heightSpace(20),
      ],
    );
  }
}
