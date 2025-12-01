import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class PaymentOption extends StatelessWidget {
  final String title;
  final String icon;
  final bool selected;

  const PaymentOption({
    super.key,
    required this.title,
    required this.icon,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:  Colors.grey.shade300, width: 1),
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 20.w, height: 20.h),
          const SizedBox(width: 14),
          Text(
            title, 
            style: AppTextStyles.semiBold14().copyWith(
              color: ColorTheme().grayDarker,)
          ),
          const Spacer(),
          Icon(
            selected ? Icons.radio_button_checked : Icons.circle_outlined,
            color: selected ?ColorTheme().primaryBlue : Colors.grey,
          )
        ],
      ),
    );
  }
}

@Preview()
Widget paymentOptionPreview() {
  return MaterialApp( 
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light, 
    home: Scaffold(
      body: ScreenUtilInit(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: const [
              PaymentOption(
                title: 'Apple Pay',
                icon: 'assets/icons/Apple.png',
                selected: true,
              ),
              PaymentOption(
                title: 'Mastercard',
                icon: 'assets/icons/mastercard.png',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}