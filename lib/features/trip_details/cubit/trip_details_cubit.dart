import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/features/trip_details/cubit/trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  TripDetailsCubit() : super(TripDetailsInitial());

  void init(HomeTripModel trip) {
    emit(TripDetailsLoaded(trip: trip));
  }

  void changeTab(int index) {
    if (state is TripDetailsLoaded) {
      final currentState = state as TripDetailsLoaded;
      emit(currentState.copyWith(selectedTabIndex: index));
    }
  }
}
