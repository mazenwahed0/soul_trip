import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/models/text_field_model/text_field_model.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/validation/validation.dart';
import '../../../logic/login/login_cubit.dart';
import '../../../../../core/widgets/common/text_field/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.cubit});

  final LoginCubit cubit;

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
              hintText: 'Enter Your Email',
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
          // SizedBox(height: 12.h),
          CustomTextField(
            textFieldModel: TextFieldModel(
              controller: cubit.passwordController,
              hintText: "Enter Your Password",
              labelText: "Password",
              icon: Icons.lock,
              keyboardType: TextInputType.visiblePassword,
              obscureText: cubit.isPasswordHidden,
              validator: Validation.validatePassword,
              textInputAction: TextInputAction.done,
            ),
          ),

          // MARK:- Remember Me & Forgot Password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 4.w,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: Transform.scale(
                      scale: 1.2, // Scales checkbox to ~22-24px
                      child: Checkbox(
                        value: cubit.rememberMe,
                        activeColor: colorTheme.navyBlue,
                        checkColor: Colors.white,
                        side: BorderSide(
                          color: colorTheme
                              .grayDark, // Border color when unchecked
                          width: 1, // Figma: border-width: 1px
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            6,
                          ), // Scaled 6px looks like 8px
                        ),
                        onChanged: cubit.toggleRememberMe,
                      ),
                    ),
                  ),
                  Text("Remember Me", style: AppTextStyles.regular14()),
                ],
              ),

              // MARK:- Forget Password
              TextButton(
                onPressed: () => context.push(Routes.forgotPasswordView),
                child: Text(
                  "Forgot Password ?",
                  style: AppTextStyles.semiBold14().copyWith(
                    color: ColorTheme().primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
