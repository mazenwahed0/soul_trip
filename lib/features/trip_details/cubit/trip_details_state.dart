abstract class TripDetailsState {}

class TripDetailsInitial extends TripDetailsState {}

class TripDetailsLoading extends TripDetailsState {}

class TripDetailsLoaded extends TripDetailsState {
  final Map<String, dynamic> tripData;

  TripDetailsLoaded({required this.tripData});
}

class TripDetailsError extends TripDetailsState {
  final String message;

  TripDetailsError({required this.message});
}

class TripDetailsNoInternet extends TripDetailsState {}
