import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/authentication_repository.dart';
import '../../../../core/caching/shared/shared_perf_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationRepository _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial()) {
    _loadSavedCredentials();
  }

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

  /// -- Checks if "Remember Me" was checked to load saved email/password
  void _loadSavedCredentials() {
    final isRemembered =
        SharedPrefHelper.instance.getBool('isRemembered') ?? false;

    if (isRemembered) {
      rememberMe = true;
      emailController.text =
          SharedPrefHelper.instance.getString('saved_email') ?? '';
      passwordController.text =
          SharedPrefHelper.instance.getString('saved_password') ?? '';

      // Update UI to show the filled fields and checked box
      emit(LoginUpdateUI());
    }
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
        // -- Save or Remove credentials based on 'rememberMe' state
        if (rememberMe) {
          await SharedPrefHelper.instance.saveBool('isRemembered', true);
          await SharedPrefHelper.instance.saveString(
            'saved_email',
            emailController.text.trim(),
          );
          // Note: flutter_secure_storage better security
          await SharedPrefHelper.instance.saveString(
            'saved_password',
            passwordController.text.trim(),
          );
        } else {
          // -- If unchecked, clear the saved data
          await SharedPrefHelper.instance.remove('isRemembered');
          await SharedPrefHelper.instance.remove('saved_email');
          await SharedPrefHelper.instance.remove('saved_password');
        }

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
