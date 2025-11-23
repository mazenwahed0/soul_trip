import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class DatePickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateConfirmed;

  const DatePickerBottomSheet({
    super.key,
    required this.initialDate,
    required this.onDateConfirmed,
  });

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  late DateTime tempSelectedDate;
  @override
  void initState() {
    super.initState();
    tempSelectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorTheme().whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Text("Select Date", style: AppTextStyles.semiBold24()),
          heightSpace(16),
          Expanded(
            child: CalendarDatePicker(
              initialDate: tempSelectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2050),
              onDateChanged: (date) => setState(() => tempSelectedDate = date),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTheme().primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              widget.onDateConfirmed(tempSelectedDate);
              Navigator.pop(context);
            },
            child: Text(
              "Confirm",
              style: AppTextStyles.semiBold16().copyWith(
                color: ColorTheme().whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
