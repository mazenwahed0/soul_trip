import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/add_card/widgets/credit_card_widget.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/core/theme/colors.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
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
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => context.go(Routes.paymentScreen),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xffF0F0F0),
            child: Center(
              child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
                hint: "Noura Ahmed",
                icon: 'assets/icons/profile.png',
              ),
              const SizedBox(height: 20),

              _buildField(
                controller: numberController,
                label: "Card Number",
                hint: "Enter Card Number",
                icon: 'assets/icons/payment.png',
                keyboard: TextInputType.number,
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
        child: PrimaryShadowButton(text: "Add new Card", onPressed: () {}),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String icon,
    
    TextInputType keyboard = TextInputType.text,
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
            decoration: InputDecoration(
              prefixIcon: Padding(

                padding: const EdgeInsets.only( right: 8.0),
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
