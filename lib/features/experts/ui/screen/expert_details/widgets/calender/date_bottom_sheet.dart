import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'calendar_grid.dart';
import 'calendar_header.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateConfirmed;
  final List<int> allowedWeekDays;

  const DatePickerBottomSheet({
    super.key,
    required this.initialDate,
    required this.onDateConfirmed,
    required this.allowedWeekDays,
  });

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  late DateTime _currentMonth;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _changeMonth(int increment) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + increment,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520.h,
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          // 1. Header
          CalendarHeader(
            currentMonth: _currentMonth,
            onNextMonth: () => _changeMonth(1),
            onPrevMonth: () => _changeMonth(-1),
          ),

          SizedBox(height: 24.h),

          // 2. Week Days (Static Row)
          _buildWeekDaysRow(),

          SizedBox(height: 12.h),

          // 3. Grid
          Expanded(
            child: CalendarGrid(
              currentMonth: _currentMonth,
              selectedDate: _selectedDate,
              allowedWeekDays: widget.allowedWeekDays,
              onDateSelected: (date) {
                setState(() => _selectedDate = date);
              },
            ),
          ),

          Divider(color: Colors.grey.shade200, height: 32.h),

          // 4. Confirm Button
          PrimaryShadowButton(
            text: "Confirm Date",
            onPressed: () {
              widget.onDateConfirmed(_selectedDate);
              Navigator.pop(context);
            },
            backgroundColor: const Color(0xFF003566),
            height: 56,
            radius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDaysRow() {
    final days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (day) => SizedBox(
              width: 40.w,
              child: Center(
                child: Text(
                  day,
                  style: AppTextStyles.medium12().copyWith(
                    color: const Color(0xFFBDBDBD),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
