import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/date_state.dart';
import 'datebuttomsheet.dart';

class DateSelectorWidget extends StatelessWidget {
  final ValueChanged<DateTime>? onDateSelected;

  const DateSelectorWidget({super.key, this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, DateState>(
      builder: (context, state) {
        final selectedDate = state.selectedDate;
        final allowedWeekDays = context.read<DateCubit>().allowedWeekDays;

        final formattedDate = DateFormat('d MMMM').format(selectedDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Choose Date", style: AppTextStyles.medium16()),
                IconButton(
                  onPressed: () {
                    context.read<DateCubit>().updateDate(selectedDate);

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      builder: (_) => DatePickerBottomSheet(
                        initialDate: selectedDate,
                        allowedWeekDays: allowedWeekDays,
                        onDateConfirmed: (date) {
                          context.read<DateCubit>().updateDate(date);
                          if (onDateSelected != null) onDateSelected!(date);
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Soultrip.calendarBold,
                    color: ColorTheme().primaryBlue,
                  ),
                ),
              ],
            ),
            Text(formattedDate, style: AppTextStyles.regular14()),
          ],
        );
      },
    );
  }
}
