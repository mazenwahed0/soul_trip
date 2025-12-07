import 'package:equatable/equatable.dart';

abstract class CategoryTripsLikesState extends Equatable {
  const CategoryTripsLikesState();

  @override
  List<Object> get props => [];
}

class CategoryTripsLikesInitial extends CategoryTripsLikesState {}

class CategoryTripsLikesLoading extends CategoryTripsLikesState {}

class CategoryTripsLikesLoaded extends CategoryTripsLikesState {
  final Map<String, bool> likedTrips;

  const CategoryTripsLikesLoaded(this.likedTrips);

  @override
  List<Object> get props => [likedTrips];
}

class CategoryTripsLikesError extends CategoryTripsLikesState {
  final String message;

  const CategoryTripsLikesError(this.message);

  @override
  List<Object> get props => [message];
}
