import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String nameOfPositiveButton;
  final String nameOfNegativeButton;
  final VoidCallback? onPositiveButtonPressed;
  final VoidCallback? onNegativeButtonPressed;
  final bool? isLoading;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.onPositiveButtonPressed,
    this.onNegativeButtonPressed,
    required this.nameOfPositiveButton,
    required this.nameOfNegativeButton,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorTheme().primaryBlue,
      title: Text(
        title,
        style: AppTextStyles.semiBold24().copyWith(color: ColorTheme().whiteColor),
      ),
      content: Text(
        content,
        style: AppTextStyles.regular18().copyWith(color: ColorTheme().whiteColor),
      ),

      actions: [
        Container(
          color: ColorTheme().primaryBlue,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: ColorTheme().primaryBlue, width: 2),
              ),
              backgroundColor: ColorTheme().whiteColor,
            ),
            onPressed: onNegativeButtonPressed,
            child: Text(
              nameOfNegativeButton,
              style: AppTextStyles.semiBold18().copyWith(
                color: ColorTheme().whiteColor,
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: ColorTheme().primaryBlue, width: 2),
            ),
            backgroundColor: ColorTheme().whiteColor,
          ),
          onPressed: onPositiveButtonPressed,
          child: isLoading!
              ?  Center(
                  child: CircularProgressIndicator(color: ColorTheme().whiteColor),
                )
              : Text(
                  nameOfPositiveButton,
                  style: AppTextStyles.semiBold18().copyWith(
                    color: ColorTheme().primaryBlue,
                  ),
                ),
        ),
      ],
    );
  }
}
