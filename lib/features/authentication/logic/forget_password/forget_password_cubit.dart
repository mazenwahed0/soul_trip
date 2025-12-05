import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/authentication_repository.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthenticationRepository _authRepo;

  ForgetPasswordCubit(this._authRepo) : super(const ForgetPasswordState());

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Handle Back Button Logic
  bool goBack() {
    if (state.step == ForgotPasswordStep.newPassword) {
      emit(state.copyWith(step: ForgotPasswordStep.otp));
      return false; // Don't close app
    } else if (state.step == ForgotPasswordStep.otp) {
      emit(state.copyWith(step: ForgotPasswordStep.email));
      return false; // Don't close app
    }
    return true; // Close app (or pop route) if on first screen
  }

  // Step 1: Send OTP
  Future<void> sendOtp() async {
    if (!formKey.currentState!.validate()) return;
    emit(state.copyWith(isLoading: true, error: null));

    final email = emailController.text.trim();
    final result = await _authRepo.sendOtpEmail(email);

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          step: ForgotPasswordStep.otp,
          email: email,
        ),
      ),
    );
  }

  // Step 2: Verify OTP Locally
  Future<void> verifyOtp() async {
    // 1. Local Check
    if (otpController.text.length != 4) {
      emit(state.copyWith(error: "Please enter a 4-digit code"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    // 2. Server Check
    final result = await _authRepo.verifyOtp(state.email!, otpController.text);

    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, error: "Invalid OTP"),
      ), // Stay on screen
      (_) => emit(
        state.copyWith(isLoading: false, step: ForgotPasswordStep.newPassword),
      ), // Go to next
    );
  }

  // Step 3: Reset Password
  Future<void> resetPassword() async {
    if (newPassController.text != confirmPassController.text) {
      emit(state.copyWith(error: "Passwords do not match"));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _authRepo.resetPasswordWithOtp(
      email: state.email!,
      otp: otpController.text.trim(),
      newPassword: newPassController.text.trim(),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) => emit(
        state.copyWith(isLoading: false),
      ), // Success! Listener handles navigation
    );
  }
}
