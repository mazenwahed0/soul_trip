import 'package:dartz/dartz.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/category_trip_model.dart';
import 'package:soul_trip/core/models/home_trip_model.dart';
import 'package:soul_trip/features/categories_trips/data/repositories/categories_trips_repository.dart';
import 'package:soul_trip/features/home/data/repositories/home_trips_repository.dart';

class SearchRepository {
  final HomeTripsRepository _homeTripsRepository;
  final CategoriesTripsRepository _categoriesTripsRepository;

  SearchRepository(this._homeTripsRepository, this._categoriesTripsRepository);

  Future<Either<Failure, List<HomeTripModel>>> getAllTrips() {
    return _homeTripsRepository.fetchTrips();
  }

  Stream<Either<Failure, List<HomeTripModel>>> streamAllTrips() {
    return _homeTripsRepository.streamTrips();
  }

  Future<Either<Failure, List<CategoryTripModel>>> getAllCategories() async {
    return _categoriesTripsRepository.fetchCategories();
  }

  Stream<Either<Failure, List<CategoryTripModel>>> streamAllCategories() {
    return _categoriesTripsRepository.streamCategories();
  }
}
