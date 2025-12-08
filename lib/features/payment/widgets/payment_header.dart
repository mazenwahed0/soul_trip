import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, 
      children: [
        GestureDetector(
          onTap: () => context.go(Routes.tripDetailsScreen),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffF0F0F0),
            child: Center(child: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
          ),
        ),

        const Spacer(), 

        // 3. Payment Title
         Text(
          "Payment",
          style: AppTextStyles.semiBold20(),
        ),
        const Spacer(),
      ],
    );
  }
}