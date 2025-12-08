import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/text_field_model/text_field_model.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/validation/validation.dart';
import '../../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../../../core/widgets/common/text_field/custom_text_field.dart';
import '../../../logic/forget_password/forget_password_cubit.dart';
import '../../../logic/forget_password/forget_password_state.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key, required this.state});

  final ForgetPasswordState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

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
              icon: Icons.email,
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
