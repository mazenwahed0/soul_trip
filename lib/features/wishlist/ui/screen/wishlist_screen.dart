import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_cubit.dart';
import 'package:soul_trip/features/home/manager/trips_likes_cubit/trips_likes_state.dart';
import 'package:soul_trip/features/wishlist/logic/cubit/wishlist_cubit.dart';
import 'package:soul_trip/features/wishlist/ui/widgets/empty_wishlist.dart';
import 'package:soul_trip/core/models/home_trip_model.dart' as core;
import 'package:soul_trip/features/category_trips/ui/widgets/category_trip_item_card_widget.dart';
import 'package:soul_trip/features/wishlist/ui/widgets/trip_favorite_button.dart';
import 'package:soul_trip/core/widgets/common/appbar/custom_app_bar.dart';

import '../../../../core/routing/routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // Load data as soon as the page opens
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<WishlistCubit>().loadWishlist(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: CustomAppBar(title: 'Wishlist', showBackButton: false),
      body: SafeArea(
        // Using BlocListener to monitor changes in likes
        child: BlocListener<TripsLikesCubit, TripsLikesState>(
          listener: (context, state) {
            // If the likes state is loaded, we refresh the wishlist
            if (state is TripsLikesLoaded && userId != null) {
              // Ask the WishlistCubit to reload the wishlist
              // To ensure it reflects the latest likes status
              context.read<WishlistCubit>().loadWishlist(userId);
            }
          },
          child: BlocBuilder<WishlistCubit, WishlistState>(
            builder: (context, state) {
              // 1 - Loading State
              if (state is WishlistLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2 - Empty State
              if (state is WishlistEmpty) {
                return const Center(child: EmptyWishlist());
              }

              // 3 - Error State
              if (state is WishlistError) {
                return Center(child: Text(state.message));
              }

              // 4 - Success : State Loaded
              if (state is WishlistLoaded) {
                // Convert to core model
                final List<core.HomeTripModel> trips = state.trips
                    .map((trip) => trip.toCoreModel())
                    .toList();

                // Another safety check
                if (trips.isEmpty) return const Center(child: EmptyWishlist());

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];

                    return CategoryTripItemCardWidget(
                      trip: trip,
                      // Passing the favorite button specific to wishlist
                      favoriteButton: TripFavoriteButton(trip: trip),
                      onTap: () {
                        context.push(Routes.tripDetailsScreen, extra: trip);
                      },
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
