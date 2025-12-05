import 'package:equatable/equatable.dart';

abstract class TripsLikesState extends Equatable {
  const TripsLikesState();

  @override
  List<Object> get props => [];
}

class TripsLikesInitial extends TripsLikesState {}

class TripsLikesLoading extends TripsLikesState {}

class TripsLikesLoaded extends TripsLikesState {
  final Map<String, bool> likedTrips;

  const TripsLikesLoaded(this.likedTrips);

  @override
  List<Object> get props => [likedTrips];
}

class TripsLikesError extends TripsLikesState {
  final String message;

  const TripsLikesError(this.message);

  @override
  List<Object> get props => [message];
}

class TripLikeToggled extends TripsLikesState {
  final String tripId;
  final bool isLiked;

  const TripLikeToggled(this.tripId, this.isLiked);

  @override
  List<Object> get props => [tripId, isLiked];
}
