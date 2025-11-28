import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/models/user_model/user_model.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState {
  final AuthStatus status;
  final User? user; // Firebase User (Auth)
  final UserModel? userModel; // Firestore User (Data)

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
    this.userModel,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user, UserModel userModel)
    : this._(
        status: AuthStatus.authenticated,
        user: user,
        userModel: userModel,
      );

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);
}
