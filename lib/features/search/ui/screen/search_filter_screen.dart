import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/models/category_model.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/features/home/data/home_constants.dart';
import 'package:soul_trip/features/search/data/repositories/search_repository.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_cubit.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_state.dart';

import '../../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../../core/widgets/common/appbar/custom_app_bar.dart';
import '../../../../core/widgets/common/buttons/secondary_button.dart';
import '../../../../core/theme/soultrip_icons.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (_) => SearchCubit(getIt<SearchRepository>())..loadInitialData(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Filter Search",
          onBackTap: () => context.pop(),
        ),
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                // 1. Loading State
                if (state is SearchLoading || state is SearchInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 2. Error State
                if (state is SearchError) {
                  return Center(child: Text(state.message));
                }

                // 3. Loaded State
                final loaded = state as SearchLoaded;
                final filters = loaded.filters;

                // -- Filters
                final bool hasFilters =
                    filters.location != null ||
                    filters.categories.isNotEmpty ||
                    filters.date != null ||
                    filters.budget.start > 0 || // Check if min budget moved
                    filters.budget.end < 10000 || // Check if max budget moved
                    filters.travellers > 1; // Check if travellers changed

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // -- Location
                            Text(
                              'Location',
                              style: AppTextStyles.semiBold16().copyWith(
                                color: colors.blackColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                for (final loc in loaded.locations)
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<SearchCubit>()
                                          .updateLocation(loc);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        color: filters.location == loc
                                            ? colors.primaryBlue
                                            : colors.backgroundWhite,
                                        border: Border.all(
                                          color: filters.location == loc
                                              ? colors.primaryBlue
                                              : colors.grayVeryLight,
                                        ),
                                      ),
                                      child: Text(
                                        loc,
                                        style: AppTextStyles.semiBold14()
                                            .copyWith(
                                              color: filters.location == loc
                                                  ? colors.backgroundWhite
                                                  : colors.grayLight,
                                            ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // -- Categories
                            Text(
                              'Wellness Program Type',
                              style: AppTextStyles.semiBold16().copyWith(
                                color: colors.blackColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                for (
                                  var i = 0;
                                  i < loaded.categories.length;
                                  i++
                                )
                                  Builder(
                                    builder: (context) {
                                      final cat = loaded.categories[i];

                                      // Icon Logic
                                      final otherIcons =
                                          HomeConstants.categories.length > 1
                                          ? HomeConstants.categories.sublist(1)
                                          : <CategoryModel>[];

                                      final iconData = i < otherIcons.length
                                          ? otherIcons[i].icon
                                          : HomeConstants.categories.first.icon;

                                      final isSelected = filters.categories
                                          .contains(cat.categoryName);

                                      return GestureDetector(
                                        onTap: () {
                                          context
                                              .read<SearchCubit>()
                                              .toggleCategory(cat.categoryName);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 8.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              24.r,
                                            ),
                                            color: isSelected
                                                ? colors.primaryBlue
                                                : colors.grayVeryLight
                                                      .withValues(alpha: 0.3),
                                            border: Border.all(
                                              color: isSelected
                                                  ? colors.primaryBlue
                                                  : colors.grayVeryLight,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                iconData,
                                                size: 20.sp,
                                                color: isSelected
                                                    ? colors.backgroundWhite
                                                    : colors.primaryBlue,
                                              ),
                                              SizedBox(width: 6.w),
                                              Text(
                                                cat.categoryName,
                                                style: AppTextStyles.regular12()
                                                    .copyWith(
                                                      color: isSelected
                                                          ? colors
                                                                .backgroundWhite
                                                          : colors.blackColor,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // -- Budget
                            Text(
                              'Budget',
                              style: AppTextStyles.semiBold16().copyWith(
                                color: colors.blackColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            RangeSlider(
                              values: filters.budget,
                              min: 0,
                              max: 10000,
                              activeColor: colors.primaryYellow,
                              inactiveColor: colors.grayVeryLight,
                              onChanged: (values) {
                                context.read<SearchCubit>().updateBudget(
                                  values,
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '0 \$',
                                    style: AppTextStyles.regular12(),
                                  ),
                                  Text(
                                    '1000 \$',
                                    style: AppTextStyles.regular12(),
                                  ),
                                  Text(
                                    '10000 \$',
                                    style: AppTextStyles.regular12(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // -- Date & Travellers
                            Column(
                              children: [
                                // Date Picker
                                GestureDetector(
                                  onTap: () async {
                                    final now = DateTime.now();
                                    final initial = filters.date ?? now;
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: initial.isAfter(now)
                                          ? now
                                          : initial,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                      ),
                                    );
                                    if (picked != null && context.mounted) {
                                      context.read<SearchCubit>().updateDate(
                                        picked,
                                      );
                                    }
                                  },
                                  child: _buildSelectorTile(
                                    icon: Soultrip.calendarBold,
                                    title: 'Date',
                                    value: filters.date != null
                                        ? '${filters.date!.day}/${filters.date!.month}/${filters.date!.year}'
                                        : 'Select date',
                                    colors: colors,
                                  ),
                                ),
                                SizedBox(height: 12.h),

                                // Travellers (Static or add logic)
                                GestureDetector(
                                  onTap: () {
                                    // TODO: BottomSheet or Dialog to pick number
                                    // For testing, you can just increment:
                                    // context.read<SearchCubit>().updateTravellers(2);
                                  },
                                  child: _buildSelectorTile(
                                    icon: Soultrip.profile,
                                    title: 'Travellers',
                                    value: filters.travellers > 1
                                        ? '${filters.travellers} Travellers'
                                        : 'Select travellers',
                                    colors: colors,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // -- Bottom Buttons
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Reset All',
                              // Logic: If hasFilters is true, pass function. Else null.
                              onPressed: hasFilters
                                  ? () => context.read<SearchCubit>().resetAll()
                                  : null,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: PrimaryShadowButton(
                              text: 'Apply',
                              height: 48,
                              width: 164,
                              onPressed: () {
                                final cubit = context.read<SearchCubit>();
                                context.push(
                                  Routes.searchCategoryView,
                                  extra: cubit,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to reduce duplication for Date/Travellers tiles
  Widget _buildSelectorTile({
    required IconData icon,
    required String title,
    required String value,
    required ColorTheme colors,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors.backgroundWhite,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.grayVeryLight),
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.primaryBlue, size: 22.sp),
          SizedBox(width: 12.w),
          Text(
            title,
            style: AppTextStyles.semiBold14().copyWith(
              color: colors.blackColor,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.regular12().copyWith(color: colors.grayMedium),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: colors.grayMedium),
        ],
      ),
    );
  }
}
