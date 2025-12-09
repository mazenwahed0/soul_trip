import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/core/widgets/common/buttons/secondary_button.dart';
import 'package:soul_trip/core/widgets/common/selection/custom_radio_button.dart';
import 'package:soul_trip/core/widgets/common/selection/selection_chip.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_cubit.dart';
import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_state.dart';

class FilterExpertsScreen extends StatelessWidget {
  const FilterExpertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme().whiteColor,
      appBar: CustomAppBar(
        title: "Filter Experts",
        onBackTap: () => context.pop(),
      ),
      body: BlocBuilder<ExpertFilterCubit, ExpertFilterState>(
        builder: (context, state) {
          final cubit = context.read<ExpertFilterCubit>();
          final filter = cubit.filter;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // FIX: Changed padding to 16.w to match Figma width (343px)
                  // This gives enough space for the "Availability" row to fit.
                  padding: EdgeInsets.only(
                    top: 16.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 40.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Session Type
                      _buildSectionTitle("Session Type"),
                      Row(
                        children: [
                          CustomRadioButton(
                            label: "Online",
                            isSelected: filter.sessionType == "online",
                            onTap: () => cubit.setSessionType("online"),
                          ),
                          SizedBox(width: 24.w),
                          CustomRadioButton(
                            label: "In Person",
                            isSelected: filter.sessionType == "offline",
                            onTap: () => cubit.setSessionType("offline"),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // 2. Location
                      _buildSectionTitle("Location"),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: ["Cairo", "Giza", "Aswan", "Siwa"].map((loc) {
                          return SelectionChip(
                            label: loc,
                            isSelected: filter.location == loc,
                            onTap: () => cubit.setLocation(loc),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24.h),

                      // 3. Category
                      _buildSectionTitle("Category"),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children:
                            [
                              "Wellness Coach",
                              "Relaxation Expert",
                              "Orthopedist",
                              "Psychologist",
                              "Physical Therapist",
                              "Spa Therapist",
                            ].map((cat) {
                              return SelectionChip(
                                label: cat,
                                isSelected: filter.specialization == cat,
                                onTap: () => cubit.setSpecialization(cat),
                              );
                            }).toList(),
                      ),
                      SizedBox(height: 24.h),

                      // 4. Budget
                      _buildSectionTitle("Budget"),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: ColorTheme().primaryYellow,
                          inactiveTrackColor: const Color(0xFFEBEBEB),
                          thumbColor: ColorTheme().primaryYellow,
                          trackHeight: 4.h,
                        ),
                        child: Slider(
                          value: filter.maxPrice ?? 100,
                          min: 20,
                          max: 200,
                          divisions: 18,
                          label: "${filter.maxPrice?.round()} \$",
                          onChanged: cubit.setPrice,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("20 \$", style: AppTextStyles.regular12()),
                            Text("100 \$", style: AppTextStyles.regular12()),
                            Text("200 \$", style: AppTextStyles.regular12()),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // 5. Rating
                      _buildSectionTitle("Rating"),
                      Wrap(
                        spacing: 8.w,
                        children: [
                          SelectionChip(
                            label: "All Rating",
                            isSelected:
                                filter.minRating == null ||
                                filter.minRating == 0,
                            onTap: () => cubit.setRating(0),
                          ),
                          SelectionChip(
                            label: "4 and above",
                            isSelected: filter.minRating == 4,
                            onTap: () => cubit.setRating(4),
                          ),
                          SelectionChip(
                            label: "4.5 and above",
                            isSelected: filter.minRating == 4.5,
                            onTap: () => cubit.setRating(4.5),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // 6. Availability
                      _buildSectionTitle("Availability"),
                      Row(
                        children: [
                          CustomRadioButton(
                            label: "Available Today",
                            isSelected: (filter.availabilityDays ?? [])
                                .contains(_getDayName(DateTime.now().weekday)),
                            onTap: () => cubit.setAvailableDays([
                              _getDayName(DateTime.now().weekday),
                            ]),
                          ),
                          // Gap: 24px as per Figma
                          SizedBox(width: 24.w),
                          CustomRadioButton(
                            label: "Available This Week",
                            isSelected:
                                (filter.availabilityDays?.length ?? 0) == 7,
                            onTap: () => cubit.setAvailableDays([
                              "Sunday",
                              "Monday",
                              "Tuesday",
                              "Wednesday",
                              "Thursday",
                              "Friday",
                              "Saturday",
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        text: "Reset All",
                        onPressed: () {
                          cubit.reset();
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: PrimaryShadowButton(
                        text: "Apply",
                        onPressed: () {
                          final filteredList = cubit.applyFilter();
                          context.pop(filteredList);
                        },
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: AppTextStyles.semiBold16().copyWith(
          color: const Color(0xFF000814),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return days[weekday - 1];
  }
}
