import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/features/search/data/repositories/search_repository.dart';
import 'package:soul_trip/features/search/manager/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;

  SearchCubit(this._repository) : super(const SearchInitial());

  Future<void> loadInitialData() async {
    emit(const SearchLoading());

    final tripsResult = await _repository.getAllTrips();
    final categoriesResult = await _repository.getAllCategories();

    tripsResult.fold((failure) => emit(SearchError(failure.message)), (trips) {
      categoriesResult.fold((failure) => emit(SearchError(failure.message)), (
        categories,
      ) {
        final locations = trips.map((t) => t.location).toSet().toList()..sort();

        final filters = const SearchFilters();
        final filtered = _applyFilters(trips, filters);

        emit(
          SearchLoaded(
            allTrips: trips,
            categories: categories,
            locations: locations,
            filters: filters,
            filteredTrips: filtered,
          ),
        );
      });
    });
  }

  void updateLocation(String? location) {
    final current = state;
    if (current is! SearchLoaded) return;

    final newFilters = current.filters.copyWith(location: location);
    _emitWithFilters(current, newFilters);
  }

  void toggleCategory(String categoryName) {
    final current = state;
    if (current is! SearchLoaded) return;

    final newSet = Set<String>.from(current.filters.categories);
    if (newSet.contains(categoryName)) {
      newSet.remove(categoryName);
    } else {
      newSet.add(categoryName);
    }

    final newFilters = current.filters.copyWith(categories: newSet);
    _emitWithFilters(current, newFilters);
  }

  void updateBudget(RangeValues values) {
    final current = state;
    if (current is! SearchLoaded) return;

    final newFilters = current.filters.copyWith(budget: values);
    _emitWithFilters(current, newFilters);
  }

  void updateTravellers(int travellers) {
    final current = state;
    if (current is! SearchLoaded) return;

    final newFilters = current.filters.copyWith(travellers: travellers);
    _emitWithFilters(current, newFilters);
  }

  void updateDate(DateTime date) {
    final current = state;
    if (current is! SearchLoaded) return;

    final newFilters = current.filters.copyWith(date: date);
    _emitWithFilters(current, newFilters);
  }

  void resetAll() {
    final current = state;
    if (current is! SearchLoaded) return;

    const filters = SearchFilters();
    _emitWithFilters(current, filters);
  }

  void _emitWithFilters(SearchLoaded current, SearchFilters filters) {
    final filtered = _applyFilters(current.allTrips, filters);
    emit(current.copyWith(filters: filters, filteredTrips: filtered));
  }

  List<HomeTripModel> _applyFilters(
    List<HomeTripModel> allTrips,
    SearchFilters filters,
  ) {
    return allTrips.where((trip) {
      final price = trip.price.toDouble();

      final matchLocation =
          filters.location == null || trip.location == filters.location;

      final matchCategory =
          filters.categories.isEmpty ||
          (trip.category != null && filters.categories.contains(trip.category));

      final matchBudget =
          price >= filters.budget.start && price <= filters.budget.end;

      final matchDate = () {
        if (filters.date == null) return true;
        if (trip.date == null) return false;

        final filterDay = DateTime(
          filters.date!.year,
          filters.date!.month,
          filters.date!.day,
        );
        final tripDay = DateTime(
          trip.date!.year,
          trip.date!.month,
          trip.date!.day,
        );

        return !tripDay.isBefore(filterDay);
      }();

      return matchLocation && matchCategory && matchBudget && matchDate;
    }).toList();
  }
}
