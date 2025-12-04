import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/post_review_state.dart';
import '../model/write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  WriteReviewCubit() : super(WriteReviewState());

  // Firestore collection reference
  final _collection = FirebaseFirestore.instance.collection('reviews');

  Future<void> addReview({
    required String userId,
    required String name,
    required String caption,
    required String profileImage,
    String? reviewImage,
  }) async {
    // 1. Validation check
    if (caption.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ReviewStatus.error,
          errorMessage: 'The review caption cannot be empty.',
        ),
      );
      // Reset state after emitting error
      emit(WriteReviewState());
      return;
    }

    // 2. Start loading process
    emit(state.copyWith(status: ReviewStatus.loading));

    // 3. Create review model
    final newReview = Review(
      userId: userId,
      name: name,
      time: DateTime.now(),
      caption: caption,
      profileImage: profileImage,
      reviewImage: reviewImage, // If empty, it will be ''
      // Default values required for Firestore schema
      likes: 0,
      comments: 0,
      shares: 0,
      likedBy: const [],
      savedBy: const [],
    );

    try {
      // 4. Send data to Firestore
      await _collection.add({
        'userId': newReview.userId,
        'name': newReview.name,
        // Convert DateTime to Timestamp
        'time': Timestamp.fromDate(newReview.time),
        'caption': newReview.caption,
        'profileImage': newReview.profileImage,
        'reviewImage': newReview.reviewImage,
        'likes': newReview.likes,
        'comments': newReview.comments,
        'shares': newReview.shares,
        'likedBy': newReview.likedBy,
        'savedBy': newReview.savedBy,
      });

      // 5. Success
      emit(state.copyWith(status: ReviewStatus.success));
      // Reset state to initial for the next post
      emit(WriteReviewState());
    } catch (e) {
      // 6. Error
      debugPrint('Error adding review: $e');
      emit(
        state.copyWith(
          status: ReviewStatus.error,
          errorMessage: 'Failed to post. Please try again.',
        ),
      );
    }
  }
}
