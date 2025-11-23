import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';

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
      body: Expertbody(),
    );
  }
}
