import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/home/data/repositories/banner_repository.dart';
import 'package:soul_trip/features/home/data/repositories/home_trips_repository.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_cubit.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_cubit.dart';
import 'package:soul_trip/features/home/ui/widgets/banners_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/categories_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_header_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_search_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_by_category_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/section_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BannerCubit(BannerRepository())..streamBanners(),
        ),
        BlocProvider(
          create: (context) =>
              HomeTripsCubit(HomeTripsRepository())..streamMostPopularTrips(),
        ),
      ],
      child: Scaffold(
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Column(
            children: [
              // Header and Search (Fixed)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const HomeHeaderWidget(),
                        ),

                        SizedBox(height: 20.h),

                        // Search Bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const HomeSearchBarWidget(),
                        ),

                        SizedBox(height: 24.h),

                        // Categories Section Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SectionHeaderWidget(
                            title: 'Categories',
                            onSeeAll: () {
                              // TODO: Navigate to all categories
                            },
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Categories List
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const CategoriesListWidget(),
                        ),

                        SizedBox(height: 24.h),

                        // Banners List with BLoC
                        const BannersListWidget(),

                        SizedBox(height: 24.h),

                        // Most Popular Trips
                        const HomeTripsListWidget(),

                        SizedBox(height: 24.h),

                        // Trips by Category
                        const HomeTripsByCategoryWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
