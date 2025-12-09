import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime currentMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onPrevMonth;

  const CalendarHeader({
    super.key,
    required this.currentMonth,
    required this.onNextMonth,
    required this.onPrevMonth,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMMM yyyy');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Month Year Text
        Row(
          children: [
            Text(
              dateFormat.format(currentMonth),
              style: AppTextStyles.semiBold18().copyWith(
                color: Colors.black,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: ColorTheme().primaryBlue,
            ),
          ],
        ),

        // Navigation Arrows
        Row(
          children: [
            _buildArrowButton(icon: Icons.arrow_back_ios, onTap: onPrevMonth),
            SizedBox(width: 8.w),
            _buildArrowButton(
              icon: Icons.arrow_forward_ios,
              onTap: onNextMonth,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Icon(icon, size: 18.sp, color: ColorTheme().primaryBlue),
      ),
    );
  }
}
