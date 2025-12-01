import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_item_card_widget.dart';
import 'package:soul_trip/features/home/ui/widgets/home_search_widget.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_cubit.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_state.dart';

import '../../../../core/widgets/common/buttons/custom_back_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:soul_trip/features/search/data/repositories/search_likes_repository.dart';
import 'package:soul_trip/features/search/manager/search_likes_cubit/search_likes_cubit.dart';
import 'package:soul_trip/features/search/ui/widgets/search_trip_favorite_button.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    return BlocProvider(
      create: (_) => SearchLikesCubit(SearchLikesRepository(), userId),
      child: Scaffold(
        backgroundColor: colors.backgroundWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    String hint = 'Search';
                    if (state is SearchLoaded &&
                        state.filters.location != null) {
                      hint = state.filters.location!;
                    }

                    return Row(
                      children: [
                        CustomBackButton(),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: HomeSearchBarWidget(
                            hintText: hint,
                            onFilterTap: () => context.pop(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Results',
                    style: AppTextStyles.semiBold18().copyWith(
                      color: colors.blackColor,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
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
                      final trips = loaded.filteredTrips;

                      if (trips.isEmpty) {
                        return Center(
                          child: Text(
                            'No trips found',
                            style: AppTextStyles.regular14().copyWith(
                              color: colors.grayMedium,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          final trip = trips[index];
                          return CategoryTripItemCardWidget(
                            trip: trip,
                            favoriteButton: SearchTripFavoriteButton(
                              tripId: trip.id,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
