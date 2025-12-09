import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/ui/screen/expert_details/expert_details_view.dart';

class ModeSelectorWidget extends StatelessWidget {
  final Mode? selectedMode;
  final ValueChanged<Mode?> onChanged;
  final int price;

  const ModeSelectorWidget({
    super.key,
    required this.price,
    required this.selectedMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Session Type", style: AppTextStyles.medium16()),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Online Option
            _buildCustomRadio(
              label: "Online",
              value: Mode.online,
              groupValue: selectedMode,
              onTap: () => onChanged(Mode.online),
            ),
            // In Person Option
            _buildCustomRadio(
              label: "In Person",
              value: Mode.inPerson,
              groupValue: selectedMode,
              onTap: () => onChanged(Mode.inPerson),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Session Price", style: AppTextStyles.medium16()),
            Text(
              "\$$price",
              style: AppTextStyles.medium16().copyWith(
                fontWeight: FontWeight.w600,
                color: ColorTheme().primaryBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomRadio({
    required String label,
    required Mode value,
    required Mode? groupValue,
    required VoidCallback onTap,
  }) {
    final isSelected = value == groupValue;
    final primaryBlue = ColorTheme().primaryBlue; // #003566

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Custom Radio Container: 24x24
          Container(
            width: 24.w,
            height: 24.w,
            padding: EdgeInsets.all(5.w), // Padding to center the inner dot
            decoration: BoxDecoration(
              shape: BoxShape
                  .circle, // Radius 14px effectively creates a circle for this size
              color: Colors.white,
              border: Border.all(
                // Border 1px solid #003566
                color: isSelected ? primaryBlue : const Color(0xFFD9D9D9),
                width: 1.w,
              ),
            ),
            child: isSelected
                ? Container(
                    // Inner Dot: 13x13 (approx via padding)
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryBlue,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.regular14().copyWith(
              color: const Color(0xFF000814),
            ),
          ),
        ],
      ),
    );
  }
}
