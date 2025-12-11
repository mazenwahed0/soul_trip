import 'package:flutter/material.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key, required this.rating});
  final String rating;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Soultrip.goldstar, color: ColorTheme().primaryYellow, size: 24),
        widthSpace( 4),
        Text(rating, style: AppTextStyles.medium14()),
      ],
    );
  }
}
