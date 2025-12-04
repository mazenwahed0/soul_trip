import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/post_review_state.dart';

class ReviewState {
  final List<Review> reviews;

  ReviewState({this.reviews = const []});
}

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState()) {
    fetchReviews();
  }

  final _collection = FirebaseFirestore.instance.collection('reviews');

  void fetchReviews() {
    _collection.snapshots().listen((snapshot) {
      final reviews = snapshot.docs.map((doc) {
        return Review.fromMap({...doc.data(), 'docId': doc.id});
      }).toList();

      emit(ReviewState(reviews: reviews));
    });
  }

  void toggleLike(String docId, String userId) {
    final reviewIndex = state.reviews.indexWhere((r) => r.docId == docId);
    if (reviewIndex == -1) return;

    final review = state.reviews[reviewIndex];
    final hasLiked = review.likedBy.contains(userId);

    // 1) update local instantly
    final updatedReview = review.copyWith(
      likes: hasLiked ? review.likes - 1 : review.likes + 1,
      likedBy: hasLiked
          ? review.likedBy.where((id) => id != userId).toList()
          : [...review.likedBy, userId],
    );

    final newReviews = state.reviews.toList()..[reviewIndex] = updatedReview;

    emit(ReviewState(reviews: newReviews));

    // 2) update firestore in background
    _collection.doc(docId).update({
      "likes": updatedReview.likes,
      "likedBy": hasLiked
          ? FieldValue.arrayRemove([userId])
          : FieldValue.arrayUnion([userId]),
    });
  }

  void toggleSave(String docId, String userId) {
    final reviewIndex = state.reviews.indexWhere((r) => r.docId == docId);
    if (reviewIndex == -1) return;

    final review = state.reviews[reviewIndex];
    final savedByList = review.savedBy;
    final hasSaved = savedByList.contains(userId);

    _collection.doc(docId).update({
      "savedBy": hasSaved
          ? FieldValue.arrayRemove([userId])
          : FieldValue.arrayUnion([userId]),
    });

    final updatedReview = review.copyWith(
      savedBy: hasSaved
          ? savedByList.where((id) => id != userId).toList()
          : [...savedByList, userId],
    );

    final newReviews = state.reviews.toList()..[reviewIndex] = updatedReview;

    emit(ReviewState(reviews: newReviews));
  }
}
