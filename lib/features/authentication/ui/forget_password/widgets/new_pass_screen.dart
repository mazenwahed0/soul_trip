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

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key, required this.state});

  final ForgetPasswordState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return Form(
      key: cubit.passwordFormKey,
      child: Column(
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
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: Validation.validatePassword,
              textInputAction: TextInputAction.next,
            ),
          ),

          SizedBox(height: 16.h),

          Text("Confirm Password", style: AppTextStyles.regular16()),
          SizedBox(height: 8.h),
          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.confirmPassController,
              hintText: "Confirm New Password",
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              validator: (val) => Validation.validateConfirmPassword(
                val,
                cubit.newPassController,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),

          SizedBox(height: 32.h),

          PrimaryShadowButton(
            text: "Create New Password",
            isLoading: state.isLoading,
            onPressed: () => cubit.resetPassword(),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
