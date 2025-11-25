import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/experts/data/repo/experts_repository.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_cubit.dart';
import 'package:soul_trip/features/experts/ui/widgets/expertBody.dart';

class ExpertsScreen extends StatelessWidget {
  const ExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme().whiteColor,
        title: Text(
          'Experts',
          style: TextStyle(color: ColorTheme().blackColor),
        ),
      ),
      body: BlocProvider(
        create: (context) => ExpertCubit(
          repo: ExpertsRepository(firestore: FirebaseFirestore.instance),
        )..listenToexpert(),
        child: Expertbody(),
      ),
    );
  }
}
