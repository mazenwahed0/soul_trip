import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/authentication_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  bool rememberMe = false;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(LoginUpdateUI());
  }

  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    emit(LoginUpdateUI());
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    final result = await _authRepo.loginWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    result.fold((failure) => emit(LoginFailure(failure.message)), (
      userCredential,
    ) async {
      // -- Check Verification
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        await _authRepo.logout();
        emit(
          const LoginFailure("Email isn't verified. Please verify your email."),
        );
      } else {
        emit(LoginSuccess());
      }
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
