import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class Taps extends StatelessWidget {
  final TabController controller;
  final List<Widget> tabHeaders;

  const Taps({
    super.key,
    required this.controller,
    required this.tabHeaders,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      tabs: tabHeaders,
      indicatorColor: ColorTheme().blackColor,
      labelColor: ColorTheme().blackColor,
      unselectedLabelColor: ColorTheme().grayDark,
      labelStyle: AppTextStyles.semiBold16(),
      unselectedLabelStyle: AppTextStyles.semiBold16(),
      
    );
  }
}

