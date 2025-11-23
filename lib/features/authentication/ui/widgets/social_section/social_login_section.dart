import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/snackbars/loaders.dart';
import '../../../../profile/data/user_repository.dart';
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
      create: (context) => SocialAuthCubit(
        getIt<AuthenticationRepository>(),
        getIt<UserRepository>(),
      ),
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

            // Note: The global AuthCubit in app.dart will detect the new user
            // But Force GoRouter to run the AppRouteGuard again
            // Since the user is now logged in, and the AppRouteGuard will redirect them to Home
            GoRouter.of(context).refresh();
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
                    image: ConstantVariable.google,
                    isLoading: state is SocialAuthLoading,
                    onTap: () => context.read<SocialAuthCubit>().googleSignIn(),
                  ),

                  SizedBox(width: 20.w),

                  // -- Facebook
                  SocialButton(image: ConstantVariable.facebook, onTap: () {}),

                  SizedBox(width: 20.w),

                  // -- Instagram
                  SocialButton(image: ConstantVariable.instagram, onTap: () {}),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
