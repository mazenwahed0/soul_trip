import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/exports.dart';
import '../../../../core/errors/failures.dart';

class CategoryTripsLikesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Helper to catch exceptions and return Failure
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      final result = await body();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(CFirebaseException(e.code).message));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }

  /// Like a trip for a specific user
  Future<Either<Failure, void>> likeTrip(String userId, String tripId) async {
    // If user is anonymous, do nothing
    if (userId == 'anonymous') {
      return const Right(null);
    }

    return _guard(() async {
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('likes')
          .doc('trips')
          .collection('trips')
          .doc(tripId)
          .set({'likedAt': FieldValue.serverTimestamp(), 'tripId': tripId});
    });
  }

  /// Unlike a trip for a specific user
  Future<Either<Failure, void>> unlikeTrip(String userId, String tripId) async {
    // If user is anonymous, do nothing
    if (userId == 'anonymous') {
      return const Right(null);
    }

    return _guard(() async {
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('likes')
          .doc('trips')
          .collection('trips')
          .doc(tripId)
          .delete();
    });
  }

  /// Check if a trip is liked by the user
  Future<Either<Failure, bool>> isTripLiked(
    String userId,
    String tripId,
  ) async {
    // If user is anonymous, return false
    if (userId == 'anonymous') {
      return Right(false);
    }

    try {
      final docRef = _firestore
          .collection('Users')
          .doc(userId)
          .collection('likes')
          .doc('trips')
          .collection('trips')
          .doc(tripId);

      final docSnapshot = await docRef.get();
      return Right(docSnapshot.exists);
    } catch (e) {
      return Left(ServerFailure('Failed to check trip like status'));
    }
  }

  /// Get real-time stream of liked trips for a user
  Stream<Map<String, bool>> getLikesStream(String userId) {
    if (userId == 'anonymous') {
      return Stream.value({});
    }

    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('likes')
        .doc('trips')
        .collection('trips')
        .snapshots()
        .map((snapshot) {
          final likes = <String, bool>{};
          for (final doc in snapshot.docs) {
            likes[doc.id] = true;
          }
          return likes;
        });
  }
}
