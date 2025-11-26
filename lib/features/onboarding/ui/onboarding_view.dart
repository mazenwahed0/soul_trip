import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/widgets/custom_error_loading_widget.dart';

import '../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../core/theme/colors.dart';
import '../logic/onboarding_cubit.dart';
import '../logic/onboarding_state.dart';
import 'widgets/onboarding_content.dart';
import 'widgets/onboarding_slider.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>(),
      child: const _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final pageController = PageController();

    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          // 1. Loading State
          if (state.status == OnboardingStatus.loading) {
            return Center(
              child: CircularProgressIndicator(color: ColorTheme().primaryBlue),
            );
          }

          // 2. Error State
          if (state.status == OnboardingStatus.failure) {
            return CustomErrorLoadingWidget(
              message: state.errorMessage ?? "Something went wrong",
              onPressed: () => cubit.fetchOnboardingData(),
            );
          }

          // 3. Success State
          final list = state.onboardingList;

          // Safety check
          if (list.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          return Column(
            children: [
              // Top Section (Slider) - Pass data from state
              Expanded(
                flex: 3,
                child: OnboardingSlider(
                  pageController: pageController,
                  list: list,
                  onSkip: () => cubit.completeOnboarding(context),
                ),
              ),

              // Bottom Section (Content) - Pass data from state
              Expanded(
                flex: 2,
                child: OnboardingContent(
                  list: list,
                  // Pass currentIndex from state explicitly
                  currentIndex: state.currentIndex,
                  onNext: (index) {
                    if (index == list.length - 1) {
                      cubit.completeOnboarding(context);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
