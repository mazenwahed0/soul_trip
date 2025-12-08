import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class HeaderOfDetails extends StatelessWidget {
  const HeaderOfDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            decoration: BoxDecoration(
              color: ColorTheme().grayVeryLight,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          Text("Expert Details", style: AppTextStyles.semiBold20()),
          Container(child: Icon(Soultrip.chatRounded)),
        ],
      ),
    );
  }
}
