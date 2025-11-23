import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/user_model/user_model.dart';
import '../../../profile/data/user_repository.dart';
import '../../data/authentication_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;
  late StreamSubscription<User?> _userSubscription;

  AuthCubit(this._authRepo, this._userRepo) : super(const AuthState.unknown()) {
    _userSubscription = _authRepo.authStateChanges.listen((user) async {
      if (user != null) {
        // -- Fetch User Data (Returns Either)
        final result = await _userRepo.fetchUserDetails();

        result.fold(
          (failure) {
            // Error fetching data (Server/Network error) -> Keep authenticated but empty
            emit(AuthState.authenticated(user, UserModel.empty()));
          },
          (userModel) {
            // Success
            emit(AuthState.authenticated(user, userModel));
          },
        );
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  Future<void> logout() => _authRepo.logout();
}
