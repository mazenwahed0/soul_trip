import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_state.dart';

class CategoriesTripsCubit extends Cubit<CategoriesTripsState> {
  final CategoriesTripsRepository _repository;

  CategoriesTripsCubit(this._repository)
    : super(const CategoriesTripsInitial());

  Future<void> fetchCategories() async {
    emit(const CategoriesTripsLoading());

    final result = await _repository.fetchCategories();

    result.fold(
      (failure) => emit(CategoriesTripsError(failure.message)),
      (categories) => emit(CategoriesTripsLoaded(categories)),
    );
  }

  void streamCategories() {
    emit(const CategoriesTripsLoading());

    _repository.streamCategories().listen(
      (either) {
        either.fold(
          (failure) => emit(CategoriesTripsError(failure.message)),
          (categories) => emit(CategoriesTripsLoaded(categories)),
        );
      },
      onError: (error) {
        emit(CategoriesTripsError('Stream error: $error'));
      },
    );
  }
}
