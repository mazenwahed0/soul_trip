import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/models/text_field_model/text_field_model.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/validation/validation.dart';
import '../../../logic/signup/signup_cubit.dart';
import '../../../../../core/widgets/common/text_field/custom_text_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key, required this.cubit});

  final SignupCubit cubit;

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();
    return Form(
      key: cubit.formKey,
      child: Column(
        spacing: 10.h,
        children: [
          SizedBox(height: 2.h),
          // MARK:- Email
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: AppTextStyles.regular16().copyWith(
                color: colorTheme.blackColor,
                height: 1.0,
              ),
            ),
          ),

          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.emailController,
              hintText: "Enter Your Email",
              labelText: "Email",
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: Validation.emailValidation,
              textInputAction: TextInputAction.next,
            ),
          ),

          SizedBox(height: 2.h),

          // MARK:- Password
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: AppTextStyles.regular16().copyWith(
                color: ColorTheme().blackColor,
                height: 1.0,
              ),
            ),
          ),
          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.passwordController,
              hintText: "Enter Your Password",
              labelText: "Password",
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: cubit.isPasswordHidden,
              validator: Validation.validatePassword,
              textInputAction: TextInputAction.next,
            ),
          ),

          SizedBox(height: 2.h),

          // MARK:- Confirm Password
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Confirm Password",
              style: AppTextStyles.regular16().copyWith(
                color: ColorTheme().blackColor,
                height: 1.0,
              ),
            ),
          ),
          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.confirmPasswordController,
              hintText: "Confirm Your Password",
              labelText: "Confirm Password",
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: cubit.isConfirmPasswordHidden,
              validator: (val) => Validation.validateConfirmPassword(
                val,
                cubit.passwordController,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}
