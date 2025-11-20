import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CustomAnimatedTextKit extends StatelessWidget {
  const CustomAnimatedTextKit({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: AppTextStyles.semiBold20().copyWith(
            color: ColorTheme().primaryBlue,
          ),
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 100), // سرعة التكتبية
        ),
      ],
      totalRepeatCount: 1, // يعمل مرة واحدة
      displayFullTextOnTap: true, // عرض النص كامل لو ضغطت
      stopPauseOnTap: true, // توقف عند الضغط
    );
  }
}
