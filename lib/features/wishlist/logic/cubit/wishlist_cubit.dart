import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/wishlist_repository.dart';
import '../../data/models/wishlist_item_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository repository;

  WishlistCubit({required this.repository}) : super(WishlistLoading());

  Future<void> loadWishlist(String userId) async {
    emit(WishlistLoading());

    try {
      // 1) Fetch the IDs of trips the user has liked
      final tripIds = await repository.getUserWishlistTripIds(userId);

      if (tripIds.isEmpty) {
        emit(WishlistEmpty());
        return;
      }

      // 2) Fetch data for each ID
      final List<HomeTripModel> trips = [];

      for (String id in tripIds) {
        final trip = await repository.getTripById(id);

        if (trip != null) {
          trips.add(trip);
        }
      }

      // 3 - Build the state based on fetched trips
      if (trips.isEmpty) {
        emit(WishlistEmpty());
      } else {
        emit(WishlistLoaded(trips));
      }
    } catch (e) {
      // It's a good practice to print the error to the console for debugging
      print("Wishlist Error: $e");
      emit(WishlistError("Something went wrong"));
    }
  }

  Future<void> toggleWishlist(String userId, String tripId) async {
    try {
      final tripIds = await repository.getUserWishlistTripIds(userId);

      if (tripIds.contains(tripId)) {
        await repository.removeTripFromWishlist(userId, tripId);
      } else {
        await repository.addTripToWishlist(userId, tripId);
      }

      // Reload the wishlist after toggling
      await loadWishlist(userId);
    } catch (e) {
      emit(WishlistError("Failed to update wishlist"));
    }
  }
}
