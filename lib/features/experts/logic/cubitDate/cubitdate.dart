import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_state.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';

class DateCubit extends Cubit<DateState> {
  final List<int> allowedWeekDays;

  DateCubit({required DateTime initialDate, required ExpertModel expert})
    : allowedWeekDays = convertDays(expert.availabilityDays),
      super(
        DateInitial(
          _correctDate(initialDate, convertDays(expert.availabilityDays)),
        ),
      );

  static List<int> convertDays(List<String> days) {
    const map = {
      "sunday": 7,
      "monday": 1,
      "tuesday": 2,
      "wednesday": 3,
      "thursday": 4,
      "friday": 5,
      "saturday": 6,
    };
    return days.map((d) => map[d.toLowerCase()]!).toList();
  }

  DateTime getFirstAvailableDayfromtoday() {
    DateTime now = DateTime.now();
    for (int i = 0; i <= 60; i++) {
      final day = now.add(Duration(days: i));
      if (allowedWeekDays.contains(day.weekday)) return day;
    }
    return now;
  }

  static DateTime _correctDate(DateTime date, List<int> allowedDays) {
    DateTime now = DateTime.now();
    if (date.isBefore(now)) date = now;

    while (!allowedDays.contains(date.weekday)) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  void updateDate(DateTime newDate) {
    // Make sure the new date is allowed
    if (!allowedWeekDays.contains(newDate.weekday) ||
        newDate.isBefore(DateTime.now())) {
      newDate = getFirstAvailableDayfromtoday();
    }
    emit(DateUpdated(newDate));
  }
}
