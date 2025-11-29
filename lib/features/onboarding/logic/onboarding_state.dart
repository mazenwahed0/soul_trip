import 'package:equatable/equatable.dart';
import '../data/onboarding_model.dart';

enum OnboardingStatus { initial, loading, success, failure }

class OnboardingState extends Equatable {
  final OnboardingStatus status;
  final List<OnboardingModel> onboardingList;
  final int currentIndex;
  final String? errorMessage;

  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.onboardingList = const [],
    this.currentIndex = 0,
    this.errorMessage,
  });

  OnboardingState copyWith({
    OnboardingStatus? status,
    List<OnboardingModel>? onboardingList,
    int? currentIndex,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      onboardingList: onboardingList ?? this.onboardingList,
      currentIndex: currentIndex ?? this.currentIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    onboardingList,
    currentIndex,
    errorMessage,
  ];
}
