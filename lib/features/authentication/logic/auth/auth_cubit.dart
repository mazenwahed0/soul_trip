import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model/user_model.dart';
import '../../../profile/data/user/user_repository.dart';
import '../../data/authentication_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;
  late StreamSubscription<User?> _userSubscription;

  AuthCubit(this._authRepo, this._userRepo) : super(const AuthState.unknown()) {
    _userSubscription = _authRepo.authStateChanges.listen((user) async {
      if (user != null) {
        // -- To get data back, creating it if missing
        final result = await _userRepo.checkUserRecordExists(user);

        result.fold(
          (failure) {
            // Only happens on actual network/server error
            emit(AuthState.authenticated(user, UserModel.empty()));
          },
          (userModel) {
            emit(AuthState.authenticated(user, userModel));
          },
        );
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> refreshUserData() async {
    final user = _authRepo.currentUser;
    if (user != null) {
      final result = await _userRepo.fetchUserDetails();
      result.fold(
        (failure) => emit(AuthState.authenticated(user, UserModel.empty())),
        (userModel) => emit(AuthState.authenticated(user, userModel)),
      );
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> logout() => _authRepo.logout();
}
