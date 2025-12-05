import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/reviews_repository.dart';
import 'write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  final ReviewsRepository _repository;

  WriteReviewCubit(this._repository) : super(const WriteReviewState());

  /// Pick Image from Gallery
  Future<void> pickReviewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      emit(state.copyWith(selectedImage: File(pickedFile.path)));
    }
  }

  /// Remove Image (UI can call this if user wants to cancel selection)
  void removeImage() {
    emit(state.copyWith(clearImage: true));
  }

  /// Submit Review
  Future<void> addReview({
    required String userId,
    required String name,
    required String caption,
    required String profileImage,
  }) async {
    if (caption.trim().isEmpty) {
      emit(
        state.copyWith(
          status: ReviewStatus.error,
          errorMessage: 'The review caption cannot be empty.',
        ),
      );
      // Reset to initial to clear error
      emit(state.copyWith(status: ReviewStatus.initial));
      return;
    }

    emit(state.copyWith(status: ReviewStatus.loading));

    final result = await _repository.addReview(
      userId: userId,
      name: name,
      caption: caption,
      profileImage: profileImage,
      reviewImageFile: state.selectedImage,
    );

    // Stop if the user left the screen
    if (isClosed) return;

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ReviewStatus.error,
            errorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            status: ReviewStatus.success,
            clearImage: true, // Clear image on success
          ),
        );
        emit(const WriteReviewState()); // Reset state
      },
    );
  }
}
