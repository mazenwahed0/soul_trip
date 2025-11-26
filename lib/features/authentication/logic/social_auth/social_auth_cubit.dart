import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/authentication_repository.dart';
import 'social_auth_state.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  final AuthenticationRepository _authRepo;

  SocialAuthCubit(this._authRepo) : super(SocialAuthInitial());

  Future<void> googleSignIn() async {
    if (isClosed) return;
    emit(SocialAuthLoading());

    final result = await _authRepo.signInWithGoogle();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (failure.message == 'Google Sign-In cancelled') {
          emit(SocialAuthInitial());
        } else {
          emit(SocialAuthFailure(failure.message));
        }
      },
      (userCredential) {
        if (!isClosed) emit(SocialAuthSuccess());
      },
    );
  }
}
