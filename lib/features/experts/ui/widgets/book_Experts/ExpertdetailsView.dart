import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/experts/logic/cubitDate/cubitdate.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/DateSelectTime.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/ModeSelectorWidget.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/aboutDoctor.dart';
// import 'package:soul_trip/features/experts/widgets/confirmsheet.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/header_of_details_widget.dart';
// import 'package:soul_trip/features/experts/widgets/primaryButton.dart';
import 'package:soul_trip/features/experts/ui/widgets/book_Experts/timeSelect_widget.dart';

class ExpertdetailsView extends StatefulWidget {
  const ExpertdetailsView({super.key});

  @override
  State<ExpertdetailsView> createState() => _ExpertdetailsViewState();
}

enum Mode { online, inPerson }

class _ExpertdetailsViewState extends State<ExpertdetailsView> {
  bool isOnline = false;

  Mode? selectedMode = Mode.online;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 520,
              child: Image.asset("assets/images/doctor.png", fit: BoxFit.cover),
            ),
            Positioned(bottom: 0, left: 5, right: 5, child: Aboutdoctor()),
            Positioned(top: 5, left: 12, right: 12, child: HeaderOfDetails()),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<DateCubit, DateTime>(
                builder: (context, selectedDate) {
                  return DateSelectorWidget();
                },
              ),
              TimeSelector(
                onSelected: (time) {
                  // print("Selected time: $time");
                },
              ),
              ModeSelectorWidget(
                selectedMode: selectedMode,
                onChanged: (Mode? value) {
                  setState(() {
                    selectedMode = value;
                  });
                },
              ),
              // PrimaryShadowButton(
              //   text: "book appointment",
              //   onPressed: () {
              //     showModalBottomSheet(
              //       context: context,

              //       builder: (context) {
              //         return StatusBottomSheet(
              //           type: SheetType.success,
              //           title: "Appointment Booked Successfully!",
              //           primaryButtonText: "Back to Home",
              //           onPrimaryPressed: () {
              //             Navigator.pop(context);
              //           },
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ]),
    );
  }
}
