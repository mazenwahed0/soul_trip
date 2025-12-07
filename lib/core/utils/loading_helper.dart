import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../theme/colors.dart';

/// Helper class for EasyLoading
/// Use this class throughout the app for consistent loading UI
class LoadingHelper {
  LoadingHelper._();

  /// Initialize and Configure Global Loading Style
  static void init() {
    final colors = ColorTheme();

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 20.0
      ..progressColor = colors.primaryBlue
      ..backgroundColor = colors.whiteColor
      ..indicatorColor = colors.primaryBlue
      ..textColor = colors.primaryBlue
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  /// Show loading indicator
  static void show({String? message}) {
    EasyLoading.show(
      status: message ?? 'Loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  /// Show loading with custom message
  static void showWithMessage(String message) {
    EasyLoading.show(status: message, maskType: EasyLoadingMaskType.clear);
  }

  /// Show progress loading (0.0 to 1.0)
  static void showProgress(double progress, {String? message}) {
    EasyLoading.showProgress(
      progress,
      status: message ?? 'Loading...',
      maskType: EasyLoadingMaskType.clear,
    );
  }

  /// Show success message
  static void showSuccess(String message) {
    EasyLoading.showSuccess(message, duration: const Duration(seconds: 2));
  }

  /// Show error message
  static void showError(String message) {
    EasyLoading.showError(message, duration: const Duration(seconds: 2));
  }

  /// Show info message
  static void showInfo(String message) {
    EasyLoading.showInfo(message, duration: const Duration(seconds: 2));
  }

  /// Show toast message
  static void showToast(String message) {
    EasyLoading.showToast(
      message,
      duration: const Duration(seconds: 2),
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  /// Dismiss loading
  static void dismiss() {
    EasyLoading.dismiss();
  }

  /// Check if loading is showing
  static bool get isShowing => EasyLoading.isShow;
}
