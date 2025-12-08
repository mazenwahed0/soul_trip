import 'package:equatable/equatable.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';

abstract class HomeTripsState extends Equatable {
  const HomeTripsState();

  @override
  List<Object?> get props => [];
}

class HomeTripsInitial extends HomeTripsState {
  const HomeTripsInitial();
}

class HomeTripsLoading extends HomeTripsState {
  const HomeTripsLoading();
}

class HomeTripsLoaded extends HomeTripsState {
  final List<HomeTripModel> trips;

  const HomeTripsLoaded(this.trips);

  @override
  List<Object?> get props => [trips];
}

class HomeTripsError extends HomeTripsState {
  final String message;

  const HomeTripsError(this.message);

  @override
  List<Object?> get props => [message];
}
