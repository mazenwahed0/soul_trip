import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../model/text_field_model/text_field_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key, required this.textFieldModel});

  final TextFieldModel textFieldModel;

  @override
  State<CustomTextField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextField> {
  late bool isObscured;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    isObscured = widget.textFieldModel.obscureText;
    _focusNode = widget.textFieldModel.focusNode ?? FocusNode();

    // Listen to focus to update border/icon color
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = ColorTheme();
    final Color blue = colorTheme.primaryBlue;
    final Color grayText = colorTheme.grayMedium;
    final Color errorColor = colorTheme.errorColor;
    final Color fieldBackground = const Color(0xFFFBFBFB);
    final Color shadowColor = const Color(0xFF000000).withValues(alpha: 0.25);

    // Using FormField to handle validation state while keeping custom UI
    return FormField<String>(
      validator: widget.textFieldModel.validator,
      initialValue: widget.textFieldModel.controller.text,
      autovalidateMode: widget.textFieldModel.autovalidateMode,
      builder: (FormFieldState<String> state) {
        final bool hasError = state.hasError;

        // -- Border Color Logic:
        // Error -> Red
        // Focused -> Blue
        // Default -> Transparent
        Color borderColor = Colors.transparent;
        if (hasError) {
          borderColor = errorColor;
        } else if (_isFocused) {
          borderColor = blue;
        }

        // -- Icon Color Logic:
        // Focused -> Blue
        // Default -> Gray
        Color iconColor = _isFocused ? blue : grayText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -- Input Container
            Container(
              decoration: BoxDecoration(
                color: fieldBackground,
                borderRadius: BorderRadius.circular(20),
                // -- Dynamic Border
                border: Border.all(color: borderColor, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: widget.textFieldModel.controller,
                focusNode: _focusNode,
                keyboardType: widget.textFieldModel.keyboardType,
                textInputAction: widget.textFieldModel.textInputAction,
                obscureText: isObscured,
                onChanged: (value) {
                  state.didChange(value);
                  widget.textFieldModel.onChanged?.call(value);
                },
                style: AppTextStyles.regular14().copyWith(
                  color: blue,
                  height: 1.0,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 13.h,
                  ),
                  border: InputBorder.none,
                  errorStyle: const TextStyle(height: 0),

                  hintText: widget.textFieldModel.hintText,
                  hintStyle: AppTextStyles.regular14().copyWith(
                    color: grayText,
                    height: 1.0,
                  ),

                  // -- Prefix Icon
                  prefixIcon: widget.textFieldModel.icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 12, right: 8),
                          child: Icon(
                            widget.textFieldModel.icon,
                            size: 24,
                            color: iconColor,
                          ),
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(minWidth: 40),

                  // -- Suffix Icon (Eye)
                  suffixIcon: widget.textFieldModel.obscureText
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: iconColor,
                              size: 24,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),

            // -- Custom Error Text Display (Below container)
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 16),
                child: Text(
                  state.errorText ?? '',
                  style: AppTextStyles.regular12().copyWith(color: errorColor),
                ),
              ),
          ],
        );
      },
    );
  }
}
