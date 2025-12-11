import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_state.dart';

import 'package:soul_trip/features/experts/ui/widgets/filter_expert/action_buttons_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/availability_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/budget_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/category_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/location_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/rating_section.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/session_type_section.dart';

class FilterExpertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),

        title: Text("Filter Experts", style: TextStyle(color: Colors.black)),
        elevation: 0.5,
        backgroundColor: ColorTheme().whiteColor,
      ),
      body: BlocBuilder<ExpertFilterCubit, ExpertFilterState>(
        builder: (context, state) {
          final cubit = context.read<ExpertFilterCubit>();
          final filter = cubit.filter;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SessionTypeSection(cubit, filter),
                LocationSection(cubit, filter),
                CategorySection(cubit, filter),
                BudgetSection(cubit, filter),
                RatingSection(cubit, filter),
                AvailabilitySection(cubit, filter),
                ActionButtonsSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}
