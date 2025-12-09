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
          final bool hasFilters = filter.hasActiveFilters;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // Changed padding to 16.w to match Figma width (343px)
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
                        spacing: 100.w,
                        children: [
                          _buildSessionRadio(
                            label: "Online",
                            isSelected: filter.sessionType == "online",
                            onTap: () => cubit.setSessionType("online"),
                          ),
                          _buildSessionRadio(
                            label: "In Person",
                            isSelected: filter.sessionType == "offline",
                            onTap: () => cubit.setSessionType("offline"),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // 2. Location
                      _buildSectionTitle("Location"),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 12.w,
                          children: ["Cairo", "Giza", "Aswan", "Siwa"].map((
                            loc,
                          ) {
                            return SelectionChip(
                              label: loc,
                              isSelected: filter.location == loc,
                              onTap: () => cubit.setLocation(loc),
                            );
                          }).toList(),
                        ),
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
                              return _buildFilterChip(
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
                          _buildFilterChip(
                            label: "All Rating",
                            isSelected:
                                (filter.minRating == null ||
                                filter.minRating == 0),
                            onTap: () => cubit.setRating(0),
                          ),
                          _buildFilterChip(
                            label: "4 and above",
                            isSelected: filter.minRating == 4,
                            onTap: () => cubit.setRating(4),
                            showStar: true,
                          ),
                          _buildFilterChip(
                            label: "4.5 and above",
                            isSelected: filter.minRating == 4.5,
                            onTap: () => cubit.setRating(4.5),
                            showStar: true,
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // 6. Availability
                      _buildSectionTitle("Availability"),
                      Row(
                        children: [
                          _buildSessionRadio(
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
                        onPressed: hasFilters ? () => cubit.reset() : null,
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
        style: AppTextStyles.medium16().copyWith(
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

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    bool showStar = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 34.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorTheme().primaryBlue
              : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showStar) ...[
              Icon(
                Icons.star_rounded,
                color: const Color(0xFFFFC107), // Gold Star
                size: 16.sp,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: AppTextStyles.medium12().copyWith(
                color: isSelected ? Colors.white : const Color(0xFF262626),
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusing the Session Type visual from ModeSelectorWidget
  Widget _buildSessionRadio({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final primaryBlue = ColorTheme().primaryBlue;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: isSelected ? primaryBlue : const Color(0xFFD9D9D9),
                width: 1.w,
              ),
            ),
            child: isSelected
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryBlue,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.regular14().copyWith(
              color: const Color(0xFF000814),
            ),
          ),
        ],
      ),
    );
  }
}
