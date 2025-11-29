import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/snackbars/loaders.dart';
import '../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../data/authentication_repository.dart';
import '../../logic/login/login_cubit.dart';
import '../../logic/login/login_state.dart';
import '../widgets/auth_footer.dart';
import '../widgets/social_section/social_login_section.dart';
import '../widgets/auth_layout.dart';
import 'widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<AuthenticationRepository>()),
      child: const _LoginBody(),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Loaders.success(
            context,
            title: "Welcome Back!",
            message: "Logged In Successfully",
          );
        } else if (state is LoginFailure) {
          Loaders.error(context, title: "Login Failed", message: state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();

        return AuthLayout(
          title: "Log In",
          child: Column(
            children: [
              // MARK:- Login Form
              LoginForm(cubit: cubit),

              SizedBox(height: 16.h),

              // MARK:- Login Button
              PrimaryShadowButton(
                text: "Log In",
                onPressed: cubit.login,
                isLoading: state is LoginLoading,
                width: double.infinity,
              ),

              // MARK:- Social Login
              const SocialLoginSection(text: "Or Login with"),

              SizedBox(height: 16.h),

              // MARK:- Sign Up Footer
              AuthFooter(
                title: "Don't Have An Account? ",
                buttonText: 'Sign Up',
                onPressed: () => context.pushReplacement(Routes.registerView),
              ),
            ],
          ),
        );
      },
    );
  }
}
