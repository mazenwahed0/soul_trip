import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/home/data/repositories/banner_repository.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_cubit.dart';
import 'package:soul_trip/features/home/ui/widgets/banners_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/categories_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_header_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_search_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/section_header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocProvider(
      create: (context) => BannerCubit(BannerRepository())..streamBanners(),
      child: Scaffold(
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Column(
            children: [
              // Header and Search (Fixed)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Header Section
                    const HomeHeaderWidget(),

                    SizedBox(height: 20.h),

                    // Search Bar
                    const HomeSearchBarWidget(),

                    SizedBox(height: 24.h),

                    // Categories Section Header
                    SectionHeaderWidget(
                      title: 'Categories',
                      onSeeAll: () {
                        // TODO: Navigate to all categories
                      },
                    ),

                    SizedBox(height: 16.h),

                    // Categories List
                    const CategoriesListWidget(),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Banners Section (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SectionHeaderWidget(
                          title: 'Popular Retreats',
                          onSeeAll: () {
                            // TODO: Navigate to all retreats
                          },
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Banners List with BLoC
                      const BannersListWidget(),
                    ],
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
