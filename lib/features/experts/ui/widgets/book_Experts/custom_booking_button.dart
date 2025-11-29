import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/status_sheet/status_bottom_sheet.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/core/internet_check/cubit/internet_check__cubit.dart';

class BookingButton extends StatelessWidget {
  final bool canBook;

  const BookingButton({super.key, required this.canBook});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (context, connectivityState) {
        bool isConnected = connectivityState is ConnectivityConnected;

        return PrimaryShadowButton(
          text: "Book Appointment",
          onPressed: () {
            if (!canBook || !isConnected) return;
            showModalBottomSheet(
              context: context,
              builder: (context) => StatusBottomSheet(
                type: SheetType.success,
                title: "Appointment Booked Successfully!",
                primaryButtonText: "Back to Home",
                onPrimaryPressed: () => Navigator.pop(context),
              ),
            );
          },
          backgroundColor: (canBook && isConnected)
              ? ColorTheme().primaryBlue
              : ColorTheme().primaryBlue.withOpacity(0.4),
        );
      },
    );
  }
}
