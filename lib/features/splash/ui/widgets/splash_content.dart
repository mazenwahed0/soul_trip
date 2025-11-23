import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../core/utils/constant.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.slideAnimation,
    required this.textOpacity,
    required this.logoOpacity,
    required this.logoReveal,
  });

  final Animation<double> slideAnimation;
  final Animation<double> textOpacity;
  final Animation<double> logoOpacity;
  final Animation<double> logoReveal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(0, slideAnimation.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // LOGO
            Opacity(
              opacity: logoOpacity.value,
              child: ClipRect(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: logoReveal.value,
                  child: Image.asset(
                    ConstantVariable.logo,
                    width: 120,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // TEXT
            Opacity(
              opacity: textOpacity.value,
              child: Text(
                'Soul Trip',
                style: AppTextStyles.bold24().copyWith(
                  color: ColorTheme().blackColor,
                  fontSize: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
