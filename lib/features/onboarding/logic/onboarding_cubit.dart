import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/caching/shared/shared_perf_helper.dart';
import '../../../core/routing/routes.dart';
import '../data/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository _repository;

  // Inject Repository and start fetching immediately
  OnboardingCubit(this._repository) : super(const OnboardingState()) {
    fetchOnboardingData();
  }

  Future<void> fetchOnboardingData() async {
    emit(state.copyWith(status: OnboardingStatus.loading));

    final result = await _repository.fetchOnboardingData();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (list) => emit(
        state.copyWith(status: OnboardingStatus.success, onboardingList: list),
      ),
    );
  }

  void updatePage(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  // Save that user has seen onboarding
  Future<void> completeOnboarding(BuildContext context) async {
    // 1. Wait for the save to complete
    await SharedPrefHelper.instance.saveBool('hasSeenOnboarding', true);

    // 2. Then navigate (RouteGuard will now see the correct 'true' value)
    if (context.mounted) {
      context.go(Routes.loginView);
    }
  }
}
