import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Validation {
  static String? emailValidation(value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_your_email'.tr();
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'please_enter_a_valid_email'.tr();
    }
    return null;
  }

  static String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'password_is_required'.tr();
    }
    if (value.length < 8) {
      return 'password_must_be_at_least_8_characters'.tr();
    }

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'password_must_contain_uppercase'.tr();
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'password_must_contain_lowercase'.tr();
    }

    // Check for digit
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'password_must_contain_number'.tr();
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'password_must_contain_special_character'.tr();
    }

    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_username'.tr();
    }

    final trimmedValue = value.trim();

    // Must be at least 3 characters
    if (trimmedValue.length < 3) {
      return 'username_must_be_at_least_3_characters'.tr();
    }

    // Can only contain letters, numbers, hyphens, and underscores
    final userNameRegex = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!userNameRegex.hasMatch(trimmedValue)) {
      return 'username_invalid_characters'.tr();
    }

    return null;
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_your_full_name'.tr();
    }

    // Remove extra spaces and split by spaces
    final nameParts = value.trim().split(RegExp(r'\s+'));

    if (nameParts.length < 3) {
      return 'please_enter_first_middle_last'.tr();
    }

    // Check if each name part has at least 2 characters
    for (var part in nameParts) {
      if (part.length < 3) {
        return 'each_name_must_be_at_least_2_characters'.tr();
      }
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    TextEditingController passwordController,
  ) {
    if (value == null || value.isEmpty) {
      return 'please_confirm_your_password'.tr();
    }
    if (value != passwordController.text) {
      return 'passwords_do_not_match'.tr();
    }
    return null;
  }
}
