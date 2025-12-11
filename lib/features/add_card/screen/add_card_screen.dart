import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/add_card/logic/add_card_cubit/add_card_cubit.dart';
import 'package:soul_trip/features/add_card/logic/add_card_cubit/add_card_state.dart';
import 'package:soul_trip/features/add_card/widgets/credit_card_widget.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/payment/data/repository/payment_repository.dart';

import '../../../core/utils/snackbars/loaders.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCardCubit(PaymentRepository()),
      child: const _AddNewCardContent(),
    );
  }
}

class _AddNewCardContent extends StatefulWidget {
  const _AddNewCardContent();

  @override
  State<_AddNewCardContent> createState() => _AddNewCardContentState();
}

class _AddNewCardContentState extends State<_AddNewCardContent> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    numberController.addListener(() => setState(() {}));
    expiryController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return BlocListener<AddCardCubit, AddCardState>(
      listener: (context, state) {
        if (state.status == AddCardStatus.success) {
          context.pop(true); // Return true to indicate card added
        } else if (state.status == AddCardStatus.failure) {
          Loaders.error(context, title: "Oops!", message: state.errorMessage);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xffF0F0F0),
                child: Center(
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                ),
              ),
            ),
          ),
          title: Text(
            "Add new Card",
            style: AppTextStyles.semiBold20().copyWith(
              color: ColorTheme().navyBlue,
            ),
          ),
        ),

        body: ScreenUtilInit(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// ************* CARD PREVIEW *************
                CreditCardWidget(
                  cardNumber: numberController.text.isEmpty
                      ? "1234 5678 1234 5678"
                      : numberController.text,
                  cardHolderName: nameController.text.isEmpty
                      ? "Your Name"
                      : nameController.text,
                  validThru: expiryController.text.isEmpty
                      ? "05/30"
                      : expiryController.text,
                ),

                const SizedBox(height: 35),

                /// ************* FORM FIELDS *************
                _buildField(
                  controller: nameController,
                  label: "Account Holder Name",
                  hint: "Enter Account Holder Name",
                  icon: 'assets/icons/profile.png',
                ),
                const SizedBox(height: 20),

                _buildField(
                  controller: numberController,
                  label: "Card Number",
                  hint: "Enter Card Number",
                  icon: 'assets/icons/payment.png',
                  keyboard: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: expiryController,
                        label: "Expiry date",
                        hint: "MM/YY",
                        icon: 'assets/icons/solar_calendar-bold.png',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildField(
                        controller: cvvController,
                        label: "CVV",
                        hint: "***",
                        icon: 'assets/icons/lock.png',
                        keyboard: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
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
          child: BlocBuilder<AddCardCubit, AddCardState>(
            builder: (context, state) {
              return PrimaryShadowButton(
                text: state.status == AddCardStatus.loading
                    ? "Adding..."
                    : "Add new Card",
                onPressed: () {
                  if (state.status == AddCardStatus.loading) return;
                  final userModel = context.read<AuthCubit>().state.userModel;
                  if (userModel != null) {
                    context.read<AddCardCubit>().addCard(
                      holderName: nameController.text,
                      cardNumber: numberController.text,
                      expiryDate: expiryController.text,
                      cvv: cvvController.text,
                      userId: userModel.id,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
    TextInputType keyboard = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.regular12().copyWith(letterSpacing: 0),
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboard,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(icon, color: ColorTheme().grayDark),
              ),
              prefixIconConstraints: BoxConstraints(
                maxWidth: 22.w,
                maxHeight: 22.h,
              ),

              hintText: hint,
              border: InputBorder.none,
            ),
            style: AppTextStyles.regular14().copyWith(
              color: ColorTheme().blackColor,
              letterSpacing: 0,
            ),
          ),
        ),
      ],
    );
  }
}
