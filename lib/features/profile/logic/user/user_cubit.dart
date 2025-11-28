import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/user_model/user_model.dart';
import '../../../../core/repositories/keys.dart';
import '../../../../core/repositories/storage/cloudinary_service.dart';
import '../../data/user/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepo;
  final CloudinaryService _cloudinaryService;

  UserCubit(this._userRepo, this._cloudinaryService) : super(UserInitial());

  /// [UploadProfilePicture] - Cloudinary Storage Service and Updating Firestore
  Future<void> uploadUserProfilePicture(UserModel currentUser) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (image != null) {
        emit(UserLoading());
        File file = File(image.path);

        // 1. Delete old image if exists
        if (currentUser.publicId.isNotEmpty) {
          await _cloudinaryService.deleteImage(currentUser.publicId);
        }

        // 2. Upload new image
        final response = await _cloudinaryService.uploadImage(
          file,
          Keys.profileFolder,
          publicId: currentUser.id,
        );

        if (response.statusCode == 200) {
          final imageUrl = response.data['secure_url'];
          final publicId = response.data['public_id'];

          // 3. Update Firestore (Using Either)
          final result = await _userRepo.updateSingleField({
            'profilePicture': imageUrl,
            'publicId': publicId,
          });

          result.fold(
            (failure) => emit(UserFailure(failure.message)),
            (_) =>
                emit(const UserSuccess("Profile image updated successfully!")),
          );
        } else {
          emit(const UserFailure('Failed to upload image to Cloudinary'));
        }
      }
    } catch (e) {
      emit(UserFailure(e.toString()));
    }
  }

  /// [UpdateSingleField] - Update a single field on Firestore
  Future<void> updateField(Map<String, dynamic> json) async {
    emit(UserLoading());

    final result = await _userRepo.updateSingleField(json);

    result.fold(
      (failure) => emit(UserFailure(failure.message)),
      (_) => emit(const UserSuccess("Profile updated successfully!")),
    );
  }

  /// [SaveAccountInfo] Send New Account Data to Firestore
  Future<void> updateBasicInfo({
    required String fullName,
    required String phoneNumber,
  }) async {
    emit(UserLoading());

    // -- Split Name
    final nameParts = UserModel.nameParts(fullName.trim());
    final firstName = nameParts[0];
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "";

    // -- Prepare JSON
    final Map<String, dynamic> data = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber.trim(),
    };

    // -- Call Repo
    final result = await _userRepo.updateSingleField(data);

    result.fold(
      (failure) => emit(UserFailure(failure.message)),
      (_) => emit(const UserSuccess("Profile updated successfully!")),
    );
  }
}
