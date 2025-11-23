import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';

import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ExpertdetailsView.dart';

class Expertdetails extends StatelessWidget {
  const Expertdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DateCubit(DateTime.now()),
      child: ExpertdetailsView(),
    );
  }
}
