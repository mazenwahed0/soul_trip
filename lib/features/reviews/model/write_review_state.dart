enum ReviewStatus { initial, loading, success, error }

class WriteReviewState {
  final ReviewStatus status;
  final String? errorMessage;

  WriteReviewState({this.status = ReviewStatus.initial, this.errorMessage});

  // copyWith method to update the state without writing repetitive code
  WriteReviewState copyWith({ReviewStatus? status, String? errorMessage}) {
    return WriteReviewState(
      status: status ?? this.status,
      // Pass null if there is no new error (to hide the old message)
      errorMessage: errorMessage,
    );
  }
}
