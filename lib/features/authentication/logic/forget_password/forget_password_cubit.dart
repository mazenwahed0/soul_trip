import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/authentication_repository.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthenticationRepository _authRepo;
  Timer? _timer;

  ForgetPasswordCubit(this._authRepo) : super(const ForgetPasswordState());

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final passwordFormKey = GlobalKey<FormState>();

  // -- Navigation Logic
  bool goBack() {
    if (state.step == ForgotPasswordStep.newPassword) {
      // -- Start Over back to Email
      otpController.clear();
      _stopTimer();
      emit(
        state.copyWith(
          step: ForgotPasswordStep.email,
          status: ResetStatus.initial,
        ),
      );
      return false;
    } else if (state.step == ForgotPasswordStep.otp) {
      // Back from OTP to Email
      otpController.clear();
      _stopTimer();
      emit(
        state.copyWith(
          step: ForgotPasswordStep.email,
          status: ResetStatus.initial,
        ),
      );
      return false;
    }

    return true; // Close screen (Back from Email screen)
  }

  // -- Timer Logic
  void _startTimer() {
    _stopTimer(); // Ensure no duplicates
    emit(state.copyWith(timerDuration: 60));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerDuration > 0) {
        emit(
          state.copyWith(
            timerDuration: state.timerDuration - 1,
            status: ResetStatus.initial,
          ),
        );
      } else {
        _stopTimer();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // -- Step 1: Send OTP
  Future<void> sendOtp({bool isResend = false}) async {
    if (!isResend && !formKey.currentState!.validate()) return;

    // Check logic here, if resending, the UI button handle disabling
    emit(state.copyWith(status: ResetStatus.loading, error: null));

    final email = emailController.text.trim();
    final result = await _authRepo.sendOtpEmail(email);

    result.fold(
      (failure) => emit(
        state.copyWith(status: ResetStatus.error, error: failure.message),
      ),
      (_) {
        // Start Timer on success
        _startTimer();
        emit(
          state.copyWith(
            status: ResetStatus.otpSent,
            step: ForgotPasswordStep.otp,
            email: email,
          ),
        );
      },
    );
  }

  // -- Step 2: Verify OTP
  Future<void> verifyOtp() async {
    if (otpController.text.length != 4) {
      emit(
        state.copyWith(
          status: ResetStatus.error,
          error: "Please enter a 4-digit code",
        ),
      );
      return;
    }

    emit(state.copyWith(status: ResetStatus.loading, error: null));

    final result = await _authRepo.verifyOtp(state.email!, otpController.text);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ResetStatus.error,
          error: "Invalid OTP", // Or failure.message
        ),
      ),
      (_) {
        _stopTimer(); // Stop timer once verified
        emit(
          state.copyWith(
            status: ResetStatus.otpVerified,
            step: ForgotPasswordStep.newPassword,
          ),
        );
      },
    );
  }

  // -- Step 3: Reset Password
  Future<void> resetPassword() async {
    if (!passwordFormKey.currentState!.validate()) return;

    if (newPassController.text != confirmPassController.text) {
      emit(
        state.copyWith(
          status: ResetStatus.error,
          error: "Passwords do not match",
        ),
      );
      return;
    }
    emit(state.copyWith(status: ResetStatus.loading, error: null));

    final result = await _authRepo.resetPasswordWithOtp(
      email: state.email!,
      otp: otpController.text.trim(),
      newPassword: newPassController.text.trim(),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: ResetStatus.error, error: failure.message),
      ),
      (_) => emit(state.copyWith(status: ResetStatus.success)),
    );
  }

  @override
  Future<void> close() {
    _stopTimer();
    emailController.dispose();
    otpController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    return super.close();
  }
}
