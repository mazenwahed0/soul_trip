import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';

class Taps extends StatelessWidget {

  final TabController controller;
  final List<Widget> tabs;

  const Taps({super.key, required this.controller, required this.tabs});
  @override
  Widget build(BuildContext context) {  
    return TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor:ColorTheme().blackColor ,
      labelColor: ColorTheme().blackColor,
      unselectedLabelColor: ColorTheme().grayDark,
    );
  }

}
