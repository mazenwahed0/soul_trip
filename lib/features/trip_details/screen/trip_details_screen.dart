import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/core/routing/routes.dart';
import 'package:soul_trip/core/theme/colors.dart';
import 'package:soul_trip/core/theme/text_style.dart';
import 'package:soul_trip/core/widgets/common/buttons/primary_shadow_button.dart';
import 'package:soul_trip/core/widgets/common/taps.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_cubit.dart';
import 'package:soul_trip/features/authentication/logic/auth/auth_state.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_cubit.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_state.dart';
import 'package:soul_trip/features/trip_details/cubit/trip_details_cubit.dart';
import 'package:soul_trip/features/trip_details/cubit/trip_details_state.dart';
import 'package:soul_trip/features/trip_details/widgets/about_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/experts_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/review_tap.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_header.dart';
import 'package:soul_trip/features/trip_details/widgets/trip_price_badge.dart';

class TripDetailsScreen extends StatelessWidget {
  final HomeTripModel trip;

  const TripDetailsScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TripDetailsCubit()..init(trip),
      child: const _TripDetailsContent(),
    );
  }
}

class _TripDetailsContent extends StatefulWidget {
  const _TripDetailsContent();

  @override
  State<_TripDetailsContent> createState() => _TripDetailsContentState();
}

class _TripDetailsContentState extends State<_TripDetailsContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<TripDetailsCubit>().changeTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  Widget _buildTabContent() {
    switch (_tabController.index) {
      case 0:
        return AboutTap();
      case 1:
        return ExpertsTap();
      case 2:
        final state = context.read<TripDetailsCubit>().state;
        if (state is TripDetailsLoaded) {
          return ReviewsTab(overallRating: state.trip.rate.toDouble());
        }
        return const SizedBox();
      default:
        return AboutTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    return BlocConsumer<TripDetailsCubit, TripDetailsState>(
      listener: (context, state) {
        if (state is TripDetailsLoaded &&
            _tabController.index != state.selectedTabIndex) {
          _tabController.animateTo(state.selectedTabIndex);
        }
      },
      builder: (context, state) {
        if (state is! TripDetailsLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final trip = state.trip;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Stack(
                  clipBehavior: Clip.none,
                  children: [
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
                          isLiked = context.read<TripsLikesCubit>().isTripLiked(
                            trip.id,
                          );
                        }

                        return TripHeader(
                          imageUrl: trip.image != null ? [trip.image!] : [],
                          onTapBack: () => context.pop(),
                          title: trip.title,
                          location: trip.location,
                          date: _formatDate(trip.date),
                          isLiked: isLiked,
                          onLike: () {
                            final authCubit = context.read<AuthCubit>();
                            if (authCubit.state.status ==
                                AuthStatus.authenticated) {
                              context.read<TripsLikesCubit>().toggleLike(
                                trip.id,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please login to like trips'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),

                    /// PRICE BADGE
                    Positioned(
                      bottom: -32.h,
                      right: 16.w,
                      child: CardContent(
                        price: "\$ ${trip.price.toStringAsFixed(0)}",
                        rating: trip.rate.toInt(),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 48.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Discover ${trip.title} - a unique wellness experience in ${trip.location}.",
                    style: AppTextStyles.regular14().copyWith(
                      color: ColorTheme().grayMedium,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Tab Bar
                Taps(
                  controller: _tabController,
                  tabHeaders: const [
                    Tab(text: "About"),
                    Tab(text: "Experts"),
                    Tab(text: "Reviews"),
                  ],
                ),

                // Tab Content
                AnimatedBuilder(
                  animation: _tabController,
                  builder: (context, child) {
                    return _buildTabContent();
                  },
                ),

                // Extra space for bottom button
                SizedBox(height: 16.h),
              ],
            ),
          ),

          /// BOTTOM BUTTON
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16 + bottomPadding,
              top: 8,
            ),
            child: PrimaryShadowButton(
              text: "Book Now",
              onPressed: () {
                context.push(Routes.paymentScreen);
              },
            ),
          ),
        );
      },
    );
  }
}
