import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:soul_trip/core/theme/colors.dart';

void showSuccessToast(BuildContext context, String title, String message) {
  final lines = (message.length / 40).ceil(); // تقريباً 40 حرف في السطر
  final dynamicHeight = 60.0 + (lines * 18.0); // 18 هو ارتفاع كل سطر

  MotionToast.success(
    title: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorTheme().whiteColor,
        ),
      ),
    ),
    description: Text(
      message,
      style: TextStyle(fontSize: 12, color: ColorTheme().whiteColor),
    ),
    animationType: AnimationType.slideInFromTop,
    toastDuration: const Duration(seconds: 3),
    toastAlignment: Alignment.topCenter,
    borderRadius: 12,
    width: 300,
    height: dynamicHeight.clamp(80, 180),
    barrierColor: Colors.transparent,
  ).show(context);
}

void showErrorToast(BuildContext context, String title, String message) {
  final lines = (message.length / 40).ceil(); // تقريباً 40 حرف في السطر
  final dynamicHeight = 60.0 + (lines * 18.0); // 18 هو ارتفاع كل سطر

  MotionToast.error(
    title: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        title,
        maxLines: 1,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorTheme().whiteColor,
        ),
      ),
    ),
    description: Text(
      message,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: ColorTheme().whiteColor,
        height: 1.4,
      ),
    ),
    animationType: AnimationType.slideInFromTop,
    toastDuration: const Duration(seconds: 3),
    toastAlignment: Alignment.topCenter,
    borderRadius: 12,
    width: 300,
    height: dynamicHeight.clamp(80, 180),
    barrierColor: Colors.transparent,
  ).show(context);
}
