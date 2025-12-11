import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/ui/widgets/filter_expert/widget_filter_experts.dart';

class FilterExpertsWrapper extends StatelessWidget {
  final List<ExpertModel> allExperts;

  const FilterExpertsWrapper({required this.allExperts, super.key});

  @override
  Widget build(BuildContext context) {
    final expertCubit = context.read<ExpertCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: expertCubit,  // use the same original cubit
        ),
        BlocProvider(
          create: (_) => ExpertFilterCubit(allExperts: allExperts),
        ),
      ],
      child: FilterExpertsScreen(),
    );
  }
}
