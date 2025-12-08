
abstract class DateState {
  final DateTime selectedDate;
  const DateState(this.selectedDate);
}

class DateInitial extends DateState {
  DateInitial(DateTime date) : super(date);
}

class DateUpdated extends DateState {
  DateUpdated(DateTime date) : super(date);
}

class DateError extends DateState {
  final String message;
  DateError(this.message, DateTime date) : super(date);
}
