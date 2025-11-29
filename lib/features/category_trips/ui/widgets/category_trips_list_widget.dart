import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_cubit/category_trips_cubit.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_cubit/category_trips_state.dart';
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_item_card_widget.dart';

class CategoryTripsListWidget extends StatelessWidget {
  const CategoryTripsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<CategoryTripsCubit, CategoryTripsState>(
      builder: (context, state) {
        if (state is CategoryTripsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryTripsError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorStateWidget(
              message: state.message,
              onRetry: () {
                context.read<CategoryTripsCubit>().streamTrips();
              },
            ),
          );
        }

        if (state is CategoryTripsLoaded) {
          final trips = state.trips;
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

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];
                return CategoryTripItemCardWidget(trip: trip);
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
