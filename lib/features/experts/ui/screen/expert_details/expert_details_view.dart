import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/date_state.dart';
import 'package:soul_trip/features/experts/ui/screen/expert_details/widgets/mode_selector_widget.dart';
import 'package:soul_trip/features/experts/ui/screen/expert_details/widgets/time_select_widget.dart';
import 'package:soul_trip/features/experts/ui/screen/expert_details/widgets/expert_image_widget.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theme/text_style.dart';
import '../../../../../core/utils/snackbars/loaders.dart';
import '../../../../../core/widgets/common/status_sheet/status_bottom_sheet.dart';
import '../../../logic/booking/booking_cubit.dart';
import '../../../logic/booking/booking_state.dart';
import 'widgets/about_doctor.dart';
import 'widgets/calender/date_select_widget.dart';

class ExpertDetailsView extends StatefulWidget {
  final ExpertModel expert;

  const ExpertDetailsView({super.key, required this.expert});

  @override
  State<ExpertDetailsView> createState() => _ExpertDetailsViewState();
}

enum Mode { online, inPerson }

class _ExpertDetailsViewState extends State<ExpertDetailsView> {
  Mode? selectedMode = Mode.online;
  DateTime? selectedDate;
  String? selectedTime;

  bool get canBook => selectedDate != null && selectedTime != null;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: false,
            enableDrag: false,
            builder: (context) => StatusBottomSheet(
              title: "Appointment Booked\nSuccessfully",
              primaryButtonText: "Back To Home",
              onPrimaryPressed: () {
                context.pop();
                context.go(Routes.homeView);
              },
            ),
          );
        } else if (state is BookingFailed) {
          Loaders.error(context, title: "Oops!", message: state.message);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 100.h,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Top Section
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      ExpertImage(imageUrl: widget.expert.image, height: 420),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AboutDoctor(expert: widget.expert),
                      ),
                    ],
                  ),

                  // Form Content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<DateCubit, DateState>(
                          builder: (context, state) {
                            // Ensure selectedDate is updated from Cubit if needed
                            // (Optional safety check)

                            final dateString = DateFormat(
                              'd MMMM',
                            ).format(state.selectedDate);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. Header (Choose Date + Icon)
                                DateSelectorWidget(
                                  onDateSelected: (date) {
                                    context.read<DateCubit>().updateDate(date);
                                    setState(() => selectedDate = date);
                                  },
                                ),

                                SizedBox(height: 6.h),

                                // 2. Date Text
                                Text(
                                  dateString,
                                  style: AppTextStyles.regular14(),
                                ),

                                SizedBox(height: 4.h),

                                // 3. Time Chips
                                TimeSelector(
                                  times: widget.expert.availableTimes,
                                  onSelected: (time) {
                                    setState(() => selectedTime = time);
                                  },
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(height: 16.h),

                        ModeSelectorWidget(
                          selectedMode: selectedMode,
                          price: widget.expert.price,
                          onChanged: (Mode? value) {
                            setState(() => selectedMode = value);
                          },
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Bottom Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 375.w,
              height: 104.h,
              padding: EdgeInsets.only(
                top: 16.h,
                left: 16.w,
                right: 16.w,
                bottom: 32.h,
              ),
              decoration: BoxDecoration(
                color: ColorTheme().whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: PrimaryShadowButton(
                text: "Book Appointment",
                // Show loading state on button
                isLoading:
                    context.watch<BookingCubit>().state is BookingChecking,
                // Call the Booking Function
                onPressed: canBook
                    ? () {
                        context.read<BookingCubit>().confirmBooking(
                          expertId: widget.expert.id,
                          expertName: widget.expert.name,
                          date: selectedDate!,
                          time: selectedTime!,
                          mode: selectedMode == Mode.online
                              ? 'Online'
                              : 'In Person',
                        );
                      }
                    : () {
                        Loaders.error(
                          context,
                          title: "Oops!",
                          message: 'Please Select Time and Date',
                        );
                      },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
