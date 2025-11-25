import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';
import 'package:soul_trip/features/experts/ui/widgets/ExpertItem.dart';

class ExpertsListview extends StatelessWidget {
  const ExpertsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertCubit, ExpertState>(
      builder: (context, state) {
        if (state is ExpertLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExpertLoaded) {
          final experts = state.expert;
          return ListView.builder(
            itemCount: experts.length,
            itemBuilder: (context, index) {
              final expert = experts[index];
              return ExpertItem(expertModel: expert);
            },
          );
        } else if (state is ExpertError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
