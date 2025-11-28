import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';

class HomeTripsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'HomeTrips';

  Future<Either<Failure, List<HomeTripModel>>> fetchTrips() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();

      final trips = snapshot.docs
          .map((doc) => HomeTripModel.fromFirestore(doc))
          .toList();

      return Right(trips);
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firebase error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch home trips: $e'));
    }
  }

  Stream<Either<Failure, List<HomeTripModel>>> streamTrips() {
    try {
      return _firestore.collection(_collection).snapshots().map((snapshot) {
        try {
          final trips = snapshot.docs
              .map((doc) => HomeTripModel.fromFirestore(doc))
              .toList();
          return Right<Failure, List<HomeTripModel>>(trips);
        } catch (e) {
          return Left<Failure, List<HomeTripModel>>(
            UnknownFailure('Error parsing home trips: $e'),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        Left<Failure, List<HomeTripModel>>(
          UnknownFailure('Failed to stream home trips: $e'),
        ),
      );
    }
  }
}
