import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dialog from being dismissed
    builder: (_) => AlertDialog(
      backgroundColor: ColorTheme().whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 60,
              color: ColorTheme().errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'no_internet'.tr(),
              style: AppTextStyles.bold20().copyWith(
                color: ColorTheme().errorColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'please_check_your_internet_connection'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorTheme().primaryBlue, fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorTheme().primaryBlue,
                    side: BorderSide(color: ColorTheme().primaryBlue),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('cancel'.tr()),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
