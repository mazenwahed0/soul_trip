import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/widget_previews.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/payment/widgets/card_details.dart';
import 'package:soul_trip/features/payment/widgets/custom_addCard_button.dart';
import 'package:soul_trip/features/payment/widgets/payment_header.dart';
import 'package:soul_trip/features/payment/widgets/payment_details_card.dart';
import 'package:soul_trip/features/payment/widgets/payment_option.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    final ColorTheme colorTheme = ColorTheme();
    return Scaffold(
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PaymentHeader(),
                SizedBox(height: 24.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Trip Details",
                          style: AppTextStyles.medium14().copyWith(
                            color: colorTheme.grayDark,
                          ),
                        ),
                        SizedBox(height: 16.h),

                        const TripDetailsCard(
                          image:
                              "https://res.cloudinary.com/da5c5nstz/image/upload/v1764530373/unsplash_pb8MhOgjlEk_ug7aqj.png",
                          title: "Healing Journey in the Oasis",
                          rating: 4.0,
                          location: "Siwa, Egypt",
                          date: "Saturday, 25 Nov",
                          travellers: "2 travellers",
                          duration: "5 days / 4 nights",
                          cancellation: "Free Cancellation",
                          cancellationNote: "Until 8:00 AM on Nov 24",
                          price: "400 \$ / Night",
                        ),
                        SizedBox(height: 16.h),

                        // Payment Methods Header and Options
                        Text(
                          "Payment Methods",
                          style: AppTextStyles.medium14().copyWith(
                            color: colorTheme.grayDark,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        PaymentOption(
                          title: 'Apple Pay',
                          icon: 'assets/icons/Apple.png',
                          selected: true,
                        ),
                        PaymentOption(
                          title: 'Visa Card',
                          icon: 'assets/icons/visa.png',
                          selected: false,
                        ),
                        PaymentOption(
                          title: 'Master Card',
                          icon: 'assets/icons/mastercard.png',
                          selected: false,
                        ),

                        SizedBox(height: 24.h),

                        // Card Details Header and Card
                        Text(
                          "Card Details",
                          style: AppTextStyles.medium14().copyWith(
                            color: colorTheme.grayDark,
                          ),
                        ),
                        SizedBox(height: 12.h),

                        // SAVED CARD DETAILS
                        const CardDetails(
                          cardName: 'Nora Ahmed',
                          cardNumber: '1245 90** **** 4587',
                          cardIcon: 'assets/icons/visa.png',
                        ),

                        // ADD NEW CARD BUTTON (Centered)
                        Center(
                          child: AddNewCardButton(
                            onTap: () {
                              // Handle Add New Card action
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // --- END SCROLLABLE CONTENT ---
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + bottomPadding,
          top: 6,
        ),
        child: PrimaryShadowButton(text: "Proceed to Payment", onPressed: () {}),
      ),
    );
  }
}
