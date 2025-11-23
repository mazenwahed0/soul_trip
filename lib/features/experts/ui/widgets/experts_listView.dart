import 'package:flutter/material.dart';
import 'package:soul_trip/features/experts/ui/widgets/ExpertItem.dart';

class ExpertsListview extends StatelessWidget {
  const ExpertsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ExpertItem();
      },
    );
  }
}
