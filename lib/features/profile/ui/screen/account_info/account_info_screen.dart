import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';

import '../../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../../core/func/format_phone.dart';
import '../../../../../core/models/user_model/user_model.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/utils/snackbars/loaders.dart';
import '../../../../../core/validation/validation.dart';
import '../../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../../core/widgets/common/buttons/primary_shadow_button.dart';

import '../../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart';
import '../../../../authentication/logic/auth/auth_cubit.dart';
import '../../../logic/user/user_cubit.dart';
import '../../../logic/user/user_state.dart';
import 'widgets/account_field.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCubit>(),
      child: const _AccountInfoBody(),
    );
  }
}

class _AccountInfoBody extends StatefulWidget {
  const _AccountInfoBody();

  @override
  State<_AccountInfoBody> createState() => _AccountInfoBodyState();
}

class _AccountInfoBodyState extends State<_AccountInfoBody> {
  // Controllers
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // -- Store Initial Values & Track Visibility (Save Changes)
  late String initialName;
  late String initialPhone;
  bool hasChanges = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthCubit>().state.userModel ?? UserModel.empty();

    // --- Set Initial Values
    initialName = user.fullName;
    initialPhone = user.phoneNumber;

    nameController = TextEditingController(text: user.fullName);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController(text: "************");
    phoneController = TextEditingController(
      text: formatEgyptianPhoneNumber(user.phoneNumber),
    );

    initialPhone = phoneController.text;

    // -- Add Listeners to check for changes
    nameController.addListener(_checkForChanges);
    phoneController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    nameController.removeListener(_checkForChanges);
    phoneController.removeListener(_checkForChanges);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // -- Compare current vs initial
  void _checkForChanges() {
    final nameChanged = nameController.text.trim() != initialName;
    final phoneChanged = phoneController.text.trim() != initialPhone;

    final shouldShowButton = nameChanged || phoneChanged;

    if (hasChanges != shouldShowButton) {
      setState(() {
        hasChanges = shouldShowButton;
      });
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      // -- Format the number BEFORE using it
      final formattedPhone = formatEgyptianPhoneNumber(phoneController.text);

      // -- Send the Formatted version to the Cubit
      // Bridge: Pass text from UI Controllers to Cubit Logic
      context.read<UserCubit>().updateBasicInfo(
        fullName: nameController.text,
        phoneNumber: formattedPhone,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      appBar: CustomAppBar(
        title: "Account Info",
        onBackTap: () => Navigator.pop(context),
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            showModalBottomSheet(
              context: context,
              builder: (context) =>
                  StatusBottomSheet(title: "Changes Saved Successfully"),
            );

            context.read<AuthCubit>().refreshUserData();

            // -- Update initial values after successful save
            // So the button disappears again
            setState(() {
              // -- Formatted Phone Number
              final formattedPhone = formatEgyptianPhoneNumber(
                phoneController.text,
              );

              // -- Update the controller, user sees it changes
              phoneController.text = formattedPhone;

              // -- Update initial values so the "Save" button hides
              initialName = nameController.text.trim();
              initialPhone = formattedPhone;

              hasChanges = false;
            });
          } else if (state is UserFailure) {
            Loaders.error(context, title: "Error", message: state.message);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              // Expanded: Forces the SingleChildScrollView to take up only the space above the button.
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),

                        // 1. Name Field
                        AccountField(
                          label: "Name",
                          controller: nameController,
                          hintText: "Enter your name",
                          icon: Soultrip.profile,
                          keyboardType: TextInputType.name,
                          validator: Validation.validateFullName,
                        ),

                        // 2. Email Field
                        AccountField(
                          label: "Email",
                          controller: emailController,
                          hintText: "",
                          icon: Soultrip.email,
                          keyboardType: TextInputType.emailAddress,
                          isReadOnly: true,
                        ),

                        // 3. Password Field
                        AccountField(
                          label: "Password",
                          controller: passwordController,
                          hintText: "",
                          icon: Soultrip.passwordlock,
                          keyboardType: TextInputType.visiblePassword,
                          isReadOnly: true,
                          isObscure: true,
                        ),

                        // 4. Phone Field
                        AccountField(
                          label: "Phone Number",
                          controller: phoneController,
                          hintText: "Enter your phone number",
                          icon: Soultrip.phone,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            // 1. Allow only numbers, spaces, and +
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9\s+]'),
                            ),
                            // 2. Stop them from typing too much (approx length of formatted number)
                            LengthLimitingTextInputFormatter(17),
                          ],
                          validator: (val) {
                            if (val == null || val.isEmpty) return "Required";

                            final isPhone =
                                Validation.validateEgyptianPhone(val) == null;

                            if (!isPhone) {
                              return "Enter a vaild Egyptian Phone";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 48.h),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),

              // Save Button (Conditional Button Visibility, Pinned to bottom)
              if (hasChanges)
                Container(
                  padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                  child: BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return PrimaryShadowButton(
                        text: "Save Changes",
                        onPressed: _onSave,
                        isLoading: state is UserLoading,
                        width: double.infinity,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
