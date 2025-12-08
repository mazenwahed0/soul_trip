import 'package:equatable/equatable.dart';

enum ForgotPasswordStep { email, otp, newPassword }

enum ResetStatus { initial, loading, otpSent, otpVerified, success, error }

class ForgetPasswordState extends Equatable {
  final ForgotPasswordStep step;
  final ResetStatus status;
  final String? error;
  final String? email;
  final int timerDuration; // For the countdown (seconds)

  const ForgetPasswordState({
    this.step = ForgotPasswordStep.email,
    this.status = ResetStatus.initial,
    this.error,
    this.email,
    this.timerDuration = 60, // Default 60 seconds
  });

  bool get isLoading => status == ResetStatus.loading;

  ForgetPasswordState copyWith({
    ForgotPasswordStep? step,
    ResetStatus? status,
    String? error,
    String? email,
    int? timerDuration,
  }) {
    return ForgetPasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      error: error,
      // If null passed, error keeps previous value? No, usually we want to clear it.
      // For copyWith, to clear nullable fields, we often use a sentinel or handle explicitly.
      // Here we will assume if you pass error, it updates. If you don't, it keeps it.
      // To clear error, pass empty string or handle logic in Cubit.
      email: email ?? this.email,
      timerDuration: timerDuration ?? this.timerDuration,
    );
  }

  // Helper to clear error specifically
  ForgetPasswordState clearError() {
    return ForgetPasswordState(
      step: step,
      status: status,
      error: null,
      email: email,
      timerDuration: timerDuration,
    );
  }

  @override
  List<Object?> get props => [step, status, error, email, timerDuration];
}
