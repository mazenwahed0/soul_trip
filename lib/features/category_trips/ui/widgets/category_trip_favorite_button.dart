import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import '../../../../features/authentication/logic/auth/auth_cubit.dart';
import '../../../../features/authentication/logic/auth/auth_state.dart';
import '../../manager/category_trips_likes_cubit/category_trips_likes_cubit.dart';
import '../../manager/category_trips_likes_cubit/category_trips_likes_state.dart';

class CategoryTripFavoriteButton extends StatelessWidget {
  final String tripId;

  const CategoryTripFavoriteButton({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return BlocBuilder<CategoryTripsLikesCubit, CategoryTripsLikesState>(
      buildWhen: (previous, current) {
        if (current is CategoryTripsLikesLoaded &&
            previous is CategoryTripsLikesLoaded) {
          return previous.likedTrips[tripId] != current.likedTrips[tripId];
        }
        return true;
      },
      builder: (context, state) {
        bool isLiked = false;
        if (state is CategoryTripsLikesLoaded) {
          isLiked = state.likedTrips[tripId] ?? false;
        } else {
          isLiked = context.read<CategoryTripsLikesCubit>().isTripLiked(tripId);
        }

        return GestureDetector(
          onTap: () {
            final authCubit = context.read<AuthCubit>();
            if (authCubit.state.status == AuthStatus.authenticated) {
              context.read<CategoryTripsLikesCubit>().toggleLike(tripId);
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
              color: colors.backgroundWhite.withValues(alpha: 0.9),
            ),
            child: state is CategoryTripsLikesLoading
                ? SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.primaryBlue,
                    ),
                  )
                : Icon(
                    isLiked ? Soultrip.hearts : Icons.favorite_border,
                    size: 18.sp,
                    color: isLiked ? Colors.red : colors.primaryBlue,
                  ),
          ),
        );
      },
    );
  }
}
