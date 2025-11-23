import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/snackbars/loaders.dart';
import '../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart';
import '../../../profile/data/user_repository.dart';
import '../../data/authentication_repository.dart';
import '../../logic/signup/signup_cubit.dart';
import '../../logic/signup/signup_state.dart';
import '../widgets/auth_footer.dart';
import '../widgets/social_section/social_login_section.dart';
import '../widgets/auth_layout.dart';
import 'widgets/signup_form.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(
        getIt<AuthenticationRepository>(),
        getIt<UserRepository>(),
      ),
      child: const _SignupBody(),
    );
  }
}

class _SignupBody extends StatelessWidget {
  const _SignupBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: false,
            enableDrag: false,
            builder: (context) => StatusBottomSheet(
              title: "Email Verification Sent",
              primaryButtonText: "Sign In",
              onPrimaryPressed: () {
                // Close sheet then go to Login
                context.pop();
                context.go(Routes.loginView);
              },
            ),
          );
        } else if (state is SignupFailure) {
          Loaders.error(context, title: "Oops!", message: state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();

        return AuthLayout(
          title: "Sign Up",
          child: Column(
            children: [
              // MARK:- Sign Up Form
              SignupForm(cubit: cubit),

              SizedBox(height: 24.h),

              // MARK:- Sign Up Button
              PrimaryShadowButton(
                text: "Sign Up",
                onPressed: cubit.signup,
                isLoading: state is SignupLoading,
                width: double.infinity,
              ),

              // MARK:- Social Login
              const SocialLoginSection(text: "Or Sign Up with"),
              SizedBox(height: 24.h),

              // MARK:- Login Footer
              AuthFooter(
                title: 'Already Have An Account? ',
                buttonText: 'Log In',
                onPressed: () => context.pushReplacement(Routes.loginView),
              ),
            ],
          ),
        );
      },
    );
  }
}
