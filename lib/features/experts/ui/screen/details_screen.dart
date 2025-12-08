import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';

import 'package:soul_trip/features/experts/data/repo/BookingRepository.dart';
import 'package:soul_trip/features/experts/data/repo/experts_repository.dart';
import 'package:soul_trip/features/experts/logic/booking/booking_cubit.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ExpertdetailsView%20widget.dart';

class DetailsScreen extends StatelessWidget {
  final String expertId;

  const DetailsScreen({super.key, required this.expertId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpertCubit(
        repo: ExpertsRepository(firestore: FirebaseFirestore.instance),
      )..getExpertById(expertId),
      child: Scaffold(
        body: BlocBuilder<ExpertCubit, ExpertState>(
          builder: (context, state) {
            if (state is ExpertLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ExpertLoaded) {
              final ExpertModel expert = state.expert.first;

              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        DateCubit(initialDate: DateTime.now(), expert: expert),
                  ),
                  BlocProvider(
                    create: (_) => BookingCubit(BookingRepository()),
                  ),
                ],
                child: CustomScrollView(
                  slivers: [ExpertdetailsView(expert: expert)],
                ),
              );
            }

            if (state is ExpertError) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text("Error loading expert"));
          },
        ),
      ),
    );
  }
}
