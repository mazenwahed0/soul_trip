import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/model/text_field_model/text_field_model.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../core/widgets/common/buttons/primary_shadow_button.dart';
import '../../../../core/widgets/common/text_field/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();

    final phoneController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // -- Main Title "Forgot Password"
              Text(
                'Forgot Password',
                style: AppTextStyles.semiBold24().copyWith(
                  color: colorTheme.navyBlue,
                  height: 1.0,
                ),
              ),

              SizedBox(height: 12.h),

              // -- Description Text
              Text(
                "Enter Your Email Address to receive a code to retrieve your password",
                style: AppTextStyles.regular14().copyWith(
                  color: colorTheme.grayMedium, // Gray text
                  height: 1.5,
                ),
              ),

              SizedBox(height: 32.h),

              // -- Email Address
              Text(
                "Email Address",
                style: AppTextStyles.regular16().copyWith(
                  color: colorTheme.blackColor,
                ),
              ),
              SizedBox(height: 8.h),

              CustomTextField(
                textFieldModel: TextFieldModel(
                  controller: phoneController,
                  hintText: "Enter Email Address",
                  icon: Icons.email,
                  keyboardType: TextInputType.phone,
                  validator: (val) => null, // Add validation logic
                ),
              ),

              SizedBox(height: 32.h),

              // -- "Send OTP" Button
              PrimaryShadowButton(
                text: "Send OTP",
                onPressed: () {
                  // Send Logic
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
