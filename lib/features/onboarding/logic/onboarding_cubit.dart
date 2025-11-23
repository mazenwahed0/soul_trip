import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/caching/shared/shared_perf_helper.dart';
import '../../../core/routing/routes.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void updatePage(int index) {
    emit(index);
  }

  // Save that user has seen onboarding
  Future<void> completeOnboarding(BuildContext context) async {
    // 1. Wait for the save to complete
    await SharedPrefHelper.instance.saveBool('hasSeenOnboarding', true);

    // 2. Then navigate. The RouteGuard will now see the correct 'true' value.
    if (context.mounted) {
      context.go(Routes.loginView);
    }
  }
}
