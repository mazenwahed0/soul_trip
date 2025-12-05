import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/review_model.dart';
import 'package:soul_trip/core/repositories/keys.dart';
import 'package:soul_trip/core/repositories/storage/cloudinary_service.dart';

class ReviewsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryService _cloudinaryService;
  final String _collection = 'reviews';

  ReviewsRepository(this._cloudinaryService);

  /// Stream all reviews ordered by time
  Stream<Either<Failure, List<ReviewModel>>> streamReviews() {
    return _firestore
        .collection(_collection)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            final List<ReviewModel> reviews = [];

            for (var doc in snapshot.docs) {
              try {
                final data = doc.data();
                data['docId'] = doc.id; // Inject Doc ID
                reviews.add(ReviewModel.fromMap(data));
              } catch (e) {
                // Note: NOT failing the whole list if one review fails
                debugPrint("Error parsing review ${doc.id}: $e");
              }
            }
            return Right(reviews);
          } catch (e) {
            return Left(ServerFailure('Unexpected Error: $e'));
          }
        });
  }

  /// Add a new review with optional image upload
  Future<Either<Failure, void>> addReview({
    required String userId,
    required String name,
    required String caption,
    required String profileImage,
    File? reviewImageFile,
  }) async {
    try {
      String? imageUrl;

      // 1. Upload Image if exists
      if (reviewImageFile != null) {
        final response = await _cloudinaryService.uploadImage(
          reviewImageFile,
          Keys.reviewsFolder,
        );

        if (response.statusCode == 200) {
          imageUrl = response.data['secure_url'];
        } else {
          return const Left(ServerFailure('Failed to upload image to server'));
        }
      }

      // 2. Save to Firestore
      final reviewData = {
        'userId': userId,
        'name': name,
        'time': FieldValue.serverTimestamp(),
        'caption': caption,
        'profileImage': profileImage,
        'reviewImage': imageUrl ?? '',
        'likes': 0,
        'comments': 0,
        'shares': 0,
        'likedBy': [],
        'savedBy': [],
      };

      await _firestore.collection(_collection).add(reviewData);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? 'Firebase Error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Toggle Like Status
  Future<Either<Failure, void>> toggleLike({
    required String docId,
    required String userId,
    required bool isLiked,
  }) async {
    try {
      final docRef = _firestore.collection(_collection).doc(docId);

      if (isLiked) {
        // Unlike
        await docRef.update({
          "likes": FieldValue.increment(-1),
          "likedBy": FieldValue.arrayRemove([userId]),
        });
      } else {
        // Like
        await docRef.update({
          "likes": FieldValue.increment(1),
          "likedBy": FieldValue.arrayUnion([userId]),
        });
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update like status'));
    }
  }

  /// Toggle Save Status
  Future<Either<Failure, void>> toggleSave({
    required String docId,
    required String userId,
    required bool isSaved,
  }) async {
    try {
      final docRef = _firestore.collection(_collection).doc(docId);

      await docRef.update({
        "savedBy": isSaved
            ? FieldValue.arrayRemove([userId])
            : FieldValue.arrayUnion([userId]),
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update save status'));
    }
  }
}
