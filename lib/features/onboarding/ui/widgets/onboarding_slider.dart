import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../data/onboarding_model.dart';
import '../../logic/onboarding_cubit.dart';
import '../../logic/onboarding_state.dart';

class OnboardingSlider extends StatelessWidget {
  const OnboardingSlider({
    super.key,
    required this.pageController,
    required this.list,
    required this.onSkip,
  });

  final PageController pageController;
  final List<OnboardingModel> list;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Stack(
      children: [
        // 1. Image PageView
        PageView.builder(
          controller: pageController,
          itemCount: list.length,
          onPageChanged: (index) {
            cubit.updatePage(index);
          },
          itemBuilder: (context, index) {
            // -- Check if image is network or asset
            final imagePath = list[index].imageUrl;
            final isNetwork = imagePath.startsWith('http');

            return Transform.scale(
              scale: 1.1,
              alignment: Alignment.bottomCenter,
              child: isNetwork
                  ? CachedNetworkImage(
                      imageUrl: imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      width: double.infinity,
                      height: double.infinity,
                    ),
            );
          },
        ),

        // 2. The "Fade" Connector
        Positioned(
          bottom: -1,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  // Start Transparent (Show Image)
                  ColorTheme().whiteColor.withValues(alpha: 0.0),
                  // End Solid White (Match Bottom Container)
                  ColorTheme().whiteColor,
                ],
                // Smoothness of the fade
                stops: const [0.0, 1.0],
              ),
            ),
          ),
        ),

        // 3. Skip Button (On top of image)
        Positioned(
          top: 50.h,
          right: 20.w,
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              if (state.currentIndex == list.length - 1) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: onSkip,
                child: Text(
                  "Skip",
                  style: AppTextStyles.semiBold16().copyWith(
                    color: ColorTheme().blackColor,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
