import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/func/format_timer.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/custom_pin_theme.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../logic/forget_password/forget_password_cubit.dart';
import '../../../logic/forget_password/forget_password_state.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.state});

  final ForgetPasswordState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.h),
        Text("Enter OTP", style: AppTextStyles.semiBold24()),
        SizedBox(height: 12.h),
        Text(
          "Enter the OTP code received on this Email\n${state.email}",
          style: AppTextStyles.regular14().copyWith(
            color: ColorTheme().grayMedium,
          ),
        ),
        SizedBox(height: 32.h),

        // Pinput
        Center(
          child: Pinput(
            controller: cubit.otpController,
            length: 4,
            defaultPinTheme: CustomPinTheme.defaultPinTheme,
            focusedPinTheme: CustomPinTheme.focusedPinTheme,
            separatorBuilder: (index) => SizedBox(width: 8.w), // Gap 8px
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),

        SizedBox(height: 24.h),

        // Timer & Resend
        Center(
          child: RichText(
            text: TextSpan(
              text: "OTP was not received? ",
              style: AppTextStyles.regular16().copyWith(
                color: ColorTheme().blackColor,
                height: 1.0,
              ),
              children: [
                // Only show timer if running
                if (state.timerDuration > 0)
                  TextSpan(
                    text: formatTimer(state.timerDuration),
                    style: AppTextStyles.regular16().copyWith(
                      color: ColorTheme().primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Resend Button
        if (state.timerDuration == 0)
          Center(
            child: TextButton(
              onPressed: () => cubit.sendOtp(isResend: true),
              child: Text(
                "Resend OTP",
                style: AppTextStyles.semiBold16().copyWith(
                  color: ColorTheme().primaryBlue,
                ),
              ),
            ),
          ),

        SizedBox(height: 32.h),
        PrimaryShadowButton(
          text: "Verify OTP",
          isLoading: state.isLoading,
          onPressed: cubit.verifyOtp,
          width: double.infinity,
        ),
      ],
    );
  }
}
