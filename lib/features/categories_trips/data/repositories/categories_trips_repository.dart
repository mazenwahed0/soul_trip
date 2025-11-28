import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/category_trip_model.dart';

class CategoriesTripsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'CategoriesTrips';

  Future<Either<Failure, List<CategoryTripModel>>> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();
      final categories = snapshot.docs
          .map((doc) => CategoryTripModel.fromMap(doc.data(), doc.id))
          .toList();
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(ServerFailure('Firebase error: ${e.message}'));
    } catch (e) {
      return Left(UnknownFailure('Failed to fetch categories: $e'));
    }
  }

  Stream<Either<Failure, List<CategoryTripModel>>> streamCategories() {
    try {
      return _firestore.collection(_collection).snapshots().map((snapshot) {
        try {
          final categories = snapshot.docs
              .map((doc) => CategoryTripModel.fromMap(doc.data(), doc.id))
              .toList();
          return Right<Failure, List<CategoryTripModel>>(categories);
        } catch (e) {
          return Left<Failure, List<CategoryTripModel>>(
            UnknownFailure('Error parsing categories: $e'),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        Left<Failure, List<CategoryTripModel>>(
          UnknownFailure('Failed to stream categories: $e'),
        ),
      );
    }
  }
}
