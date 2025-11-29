import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/banner_model.dart';

class BannerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'banners';

  /// Fetch all banners from Firebase
  Future<Either<Failure, List<BannerModel>>> fetchBanners() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection(_collection)
          .get();

      final banners = snapshot.docs.map((doc) {
        return BannerModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();

      return Right(banners);
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firebase error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch banners: $e'));
    }
  }

  /// Stream banners for real-time updates
  Stream<Either<Failure, List<BannerModel>>> streamBanners() {
    try {
      return _firestore.collection(_collection).snapshots().map((snapshot) {
        try {
          final banners = snapshot.docs.map((doc) {
            return BannerModel.fromFirestore(doc.data(), doc.id);
          }).toList();
          return Right<Failure, List<BannerModel>>(banners);
        } catch (e) {
          return Left<Failure, List<BannerModel>>(
            UnknownFailure('Error parsing banners: $e'),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        Left<Failure, List<BannerModel>>(
          UnknownFailure('Failed to stream banners: $e'),
        ),
      );
    }
  }
}
