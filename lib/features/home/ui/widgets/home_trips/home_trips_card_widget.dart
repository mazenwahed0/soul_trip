import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';
import '../../../manager/trips_likes_cubit/trips_likes_cubit.dart';
import '../../../manager/trips_likes_cubit/trips_likes_state.dart';
import '../../../../../features/authentication/logic/auth/auth_cubit.dart';
import '../../../../../features/authentication/logic/auth/auth_state.dart';

class HomeTripsCardWidget extends StatelessWidget {
  final HomeTripModel trip;

  const HomeTripsCardWidget({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme();

    return GestureDetector(
      onTap: () => context.push(Routes.tripDetailsScreen, extra: trip),
      child: Container(
        width: 160.w,
        margin: EdgeInsets.only(right: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image (network or placeholder)
              _buildBackgroundImage(colors),

              // Gradient overlay at bottom
              _buildGradientOverlay(),

              // Content
              _buildContent(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(ColorTheme colors) {
    if (trip.image != null && trip.image!.isNotEmpty) {
      return Image.network(trip.image!, fit: BoxFit.cover);
    }

    return Container(
      color: colors.grayVeryLight,
      child: const Icon(Icons.landscape, color: Colors.grey),
    );
  }

  Widget _buildGradientOverlay() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(ColorTheme colors) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // OFF badge at top-left and Like button at top-right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // OFF badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${trip.off}% OFF',
                  style: AppTextStyles.semiBold12().copyWith(
                    color: colors.primaryBlue,
                  ),
                ),
              ),

              // Like button
              BlocBuilder<TripsLikesCubit, TripsLikesState>(
                buildWhen: (previous, current) {
                  if (current is TripsLikesLoaded &&
                      previous is TripsLikesLoaded) {
                    return previous.likedTrips[trip.id] !=
                        current.likedTrips[trip.id];
                  }
                  return true;
                },
                builder: (context, state) {
                  bool isLiked = false;
                  if (state is TripsLikesLoaded) {
                    isLiked = state.likedTrips[trip.id] ?? false;
                  } else {
                    // Fallback to cubit's current state if not loaded (e.g. initial)
                    isLiked = context.read<TripsLikesCubit>().isTripLiked(
                      trip.id,
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      // Check if user is authenticated before allowing like
                      final authCubit = context.read<AuthCubit>();
                      if (authCubit.state.status == AuthStatus.authenticated) {
                        context.read<TripsLikesCubit>().toggleLike(trip.id);
                      } else {
                        // Show message or navigate to login
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
                        color: colors.whiteColor.withValues(alpha: 0.9),
                      ),
                      child: state is TripsLikesLoading
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
                              size: 16.sp,
                              color: isLiked ? Colors.red : colors.primaryBlue,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),

          const Spacer(),

          // Location text
          Text(
            trip.location,
            style: AppTextStyles.regular12().copyWith(color: colors.whiteColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 4.h),

          // Title text
          Text(
            trip.title,
            style: AppTextStyles.semiBold14().copyWith(
              color: colors.whiteColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
