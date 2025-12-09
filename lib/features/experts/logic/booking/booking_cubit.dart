import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:soul_trip/features/experts/data/repo/booking_repository.dart';
import 'package:soul_trip/features/experts/logic/booking/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository bookingRepository;

  BookingCubit(this.bookingRepository) : super(BookingInitial());

  /// check booking availability
  Future<void> checkBooking({
    required String expertId,
    required DateTime date,
    required String time,
  }) async {
    emit(BookingChecking());

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final isTaken = await bookingRepository.isBooked(
      expertId: expertId,
      date: formattedDate,
      time: time,
    );

    if (isTaken) {
      emit(BookingAlreadyReserved());
    } else {
      emit(BookingAvailable());
    }
  }

  /// book appointment
  Future<void> confirmBooking({
    required String expertId,
    required String expertName,
    required DateTime date,
    required String time,
    required String mode,
  }) async {
    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);

      await bookingRepository.bookAppointment(
        expertId: expertId,
        expertName: expertName,
        date: formattedDate,
        time: time,
        mode: mode,
      );

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingFailed(e.toString()));
    }
  }
}
