import 'package:equatable/equatable.dart';
import 'package:soul_trip/core/models/category_trip_model.dart';

abstract class CategoriesTripsState extends Equatable {
  const CategoriesTripsState();

  @override
  List<Object?> get props => [];
}

class CategoriesTripsInitial extends CategoriesTripsState {
  const CategoriesTripsInitial();
}

class CategoriesTripsLoading extends CategoriesTripsState {
  const CategoriesTripsLoading();
}

class CategoriesTripsLoaded extends CategoriesTripsState {
  final List<CategoryTripModel> categories;

  const CategoriesTripsLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoriesTripsError extends CategoriesTripsState {
  final String message;

  const CategoriesTripsError(this.message);

  @override
  List<Object?> get props => [message];
}
