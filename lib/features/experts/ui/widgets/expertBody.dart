import 'package:flutter/material.dart';

import 'package:soul_trip/features/experts/ui/widgets/experts_listView.dart';
import 'package:soul_trip/features/experts/ui/widgets/SearchBarWidget.dart';

class Expertbody extends StatelessWidget {
  const Expertbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(),
        Expanded(child: ExpertsListview()),
      ],
    );
  }
}
