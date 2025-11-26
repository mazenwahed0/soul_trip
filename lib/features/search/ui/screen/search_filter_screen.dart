import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/models/category_model.dart';
import 'package:soul_trip/features/home/data/home_constants.dart';
import 'package:soul_trip/features/home/data/repositories/home_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/search/data/repositories/search_repository.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_cubit.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_state.dart';

class SearchFilterScreen extends StatelessWidget {
  const SearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (_) => SearchCubit(
        SearchRepository(
          // These will use the shared repositories
          // Provided via dependency injection in the future
          // For now we just create new instances here
          // ignore: prefer_const_constructors
          HomeTripsRepository(),
          // ignore: prefer_const_constructors
          CategoriesTripsRepository(),
        ),
      )..loadInitialData(),
      child: Scaffold(
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.grayVeryLight,
                        ),
                        child: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Filter Search',
                      style: AppTextStyles.semiBold25().copyWith(
                        color: colors.primaryBlue,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 36.w),
                  ],
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading || state is SearchInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is SearchError) {
                        return Center(child: Text(state.message));
                      }

                      final loaded = state as SearchLoaded;
                      final colors = ColorTheme();

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                        color: loaded.filters.location == loc
                                            ? colors.primaryBlue
                                            : colors.backgroundWhite,
                                        border: Border.all(
                                          color: loaded.filters.location == loc
                                              ? colors.primaryBlue
                                              : colors.grayVeryLight,
                                        ),
                                      ),
                                      child: Text(
                                        loc,
                                        style: AppTextStyles.semiBold14()
                                            .copyWith(
                                              color:
                                                  loaded.filters.location == loc
                                                  ? colors.backgroundWhite
                                                  : colors.grayLight,
                                            ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 24.h),
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
                                      // استخدم نفس ترتيب الأيقونات زي home (بعد أول أيقونة Home)
                                      final otherIcons =
                                          HomeConstants.categories.length > 1
                                          ? HomeConstants.categories.sublist(1)
                                          : <CategoryModel>[];

                                      final iconData = i < otherIcons.length
                                          ? otherIcons[i].icon
                                          : HomeConstants.categories.first.icon;

                                      final isSelected = loaded
                                          .filters
                                          .categories
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
                            Text(
                              'Budget',
                              style: AppTextStyles.semiBold16().copyWith(
                                color: colors.blackColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            RangeSlider(
                              values: loaded.filters.budget,
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
                                    style: AppTextStyles.regular12().copyWith(
                                      color: colors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '1000 \$',
                                    style: AppTextStyles.regular12().copyWith(
                                      color: colors.blackColor,
                                    ),
                                  ),
                                  Text(
                                    '10000 \$',
                                    style: AppTextStyles.regular12().copyWith(
                                      color: colors.blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),
                            // Date & Travellers cards
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final now = DateTime.now();
                                    final initial = loaded.filters.date ?? now;

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

                                    if (picked != null) {
                                      context.read<SearchCubit>().updateDate(
                                        picked,
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.backgroundWhite,
                                      borderRadius: BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: colors.grayVeryLight,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Soultrip.calendarBold,
                                          color: colors.primaryBlue,
                                          size: 22.sp,
                                        ),
                                        SizedBox(width: 12.w),
                                        Text(
                                          'Date',
                                          style: AppTextStyles.semiBold14()
                                              .copyWith(
                                                color: colors.blackColor,
                                              ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          loaded.filters.date != null
                                              ? '${loaded.filters.date!.day}/${loaded.filters.date!.month}/${loaded.filters.date!.year}'
                                              : 'Select date',
                                          style: AppTextStyles.regular12()
                                              .copyWith(
                                                color: colors.grayMedium,
                                              ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14.sp,
                                          color: colors.grayMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.backgroundWhite,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: colors.grayVeryLight,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Soultrip.profile,
                                        color: colors.primaryBlue,
                                        size: 22.sp,
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        'Travellers',
                                        style: AppTextStyles.semiBold14()
                                            .copyWith(color: colors.blackColor),
                                      ),
                                      const Spacer(),
                                      Text(
                                        'Select travellers',
                                        style: AppTextStyles.regular12()
                                            .copyWith(color: colors.grayMedium),
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14.sp,
                                        color: colors.grayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Builder(
                  builder: (innerContext) {
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: colors.blackColor,
                              side: BorderSide(color: colors.grayVeryLight),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            onPressed: () {
                              innerContext.read<SearchCubit>().resetAll();
                            },
                            child: Text(
                              'Reset All',
                              style: AppTextStyles.semiBold14().copyWith(
                                color: colors.blackColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                            ),
                            onPressed: () {
                              final cubit = innerContext.read<SearchCubit>();
                              innerContext.push(
                                Routes.searchCategoryView,
                                extra: cubit,
                              );
                            },
                            child: Text(
                              'Apply',
                              style: AppTextStyles.semiBold14().copyWith(
                                color: colors.backgroundWhite,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
