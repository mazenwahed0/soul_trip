import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/category_trips/data/repositories/category_trips_repository.dart';
import 'package:soul_trip/features/category_trips/manager/category_trips_cubit/category_trips_state.dart';

class CategoryTripsCubit extends Cubit<CategoryTripsState> {
  final CategoryTripsRepository _repository;
  final String categoryName;

  CategoryTripsCubit(this._repository, this.categoryName)
    : super(const CategoryTripsInitial());

  Future<void> fetchTrips() async {
    emit(const CategoryTripsLoading());

    final result = await _repository.fetchTripsByCategory(categoryName);

    result.fold(
      (failure) => emit(CategoryTripsError(failure.message)),
      (trips) => emit(CategoryTripsLoaded(trips)),
    );
  }

  void streamTrips() {
    emit(const CategoryTripsLoading());

    _repository
        .streamTripsByCategory(categoryName)
        .listen(
          (either) {
            either.fold(
              (failure) => emit(CategoryTripsError(failure.message)),
              (trips) => emit(CategoryTripsLoaded(trips)),
            );
          },
          onError: (error) {
            emit(CategoryTripsError('Stream error: $error'));
          },
        );
  }
}
