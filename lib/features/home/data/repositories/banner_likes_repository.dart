import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/exports.dart';
import '../../../../core/errors/failures.dart';

class BannerLikesRepository {
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

  /// Like a banner for a specific user
  Future<Either<Failure, void>> likeBanner(
    String userId,
    String bannerId,
  ) async {
    print('BannerLikesRepository: Liking banner $bannerId for user $userId');

    // If user is anonymous, do nothing
    if (userId == 'anonymous') {
      print('BannerLikesRepository: Anonymous user, skipping like');
      return const Right(null);
    }

    return _guard(() async {
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('likes')
          .doc('banner')
          .collection('banners')
          .doc(bannerId)
          .set({'likedAt': FieldValue.serverTimestamp(), 'bannerId': bannerId});

      print('BannerLikesRepository: Like operation completed successfully');
    });
  }

  /// Unlike a banner for a specific user
  Future<Either<Failure, void>> unlikeBanner(
    String userId,
    String bannerId,
  ) async {
    print('BannerLikesRepository: Unliking banner $bannerId for user $userId');

    // If user is anonymous, do nothing
    if (userId == 'anonymous') {
      print('BannerLikesRepository: Anonymous user, skipping unlike');
      return const Right(null);
    }

    return _guard(() async {
      await _firestore
          .collection('Users')
          .doc(userId)
          .collection('likes')
          .doc('banner')
          .collection('banners')
          .doc(bannerId)
          .delete();

      print('BannerLikesRepository: Unlike operation completed successfully');
    });
  }

  /// Check if a banner is liked by the user
  Future<Either<Failure, bool>> isBannerLiked(
    String userId,
    String bannerId,
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
          .doc('banner')
          .collection('banners')
          .doc(bannerId);
      final docSnapshot = await docRef.get();
      return Right(docSnapshot.exists);
    } catch (e) {
      return Left(ServerFailure('Failed to check banner like status'));
    }
  }

  /// Get real-time stream of liked banners for a user
  Stream<Map<String, bool>> getLikesStream(String userId) {
    if (userId == 'anonymous') {
      return Stream.value({});
    }

    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('likes')
        .doc('banner')
        .collection('banners')
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
