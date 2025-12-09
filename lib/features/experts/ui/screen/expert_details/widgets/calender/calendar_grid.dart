import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final List<int> allowedWeekDays;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.selectedDate,
    required this.allowedWeekDays,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;
    final int firstWeekdayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month,
      1,
    ).weekday;

    // Offset: Mon=1...Sun=7 -> Sun=0...Sat=6
    final int offset = (firstWeekdayOfMonth == 7) ? 0 : firstWeekdayOfMonth;
    final int totalCells = daysInMonth + offset;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8.h,
        crossAxisSpacing: 0,
        childAspectRatio: 1.0,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < offset) return const SizedBox.shrink();

        final int day = index - offset + 1;
        final DateTime date = DateTime(
          currentMonth.year,
          currentMonth.month,
          day,
        );

        final bool isSelected = _isSameDay(date, selectedDate);
        final bool isToday = _isSameDay(date, DateTime.now());
        // Only allow future dates that are in the allowedWeekDays list
        final bool isAllowed =
            allowedWeekDays.contains(date.weekday) &&
            !date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

        // Styles
        const yellowColor = Color(0xFFFFC107);
        const lightYellowBg = Color(0xFFFFF8E1);

        return GestureDetector(
          onTap: isAllowed ? () => onDateSelected(date) : null,
          child: Container(
            margin: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? lightYellowBg : Colors.transparent,
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16.sp,
                  fontWeight: (isSelected || isToday)
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: isSelected
                      ? yellowColor
                      : isToday
                      ? yellowColor
                      : isAllowed
                      ? Colors.black
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
