import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/helpers.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class BudgetSection extends StatelessWidget {
  final ExpertFilterCubit cubit;
  final ExpertFilterModel filter;

  BudgetSection(this.cubit, this.filter);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Budget"),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: ColorTheme().primaryYellow,
            inactiveTrackColor: ColorTheme().grayLight,
            thumbColor: ColorTheme().primaryYellow,
          ),
          child: Slider(
            min: 100,
            max: 200,
            value: filter.maxPrice ?? 100,
            divisions: 9,
            onChanged: cubit.setPrice,
          ),
        ),

        SizedBox(height: 6),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("100 \$", style: TextStyle(fontSize: 11)),
            Text(
              "${filter.maxPrice?.toInt() ?? 100} \$",
              style: TextStyle(fontSize: 11),
            ),
            Text("200 \$", style: TextStyle(fontSize: 11)),
          ],
        ),

        heightSpace(20),
      ],
    );
  }
}
