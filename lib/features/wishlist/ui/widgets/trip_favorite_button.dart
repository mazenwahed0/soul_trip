import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_cubit.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_state.dart';

class TripFavoriteButton extends StatelessWidget {
  final HomeTripModel trip;

  const TripFavoriteButton({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<TripsLikesCubit, TripsLikesState>(
      buildWhen: (previous, current) {
        if (current is TripsLikesLoaded && previous is TripsLikesLoaded) {
          return previous.likedTrips[trip.id] != current.likedTrips[trip.id];
        }
        return true;
      },
      builder: (context, state) {
        bool isLiked = false;
        if (state is TripsLikesLoaded) {
          isLiked = state.likedTrips[trip.id] ?? false;
        } else {
          // Fallback if the state is not loaded yet
          isLiked = context.read<TripsLikesCubit>().isTripLiked(trip.id);
        }

        return GestureDetector(
          onTap: () {
            final authCubit = context.read<AuthCubit>();
            if (authCubit.state.status == AuthStatus.authenticated) {
              context.read<TripsLikesCubit>().toggleLike(trip.id);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please login to like trips'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.whiteColor.withOpacity(0.9),
            ),
            child: state is TripsLikesLoading
                ? Center(
                    child: SizedBox(
                      width: 16.sp,
                      height: 16.sp,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colors.primaryBlue,
                      ),
                    ),
                  )
                : Icon(
                    isLiked ? Soultrip.hearts : Icons.favorite_border,
                    size: 16.sp,
                    color: isLiked ? Colors.red : colors.primaryBlue,
                  ),
          ),
        );
      },
    );
  }
}
