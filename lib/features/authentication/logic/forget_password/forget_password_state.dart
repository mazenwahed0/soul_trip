import 'package:equatable/equatable.dart';

enum ForgotPasswordStep { email, otp, newPassword }

class ForgetPasswordState extends Equatable {
  final ForgotPasswordStep step;
  final bool isLoading;
  final String? error;
  final String? email; // Store email to pass between steps

  const ForgetPasswordState({
    this.step = ForgotPasswordStep.email,
    this.isLoading = false,
    this.error,
    this.email,
  });

  ForgetPasswordState copyWith({
    ForgotPasswordStep? step,
    bool? isLoading,
    String? error,
    String? email,
  }) {
    return ForgetPasswordState(
      step: step ?? this.step,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [step, isLoading, error, email];
}
