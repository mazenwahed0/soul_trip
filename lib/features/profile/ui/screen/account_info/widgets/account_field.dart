import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/model/text_field_model/text_field_model.dart';
import '../../../../../../core/theme/colors.dart';
import '../../../../../../core/theme/text_style.dart';
import '../../../../../../core/widgets/common/text_field/custom_text_field.dart';

class AccountField extends StatelessWidget {
  const AccountField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.keyboardType,
    this.isReadOnly = false,
    this.isObscure = false,
    this.validator,
    this.inputFormatters,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isReadOnly;
  final bool isObscure;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.regular16().copyWith(
            color: ColorTheme().blackColor,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          textFieldModel: TextFieldModel(
            controller: controller,
            hintText: hintText,
            icon: icon,
            keyboardType: keyboardType,
            validator: validator,
            readOnly: isReadOnly,
            obscureText: isObscure,
            inputFormatters: inputFormatters,
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
