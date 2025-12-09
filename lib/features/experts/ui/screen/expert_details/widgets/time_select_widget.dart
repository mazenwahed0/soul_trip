import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';

class TimeSelector extends StatefulWidget {
  final List<String> times;
  final Function(String) onSelected;

  const TimeSelector({
    super.key,
    required this.times,
    required this.onSelected,
  });

  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String selectedTime = "";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.h, // Height for chips
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.times.length,
        separatorBuilder: (context, index) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final time = widget.times[index];
          final bool isSelected = selectedTime == time;

          return Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTime = time;
                });
                widget.onSelected(time);
              },
              child: Container(
                constraints: BoxConstraints(minWidth: 52.w),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? ColorTheme().primaryBlue
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(19.r),
                ),
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF262626),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
