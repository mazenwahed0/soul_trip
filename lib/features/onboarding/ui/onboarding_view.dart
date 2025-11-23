import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/colors.dart';
import '../data/onboarding_model.dart';
import '../logic/onboarding_cubit.dart';
import 'widgets/onboarding_content.dart';
import 'widgets/onboarding_slider.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: const _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    final list = OnboardingModel.list;
    final pageController = PageController();

    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      body: Column(
        children: [
          // 1. Top Section (Image Slider)
          Expanded(
            flex: 3,
            child: OnboardingSlider(
              pageController: pageController,
              list: list,
              onSkip: () => cubit.completeOnboarding(context),
            ),
          ),

          // 2. Bottom Section (Content & Button)
          Expanded(
            flex: 2,
            child: OnboardingContent(
              list: list,
              onNext: (currentIndex) {
                if (currentIndex == list.length - 1) {
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
      ),
    );
  }
}
