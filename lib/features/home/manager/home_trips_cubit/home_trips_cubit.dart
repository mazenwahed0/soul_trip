import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/home/data/repositories/home_trips_repository.dart';
import 'package:soul_trip/features/home/manager/home_trips_cubit/home_trips_state.dart';

class HomeTripsCubit extends Cubit<HomeTripsState> {
  final HomeTripsRepository _repository;
  StreamSubscription? _tripsSubscription;

  HomeTripsCubit(this._repository) : super(const HomeTripsInitial());

  Future<void> fetchMostPopularTrips() async {
    emit(const HomeTripsLoading());

    final result = await _repository.fetchTrips();

    // Stop if the user left the screen
    if (isClosed) return;

    result.fold(
      (failure) => emit(HomeTripsError(failure.message)),
      (trips) => emit(HomeTripsLoaded(trips)),
    );
  }

  void streamMostPopularTrips() {
    emit(const HomeTripsLoading());

    _tripsSubscription?.cancel();
    _tripsSubscription = _repository.streamTrips().listen(
      (either) {
        either.fold(
          (failure) => emit(HomeTripsError(failure.message)),
          (trips) => emit(HomeTripsLoaded(trips)),
        );
      },
      onError: (error) {
        emit(HomeTripsError('Stream error: $error'));
      },
    );
  }

  @override
  Future<void> close() {
    _tripsSubscription?.cancel();
    return super.close();
  }
}
