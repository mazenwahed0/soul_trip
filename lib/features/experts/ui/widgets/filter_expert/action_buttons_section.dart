import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final expertCubit = context.read<ExpertCubit>();
    final filterCubit = context.read<ExpertFilterCubit>();

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              filterCubit.reset();
              expertCubit.emit(ExpertLoaded(expert: expertCubit.allExperts));
              Navigator.pop(context, expertCubit.allExperts);
            },
            child: Text("Reset All"),
          ),
        ),
        widthSpace(16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              final filtered = filterCubit.applyFilter();
              Navigator.pop(context, filtered);
            },
            child: Text("Apply"),
          ),
        ),
      ],
    );
  }
}
