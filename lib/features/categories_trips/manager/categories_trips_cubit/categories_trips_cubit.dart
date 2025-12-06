import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/categories_trips/manager/categories_trips_cubit/categories_trips_state.dart';

class CategoriesTripsCubit extends Cubit<CategoriesTripsState> {
  final CategoriesTripsRepository _repository;
  StreamSubscription? _categoriesSubscription;

  CategoriesTripsCubit(this._repository)
    : super(const CategoriesTripsInitial());

  Future<void> fetchCategories() async {
    emit(const CategoriesTripsLoading());

    final result = await _repository.fetchCategories();

    // Stop if the user left the screen
    if (isClosed) return;

    result.fold(
      (failure) => emit(CategoriesTripsError(failure.message)),
      (categories) => emit(CategoriesTripsLoaded(categories)),
    );
  }

  void streamCategories() {
    emit(const CategoriesTripsLoading());

    _categoriesSubscription?.cancel();

    _categoriesSubscription = _repository.streamCategories().listen(
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

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
