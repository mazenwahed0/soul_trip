import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/review_model.dart';
import '../../data/reviews_repository.dart';
import 'post_review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewsRepository _repository;
  StreamSubscription? _reviewsSubscription;

  ReviewCubit(this._repository) : super(const ReviewState()) {
    _fetchReviews();
  }

  void _fetchReviews() {
    // -- Assign the subscription to the variable
    _reviewsSubscription = _repository.streamReviews().listen((result) {
      if (isClosed) return;

      result.fold(
        (failure) => emit(
          ReviewState(reviews: state.reviews, errorMessage: failure.message),
        ),
        (reviews) => emit(ReviewState(reviews: reviews)),
      );
    });
  }

  void toggleLike(String docId, String userId) {
    final index = state.reviews.indexWhere((r) => r.docId == docId);
    if (index == -1) return;

    final review = state.reviews[index];
    final isLiked = review.likedBy.contains(userId);

    // -- Update (Immediate UI Refresh)
    final updatedReview = review.copyWith(
      likes: isLiked ? review.likes - 1 : review.likes + 1,
      likedBy: isLiked
          ? (List.from(review.likedBy)..remove(userId))
          : (List.from(review.likedBy)..add(userId)),
    );

    final newReviews = List<ReviewModel>.from(state.reviews);
    newReviews[index] = updatedReview;

    emit(ReviewState(reviews: newReviews));

    // -- Server Update
    _repository.toggleLike(docId: docId, userId: userId, isLiked: isLiked);
  }

  void toggleSave(String docId, String userId) {
    final index = state.reviews.indexWhere((r) => r.docId == docId);
    if (index == -1) return;

    final review = state.reviews[index];
    final isSaved = review.savedBy.contains(userId);

    // -- Update
    final updatedReview = review.copyWith(
      savedBy: isSaved
          ? (List.from(review.savedBy)..remove(userId))
          : (List.from(review.savedBy)..add(userId)),
    );

    final newReviews = List<ReviewModel>.from(state.reviews);
    newReviews[index] = updatedReview;

    emit(ReviewState(reviews: newReviews));

    // -- Server Update
    _repository.toggleSave(docId: docId, userId: userId, isSaved: isSaved);
  }

  @override
  Future<void> close() {
    _reviewsSubscription?.cancel();
    return super.close();
  }
}
