import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/utils/images.dart';

import '../../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/utils/snackbars/loaders.dart';
import '../../../data/authentication_repository.dart';
import '../../../logic/social_auth/social_auth_cubit.dart';
import '../../../logic/social_auth/social_auth_state.dart';
import 'social_buttons.dart';

class SocialLoginSection extends StatelessWidget {
  final String text;

  const SocialLoginSection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialAuthCubit(getIt<AuthenticationRepository>()),
      child: BlocConsumer<SocialAuthCubit, SocialAuthState>(
        listener: (context, state) {
          if (state is SocialAuthFailure) {
            Loaders.error(context, title: "Error", message: state.message);
          } else if (state is SocialAuthSuccess) {
            Loaders.success(
              context,
              title: "Success",
              message: "Logged in with Google",
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: 24.h),
              Text(
                text,
                style: AppTextStyles.regular16().copyWith(
                  color: ColorTheme().blackColor,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -- Google
                  SocialButton(
                    image: Images.google,
                    isLoading: state is SocialAuthLoading,
                    onTap: () => context.read<SocialAuthCubit>().googleSignIn(),
                  ),

                  SizedBox(width: 20.w),

                  // -- Facebook
                  SocialButton(image: Images.facebook, onTap: () {}),

                  SizedBox(width: 20.w),

                  // -- Instagram
                  SocialButton(image: Images.instagram, onTap: () {}),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
