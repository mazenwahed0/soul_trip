abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingChecking extends BookingState {}

class BookingAvailable extends BookingState {}

class BookingAlreadyReserved extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingFailed extends BookingState {
  final String message;
  BookingFailed(this.message);
}
