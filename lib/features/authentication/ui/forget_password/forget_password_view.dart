import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../core/utils/snackbars/loaders.dart';
import '../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart'; // Import status sheet
import '../../logic/forget_password/forget_password_cubit.dart';
import '../../logic/forget_password/forget_password_state.dart';
import 'widgets/email_screen.dart';
import 'widgets/new_pass_screen.dart';
import 'widgets/otp_screen.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordCubit>(),
      child: const _ForgetPasswordBody(),
    );
  }
}

class _ForgetPasswordBody extends StatelessWidget {
  const _ForgetPasswordBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        // 1. Errors
        if (state.status == ResetStatus.error && state.error != null) {
          Loaders.error(context, title: "Oops!", message: state.error!);
        }
        // 2. OTP Sent (Initial or Resend)
        else if (state.status == ResetStatus.otpSent) {
          Loaders.success(
            context,
            title: "Success",
            message: "OTP sent successfully to your email.",
          );
        }
        // 3. OTP Verified
        else if (state.status == ResetStatus.otpVerified) {
          Loaders.success(
            context,
            title: "Verified",
            message: "OTP Verified Successfully.",
          );
        }
        // 4. Password Reset Success
        else if (state.status == ResetStatus.success) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            enableDrag: false,
            isDismissible: false,
            builder: (context) => StatusBottomSheet(
              title: "Password Changed Successfully",
              primaryButtonText: "Sign In",
              onPrimaryPressed: () => context.go(Routes.loginView),
            ),
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) return;
            final shouldClose = cubit.goBack();
            if (shouldClose) context.pop();
          },
          child: Scaffold(
            backgroundColor: ColorTheme().whiteColor,
            appBar: CustomAppBar(
              onBackTap: () {
                final shouldClose = cubit.goBack();
                if (shouldClose) context.pop();
              },
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Body Content based on Step
                    if (state.step == ForgotPasswordStep.email)
                      // -- Screen 1: Email Input
                      EmailScreen(state: state)
                    else if (state.step == ForgotPasswordStep.otp)
                      // -- Screen 2: OTP Input
                      OtpScreen(state: state)
                    else
                      // -- Screen 3: New Password
                      NewPasswordScreen(state: state),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
