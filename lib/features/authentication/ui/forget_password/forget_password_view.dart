import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/model/text_field_model/text_field_model.dart';
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
    final colorTheme = ColorTheme();

    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            showModalBottomSheet(
              context: context,
              builder: (context) => StatusBottomSheet(
                title: "Reset Password Email Sent Successfully",
                primaryButtonText: "Done",
                onPrimaryPressed: () => context.pop(),
              ),
            );
          } else if (state is ForgetPasswordFailure) {
            Loaders.error(context, title: "Error", message: state.message);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    'Forgot Password',
                    style: AppTextStyles.semiBold24().copyWith(
                      color: colorTheme.navyBlue,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "Enter Your Email Address to receive a link to reset your password",
                    style: AppTextStyles.regular14().copyWith(
                      color: colorTheme.grayMedium,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    "Email Address",
                    style: AppTextStyles.regular16().copyWith(
                      color: colorTheme.blackColor,
                    ),
                  ),
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
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      return PrimaryShadowButton(
                        text: "Send Reset Link",
                        isLoading: state is ForgetPasswordLoading,
                        onPressed: () {
                          cubit.sendResetEmail();
                        },
                        width: double.infinity,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
