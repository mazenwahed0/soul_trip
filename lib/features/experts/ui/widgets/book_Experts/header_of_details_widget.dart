
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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ColorTheme().grayVeryLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 28,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          Text("Expert Details", style: AppTextStyles.semiBold20()),

         
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: ColorTheme().grayVeryLight,
              shape: BoxShape.circle,
            ),
            child: const Center(child: Icon(Soultrip.chatRounded, size: 28)),
          ),
        ],
      ),
    );
  }
}
