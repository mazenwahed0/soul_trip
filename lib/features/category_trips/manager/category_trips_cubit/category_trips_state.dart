import 'package:equatable/equatable.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';

abstract class CategoryTripsState extends Equatable {
  const CategoryTripsState();

  @override
  List<Object?> get props => [];
}

class CategoryTripsInitial extends CategoryTripsState {
  const CategoryTripsInitial();
}

class CategoryTripsLoading extends CategoryTripsState {
  const CategoryTripsLoading();
}

class CategoryTripsLoaded extends CategoryTripsState {
  final List<HomeTripModel> trips;

  const CategoryTripsLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class CategoryTripsError extends CategoryTripsState {
  final String message;

  const CategoryTripsError(this.message);

  @override
  List<Object?> get props => [message];
}
