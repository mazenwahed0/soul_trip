import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/error_state_widget.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_cubit.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_state.dart';
import 'package:soul_trip/features/home/ui/widgets/home_trips/home_trips_card_widget.dart';

class HomeTripsListWidget extends StatelessWidget {
  const HomeTripsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Most Popular',
            style: AppTextStyles.semiBold20().copyWith(
              color: colors.blackColor,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 220.h,
          child: BlocBuilder<HomeTripsCubit, HomeTripsState>(
            builder: (context, state) {
              if (state is HomeTripsLoading) {
                return const Center(child: CircularProgressIndicator());
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
                final trips = state.trips;

                if (trips.isEmpty) {
                  return Center(
                    child: Text(
                      'No popular trips yet',
                      style: AppTextStyles.regular14().copyWith(
                        color: colors.grayMedium,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    return HomeTripsCardWidget(trip: trip);
                  },
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemCount: trips.length,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
