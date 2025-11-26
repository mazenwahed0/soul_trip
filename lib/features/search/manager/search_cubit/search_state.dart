import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:soul_trip/core/models/category_trip_model.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';

class SearchFilters {
  final String? location;
  final Set<String> categories;
  final RangeValues budget;
  final DateTime? date;
  final int travellers;

  const SearchFilters({
    this.location,
    this.categories = const {},
    this.budget = const RangeValues(0, 10000),
    this.date,
    this.travellers = 1,
  });

  SearchFilters copyWith({
    String? location,
    bool clearLocation = false,
    Set<String>? categories,
    RangeValues? budget,
    DateTime? date,
    bool clearDate = false,
    int? travellers,
  }) {
    return SearchFilters(
      location: clearLocation ? null : (location ?? this.location),
      categories: categories ?? this.categories,
      budget: budget ?? this.budget,
      date: clearDate ? null : (date ?? this.date),
      travellers: travellers ?? this.travellers,
    );
  }
}

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<HomeTripModel> allTrips;
  final List<CategoryTripModel> categories;
  final List<String> locations;
  final SearchFilters filters;
  final List<HomeTripModel> filteredTrips;

  const SearchLoaded({
    required this.allTrips,
    required this.categories,
    required this.locations,
    required this.filters,
    required this.filteredTrips,
  });

  SearchLoaded copyWith({
    List<HomeTripModel>? allTrips,
    List<CategoryTripModel>? categories,
    List<String>? locations,
    SearchFilters? filters,
    List<HomeTripModel>? filteredTrips,
  }) {
    return SearchLoaded(
      allTrips: allTrips ?? this.allTrips,
      categories: categories ?? this.categories,
      locations: locations ?? this.locations,
      filters: filters ?? this.filters,
      filteredTrips: filteredTrips ?? this.filteredTrips,
    );
  }

  @override
  List<Object?> get props => [
    allTrips,
    categories,
    locations,
    filters,
    filteredTrips,
  ];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
