import 'dart:io';
import 'package:equatable/equatable.dart';

enum ReviewStatus { initial, loading, success, error }

class WriteReviewState extends Equatable {
  final ReviewStatus status;
  final String? errorMessage;
  final File? selectedImage;

  const WriteReviewState({
    this.status = ReviewStatus.initial,
    this.errorMessage,
    this.selectedImage,
  });

  WriteReviewState copyWith({
    ReviewStatus? status,
    String? errorMessage,
    File? selectedImage,
    bool clearImage = false, // Flag to clear image after post
  }) {
    return WriteReviewState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      selectedImage: clearImage ? null : (selectedImage ?? this.selectedImage),
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, selectedImage];
}
