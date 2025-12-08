part of 'wishlist_cubit.dart';

abstract class WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistEmpty extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<HomeTripModel> trips;
  WishlistLoaded(this.trips);
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}
