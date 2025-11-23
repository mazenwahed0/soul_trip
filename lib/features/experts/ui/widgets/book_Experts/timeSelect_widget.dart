import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';


class TimeSelector extends StatefulWidget {
  final Function(String) onSelected;

  const TimeSelector({super.key, required this.onSelected});

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String selectedTime = "";

  final List<String> times = ["9:00", "10:15", "12:30", "1:15", "2:30"];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: times.map((time) {
        final bool isSelected = selectedTime == time;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTime = time;
            });
            widget.onSelected(time);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? ColorTheme().primaryBlue : Colors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                color: isSelected
                    ? ColorTheme().primaryBlue
                    : ColorTheme().grayDark,
                width: 1.3,
              ),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
