import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class HeaderOfDetails extends StatelessWidget {
  const HeaderOfDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 44, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorTheme().grayVeryLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorTheme().primaryBlue,
                size: 25,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // Title
          Text(
            "Expert Details",
            style: AppTextStyles.semiBold20().copyWith(
              color: ColorTheme().primaryBlue,
              fontWeight: FontWeight.w700,
            ),
          ),

          // Chat Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: ColorTheme().grayVeryLight,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Soultrip.chatRounded,
                color: ColorTheme().primaryBlue,
                size: 25,
              ),
              onPressed: () {
                // TODO: Handle chat button press
              },
            ),
          ),
        ],
      ),
    );
  }
}
