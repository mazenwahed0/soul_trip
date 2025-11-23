import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/user_model/user_model.dart';
import '../../../profile/data/user_repository.dart';
import '../../data/authentication_repository.dart';
import 'social_auth_state.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;

  SocialAuthCubit(this._authRepo, this._userRepo) : super(SocialAuthInitial());

  Future<void> _createNewUser(user) async {
    final nameParts = UserModel.nameParts(user.displayName ?? '');
    final newUser = UserModel(
      id: user.uid,
      firstName: nameParts[0],
      lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
      email: user.email ?? '',
      phoneNumber: user.phoneNumber ?? '',
      profilePicture: user.photoURL ?? '',
    );

    final result = await _userRepo.saveUserRecord(newUser);

    if (isClosed) return;

    result.fold(
      (failure) {
        emit(SocialAuthFailure("Failed to save user data: ${failure.message}"));
      },
      (_) {
        // Success - User created successfully handled in the main flow
      },
    );
  }

  Future<void> googleSignIn() async {
    if (isClosed) return;
    emit(SocialAuthLoading());

    final result = await _authRepo.signInWithGoogle();

    // If the cubit was closed during the await, stop
    if (isClosed) return;

    await result.fold(
      (failure) async {
        if (isClosed) return;
        if (failure.message == 'Google Sign-In cancelled') {
          emit(SocialAuthInitial());
        } else {
          emit(SocialAuthFailure(failure.message));
        }
      },
      (userCredential) async {
        // -- Toast appears emit Success before the Router redirects the user
        if (!isClosed) emit(SocialAuthSuccess());

        // -- Continue with database work (Fire and Forget)
        if (userCredential.user != null) {
          final user = userCredential.user!;

          // -- AuthCubit will pick up the user data when they reach Home (No await)
          _userRepo.fetchUserDetails().then((result) {
            result.fold(
              (failure) => _createNewUser(user), // Fetch failed -> Create
              (existingUser) {
                if (existingUser.id.isEmpty) _createNewUser(user);
              },
            );
          });
        }
      },
    );
  }
}
