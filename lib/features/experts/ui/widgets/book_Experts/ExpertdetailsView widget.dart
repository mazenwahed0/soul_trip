import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/date_state.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/Date%20Select%20Widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ModeSelectorWidget.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/aboutDoctor.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/custom_booking_button.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/header_of_details_widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/timeSelect_widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/expert_image_widget.dart';
import 'package:soul_trip/features/experts/ui/widgets/widthspace_and%20_heigthspace%20_widget.dart';

class ExpertdetailsView extends StatefulWidget {
  final ExpertModel expert;

  const ExpertdetailsView({super.key, required this.expert});

  @override
  State<ExpertdetailsView> createState() => _ExpertdetailsViewState();
}

enum Mode { online, inPerson }

class _ExpertdetailsViewState extends State<ExpertdetailsView> {
  Mode? selectedMode = Mode.online;
  DateTime? selectedDate;
  String? selectedTime;

  bool get canBook => selectedDate != null && selectedTime != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: const HeaderOfDetails(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ExpertImage(imageUrl: widget.expert.image, height: 520.h),
                Positioned(
                  bottom: 0,
                  left: 16.w,
                  right: 16.w,
                  child: Aboutdoctor(expert: widget.expert),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),

                  BlocBuilder<DateCubit, DateState>(
                    builder: (context, state) {
                      return DateSelectorWidget(
                        onDateSelected: (date) {
                          context.read<DateCubit>().updateDate(date);
                          setState(() => selectedDate = date);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  TimeSelector(
                    times: widget.expert.availableTimes,
                    onSelected: (time) {
                      setState(() => selectedTime = time);
                    },
                  ),
                  heightSpace(16),
                  ModeSelectorWidget(
                    selectedMode: selectedMode,
                    price: widget.expert.price,
                    onChanged: (Mode? value) {
                      setState(() => selectedMode = value);
                    },
                  ),
                  heightSpace(24),
                  BookingButton(
                    canBook: canBook,
                    expert: widget.expert,
                    selectedDate: selectedDate ?? DateTime.now(),
                    selectedTime: selectedTime ?? "",
                    mode: selectedMode == Mode.online ? "online" : "inPerson",
                  ),
                  heightSpace(20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
