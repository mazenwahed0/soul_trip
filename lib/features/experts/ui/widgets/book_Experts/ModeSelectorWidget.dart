import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ExpertdetailsView.dart';

class ModeSelectorWidget extends StatelessWidget {
  final Mode? selectedMode;
  final ValueChanged<Mode?> onChanged;

  const ModeSelectorWidget({
    super.key,
    required this.selectedMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("session type", style: AppTextStyles.medium16()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Radio<Mode>(
                  value: Mode.online,
                  groupValue: selectedMode,
                  onChanged: onChanged,
                ),
                Text("Online"),
              ],
            ),
            Row(
              children: [
                Radio<Mode>(
                  value: Mode.inPerson,
                  groupValue: selectedMode,
                  onChanged: onChanged,
                ),
                Text("In-Person"),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Session Price", style: AppTextStyles.medium16()),
            const SizedBox(height: 4),
            Text(
              "100 LE",
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
}
