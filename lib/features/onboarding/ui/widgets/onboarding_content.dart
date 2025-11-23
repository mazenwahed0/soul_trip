import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../data/onboarding_model.dart';
import '../../logic/onboarding_cubit.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    super.key,
    required this.list,
    required this.onNext,
  });

  final List<OnboardingModel> list;
  final Function(int currentIndex) onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorTheme().whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: BlocBuilder<OnboardingCubit, int>(
        builder: (context, currentIndex) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 1. Title & Description
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    list[currentIndex].title,
                    style: AppTextStyles.semiBold24().copyWith(
                      color: ColorTheme().blackColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    list[currentIndex].description,
                    style: AppTextStyles.regular14().copyWith(
                      color: ColorTheme().grayDark,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // 2. Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(list.length, (index) {
                  final isActive = index == currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6.h,
                    width: isActive ? 24.w : 6.w,
                    decoration: BoxDecoration(
                      color: isActive
                          ? ColorTheme().primaryBlue
                          : ColorTheme().grayLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              // 3. Figma Button
              PrimaryShadowButton(
                text: currentIndex == list.length - 1 ? "Get Started" : "Next",
                onPressed: () => onNext(currentIndex),
              ),
            ],
          );
        },
      ),
    );
  }
}
