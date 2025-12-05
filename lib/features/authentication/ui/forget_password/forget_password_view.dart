import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/models/text_field_model/text_field_model.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/validation/validation.dart';
import '../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart';
import '../../../../core/widgets/common/text_field/custom_text_field.dart';
import '../../../../core/utils/snackbars/loaders.dart';
import '../../logic/forget_password/forget_password_cubit.dart';
import '../../logic/forget_password/forget_password_state.dart';

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
        if (state.error != null) {
          Loaders.error(context, title: "Error", message: state.error!);
        }
        // If we are back to isLoading: false AND step is newPassword AND no error...
        // Wait, simpler check: You might want to add a 'success' boolean to state or check explicitly here.
        // For now, let's assume if the Cubit emits a specific success state or we can handle it in the button callback.
      },
      builder: (context, state) {
        return PopScope(
          canPop: false, // Disable default Android back button
          onPopInvoked: (didPop) {
            if (didPop) return;
            // Handle Android Back Button
            final shouldClose = cubit.goBack();
            if (shouldClose) context.pop();
          },
          child: Scaffold(
            backgroundColor: ColorTheme().whiteColor,
            appBar: CustomAppBar(
              // Handle Custom UI Back Button
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
                    // --- Dynamic Body Content based on Step ---
                    if (state.step == ForgotPasswordStep.email)
                      _EmailScreen(cubit: cubit, state: state)
                    else if (state.step == ForgotPasswordStep.otp)
                      _OtpScreen(cubit: cubit, state: state)
                    else
                      _NewPasswordScreen(cubit: cubit, state: state),
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

// --- Screen 1: Email Input ---
class _EmailScreen extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;
  const _EmailScreen({required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Text("Forgot Password", style: AppTextStyles.semiBold24()),
          SizedBox(height: 12.h),
          Text(
            "Enter your email address to receive a code to reset your password", // Matching user request (Email)
            style: AppTextStyles.regular14().copyWith(
              color: ColorTheme().grayMedium,
            ),
          ),
          SizedBox(height: 32.h),
          Text("Email Address", style: AppTextStyles.regular16()),
          SizedBox(height: 8.h),
          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.emailController,
              hintText: "Enter Email Address",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: Validation.emailValidation,
            ),
          ),
          SizedBox(height: 32.h),
          PrimaryShadowButton(
            text: "Send OTP",
            isLoading: state.isLoading,
            onPressed: cubit.sendOtp,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

// --- Screen 2: OTP Input ---
class _OtpScreen extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;
  const _OtpScreen({required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text("Enter OTP", style: AppTextStyles.semiBold24()),
        SizedBox(height: 12.h),
        Text(
          "Enter the 4-digit code sent to ${state.email}",
          style: AppTextStyles.regular14().copyWith(
            color: ColorTheme().grayMedium,
          ),
        ),
        SizedBox(height: 32.h),

        // Pinput for 4-digit box
        Center(
          child: Pinput(
            controller: cubit.otpController,
            length: 4,
            defaultPinTheme: PinTheme(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: ColorTheme().whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorTheme().grayVeryLight),
              ),
              textStyle: AppTextStyles.semiBold24(),
            ),
            focusedPinTheme: PinTheme(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: ColorTheme().whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorTheme().primaryBlue),
              ),
              textStyle: AppTextStyles.semiBold24(),
            ),
          ),
        ),

        SizedBox(height: 24.h),

        // Resend Text
        Center(
          child: RichText(
            text: TextSpan(
              text: "OTP was not received? ",
              style: AppTextStyles.regular14().copyWith(
                color: ColorTheme().grayMedium,
              ),
              children: [
                TextSpan(
                  text: "Resend OTP",
                  style: AppTextStyles.semiBold14().copyWith(
                    color: ColorTheme().primaryBlue,
                  ),
                  // Add onTap here for resend logic if needed
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 32.h),
        PrimaryShadowButton(
          text: "Verify OTP",
          onPressed: cubit.verifyOtp,
          width: double.infinity,
        ),
      ],
    );
  }
}

// --- Screen 3: New Password ---
class _NewPasswordScreen extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  final ForgetPasswordState state;
  const _NewPasswordScreen({required this.cubit, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text("Create New Password", style: AppTextStyles.semiBold24()),
        SizedBox(height: 12.h),
        Text(
          "Password must be different than previous used passwords",
          style: AppTextStyles.regular14().copyWith(
            color: ColorTheme().grayMedium,
          ),
        ),
        SizedBox(height: 32.h),

        Text("New Password", style: AppTextStyles.regular16()),
        SizedBox(height: 8.h),
        CustomTextField(
          textFieldModel: TextFieldModel(
            controller: cubit.newPassController,
            hintText: "Enter New Password",
            icon: Icons.lock_outline,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (String? p1) {},
          ),
        ),

        SizedBox(height: 16.h),

        Text("Confirm Password", style: AppTextStyles.regular16()),
        SizedBox(height: 8.h),
        CustomTextField(
          textFieldModel: TextFieldModel(
            controller: cubit.confirmPassController,
            hintText: "Confirm New Password",
            icon: Icons.lock_outline,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (String? p1) {},
          ),
        ),

        SizedBox(height: 32.h),

        PrimaryShadowButton(
          text: "Create New Password",
          isLoading: state.isLoading,
          onPressed: () async {
            await cubit.resetPassword();
            // Check if success (no error & not loading)
            if (context.mounted && state.error == null && !state.isLoading) {
              showModalBottomSheet(
                context: context,
                builder: (context) => StatusBottomSheet(
                  title: "Password Changed Successfully",
                  primaryButtonText: "Login",
                  onPrimaryPressed: () {
                    context.go('/login'); // Navigate to login
                  },
                ),
              );
            }
          },
          width: double.infinity,
        ),
      ],
    );
  }
}
