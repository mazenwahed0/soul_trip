import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/status_sheet/status_bottom_sheet.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/logic/booking/BookingState.dart';
import 'package:soul_trip/features/experts/logic/booking/booking_cubit.dart';

class BookingButton extends StatelessWidget {
  final bool canBook;
  final ExpertModel expert;
  final DateTime selectedDate;
  final String selectedTime;
  final String mode;

  const BookingButton({
    super.key,
    required this.canBook,
    required this.expert,
    required this.selectedDate,
    required this.selectedTime,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingAlreadyReserved) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "This appointment is already booked!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }

        if (state is BookingSuccess) {
          showModalBottomSheet(
            context: context,
            builder: (_) => StatusBottomSheet(
              title: "Appointment Booked Successfully",
              primaryButtonText: "Back",
              onPrimaryPressed: () => Navigator.pop(context),
            ),
          );
        }
      },
      builder: (context, state) {
        return PrimaryShadowButton(
          text: "Book Appointment",
          onPressed: () {
            if (!canBook) return;

            context.read<BookingCubit>().checkBooking(
              expertId: expert.id,
              date: selectedDate,
              time: selectedTime,
            );
            
            if (state is BookingAvailable) {
              context.read<BookingCubit>().confirmBooking(
                expertId: expert.id,
                expertName: expert.name,
                date: selectedDate,
                time: selectedTime,
                mode: mode,
              );
            }
          },
          backgroundColor: canBook
              ? ColorTheme().primaryBlue
              : ColorTheme().primaryBlue.withOpacity(0.4),
        );
      },
    );
  }
}
