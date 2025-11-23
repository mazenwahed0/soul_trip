import 'package:flutter/material.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Soultrip.goldstar, color: ColorTheme().primaryYellow, size: 24),
        SizedBox(width: 4),
        Text("4.5", style: AppTextStyles.medium14()),
      ],
    );
  }
}
