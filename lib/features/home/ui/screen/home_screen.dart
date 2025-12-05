import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_cubit.dart';
import 'package:soul_trip/features/home/data/repositories/banner_repository.dart';
import 'package:soul_trip/features/home/data/repositories/home_trips_repository.dart';
import 'package:soul_trip/features/home/data/repositories/banner_likes_repository.dart';
import 'package:soul_trip/features/home/data/repositories/trips_likes_repository.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_cubit.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_cubit.dart';
import 'package:soul_trip/features/home/manager/banner_likes_cubit/banner_likes_cubit.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_cubit.dart';
import 'package:soul_trip/features/home/ui/widgets/banners_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/categories_list_widget.dart';
import 'package:soul_trip/core/widgets/common/header/home_header_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_search_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_list_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_by_category_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/section_header_widget.dart';

import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';
import '../../../../core/dependency_injection/set_up_dependencies.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        // Ensure we only build the Home content when the user is authenticated
        if (authState.status != AuthStatus.authenticated ||
            authState.user == null ||
            authState.userModel == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Prefer Firestore userModel id, fallback to Firebase Auth uid
        final String userId = authState.userModel!.id.isNotEmpty
            ? authState.userModel!.id
            : authState.user!.uid;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  BannerCubit(getIt<BannerRepository>())..streamBanners(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeTripsCubit(getIt<HomeTripsRepository>())
                    ..streamMostPopularTrips(),
            ),
            BlocProvider(
              create: (context) =>
                  CategoriesTripsCubit(getIt<CategoriesTripsRepository>())
                    ..streamCategories(),
            ),
            // Add Likes Cubits with the authenticated user's id
            BlocProvider(
              create: (context) {
                print(
                  'HomeScreen: Creating BannerLikesCubit with userId: $userId',
                );
                return BannerLikesCubit(getIt<BannerLikesRepository>(), userId);
              },
            ),
            BlocProvider(
              create: (context) {
                print(
                  'HomeScreen: Creating TripsLikesCubit with userId: $userId',
                );
                return TripsLikesCubit(getIt<TripsLikesRepository>(), userId);
              },
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: HomeHeaderWidget(
                                onTap: () =>
                                    context.push(Routes.notificationView),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Search Bar
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: HomeSearchBarWidget(
                                onTap: () {
                                  context.push(Routes.searchView);
                                },
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // Categories Section Header
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: SectionHeaderWidget(
                                title: 'Categories',
                                onSeeAll: () {
                                  context.push(Routes.categoriesTripsView);
                                },
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Categories List
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
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
      },
    );
  }
}
