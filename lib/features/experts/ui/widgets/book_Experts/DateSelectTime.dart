import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/datebuttomsheet.dart';

class DateSelectorWidget extends StatelessWidget {
  const DateSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateCubit, DateTime>(
      builder: (context, selectedDate) {
        final formattedDate = DateFormat('d MMMM').format(selectedDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("choose Date", style: AppTextStyles.medium16()),
                IconButton(
                  onPressed: () {
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
                        onDateConfirmed: (date) =>
                            context.read<DateCubit>().updateDate(date),
                      ),
                    );
                  },
                  icon: Icon(
                    Soultrip.calendar_bold,
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
