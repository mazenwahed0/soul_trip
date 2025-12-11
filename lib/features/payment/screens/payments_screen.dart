import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/payment/data/repository/payment_repository.dart';
import 'package:soul_trip/features/payment/manager/payment_cubit/payment_cubit.dart';
import 'package:soul_trip/features/payment/manager/payment_cubit/payment_state.dart';
import 'package:soul_trip/features/payment/widgets/card_details.dart';
import 'package:soul_trip/features/payment/widgets/custom_addCard_button.dart';
import 'package:soul_trip/features/payment/widgets/payment_details_card.dart';
import 'package:soul_trip/features/payment/widgets/payment_header.dart';
import 'package:soul_trip/features/payment/widgets/payment_option.dart';

class PaymentScreen extends StatelessWidget {
  final HomeTripModel trip;
  const PaymentScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final userModel = context.read<AuthCubit>().state.userModel;
        return PaymentCubit(PaymentRepository())
          ..loadSavedCards(userModel?.id ?? '');
      },
      child: _PaymentContent(trip: trip),
    );
  }
}

class _PaymentContent extends StatelessWidget {
  final HomeTripModel trip;
  const _PaymentContent({required this.trip});

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

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

                        TripDetailsCard(
                          image: trip.image ?? '',
                          title: trip.title,
                          rating: trip.rate.toDouble(),
                          location: trip.location,
                          date: trip.date != null
                              ? "${trip.date!.day} ${_getMonthName(trip.date!.month)}"
                              : "",
                          travellers:
                              "2 travellers", // Currently hardcoded or need to be passed/selected
                          duration:
                              "5 days / 4 nights", // Currently hardcoded or need to be passed/calculated
                          cancellation: "Free Cancellation",
                          cancellationNote:
                              "Until 8:00 AM on ${trip.date != null ? "${trip.date!.day - 1} ${_getMonthName(trip.date!.month)}" : ""}",
                          price: "${trip.price.toStringAsFixed(0)} \$ / Night",
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

                        BlocBuilder<PaymentCubit, PaymentState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                PaymentOption(
                                  title: 'Apple Pay',
                                  icon: 'assets/icons/Apple.png',
                                  selected:
                                      state.selectedPaymentMethodIndex == 0,
                                  onTap: () {
                                    context
                                        .read<PaymentCubit>()
                                        .selectPaymentMethod(0);
                                  },
                                ),
                                PaymentOption(
                                  title: 'Visa Card',
                                  icon: 'assets/icons/visa.png',
                                  selected:
                                      state.selectedPaymentMethodIndex == 1,
                                  onTap: () {
                                    context
                                        .read<PaymentCubit>()
                                        .selectPaymentMethod(1);
                                  },
                                ),
                                PaymentOption(
                                  title: 'Master Card',
                                  icon: 'assets/icons/mastercard.png',
                                  selected:
                                      state.selectedPaymentMethodIndex == 2,
                                  onTap: () {
                                    context
                                        .read<PaymentCubit>()
                                        .selectPaymentMethod(2);
                                  },
                                ),
                              ],
                            );
                          },
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
                        BlocBuilder<PaymentCubit, PaymentState>(
                          builder: (context, state) {
                            if (state.status == PaymentStatus.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state.savedCards.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    "No saved cards",
                                    style: AppTextStyles.bold14().copyWith(
                                      color: colorTheme.errorColor,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.savedCards.length,
                              itemBuilder: (context, index) {
                                final card = state.savedCards[index];
                                return CardDetails(
                                  cardName: card.cardName,
                                  cardNumber: card.cardNumber,
                                  cardIcon: card.cardIcon.isNotEmpty
                                      ? card.cardIcon
                                      : 'assets/icons/visa.png',
                                  onDelete: () {
                                    final userModel = context
                                        .read<AuthCubit>()
                                        .state
                                        .userModel;
                                    if (userModel != null) {
                                      context.read<PaymentCubit>().deleteCard(
                                        userModel.id,
                                        card.id,
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),

                        // ADD NEW CARD BUTTON (Centered)
                        Center(
                          child: AddNewCardButton(
                            onTap: () async {
                              final result = await context.push<bool>(
                                Routes.addCardScreen,
                              );
                              if (result == true && context.mounted) {
                                final userModel = context
                                    .read<AuthCubit>()
                                    .state
                                    .userModel;
                                context.read<PaymentCubit>().loadSavedCards(
                                  userModel?.id ?? '',
                                );
                              }
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
        child: PrimaryShadowButton(
          text: "Proceed to Payment",
          onPressed: () {},
        ),
      ),
    );
  }
}
