import 'package:soul_trip/core/models/home_trip_model.dart';

abstract class TripDetailsState {}

class TripDetailsInitial extends TripDetailsState {}

class TripDetailsLoading extends TripDetailsState {}

class TripDetailsLoaded extends TripDetailsState {
  final HomeTripModel trip;
  final int selectedTabIndex;

  TripDetailsLoaded({required this.trip, this.selectedTabIndex = 0});

  TripDetailsLoaded copyWith({HomeTripModel? trip, int? selectedTabIndex}) {
    return TripDetailsLoaded(
      trip: trip ?? this.trip,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }
}

class TripDetailsError extends TripDetailsState {
  final String message;

  TripDetailsError({required this.message});
}
