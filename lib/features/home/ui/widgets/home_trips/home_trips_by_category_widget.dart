import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_cubit.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_state.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_card_widget.dart';

class HomeTripsByCategoryWidget extends StatelessWidget {
  const HomeTripsByCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<HomeTripsCubit, HomeTripsState>(
      builder: (context, state) {
        if (state is HomeTripsLoading) {
          return const SizedBox.shrink();
        }

        if (state is HomeTripsError) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ErrorStateWidget(
              message: state.message,
              onRetry: () {
                context.read<HomeTripsCubit>().streamMostPopularTrips();
              },
            ),
          );
        }

        if (state is HomeTripsLoaded) {
          final tripsWithCategory = state.trips
              .where((t) => (t.category ?? '').isNotEmpty)
              .toList();

          if (tripsWithCategory.isEmpty) {
            return const SizedBox.shrink();
          }

          final Map<String, List<dynamic>> grouped = {};
          for (final trip in tripsWithCategory) {
            final key = trip.category!;
            grouped.putIfAbsent(key, () => []).add(trip);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final entry in grouped.entries) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    entry.key,
                    style: AppTextStyles.semiBold20().copyWith(
                      color: colors.blackColor,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 220.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final trip = entry.value[index];
                      return HomeTripsCardWidget(trip: trip);
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: entry.value.length,
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
