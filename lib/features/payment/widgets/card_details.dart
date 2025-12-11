import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class CardDetails extends StatelessWidget {
  final String cardName;
  final String cardNumber;
  final String cardIcon;
  final VoidCallback? onDelete;

  const CardDetails({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardIcon,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final ColorTheme colorTheme = ColorTheme();
    final TextStyle cardTextStyle = AppTextStyles.medium12();

    // Masking logic
    String maskedNumber = cardNumber;
    if (cardNumber.length >= 16) {
      // Standard 16 digits: 1234 5678 1234 5678
      // We want 1234 **** **** 5678
      // If formatting is unknown, simplest is to just show first 4 and last 4.
      String cleaned = cardNumber.replaceAll(RegExp(r'[^0-9]'), '');
      if (cleaned.length >= 12) {
        maskedNumber =
            '${cleaned.substring(0, 4)} **** **** ${cleaned.substring(cleaned.length - 4)}';
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(cardIcon, width: 30.w, height: 28.h),

          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardName,
                style: cardTextStyle.copyWith(color: colorTheme.grayDarker),
              ),
              SizedBox(height: 6.h),
              Text(
                maskedNumber,
                style: cardTextStyle.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),

          const Spacer(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Card'),
                  content: const Text('Do you want to delete this card?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onDelete != null) onDelete!();
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Edit',
              style: AppTextStyles.bold14().copyWith(
                color: colorTheme.navyBlue,
              ),
            ),
          ),
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
        designSize: const Size(360, 690),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Card Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              CardDetails(
                cardName: 'Nora Ahmed',
                cardNumber: '1245 90** **** 4587',
                cardIcon: 'assets/icons/Visa.png',
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
