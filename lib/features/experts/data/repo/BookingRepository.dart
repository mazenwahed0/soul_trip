import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// check if time is already booked
  Future<bool> isBooked({
    required String expertId,
    required String date,
    required String time,
  }) async {
    final snapshot = await firestore
        .collection('bookings')
        .where('expertId', isEqualTo: expertId)
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  /// add new booking
  Future<void> bookAppointment({
    required String expertId,
    required String expertName,
    required String date,
    required String time,
    required String mode,
  }) async {
    await firestore.collection('bookings').add({
      'expertId': expertId,
      'expertName': expertName,
      'date': date,
      'time': time,
      'mode': mode,
      'createdAt': Timestamp.now(),
    });
  }
}
