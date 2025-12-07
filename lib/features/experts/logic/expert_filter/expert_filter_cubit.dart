import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/data/models/ExpertFilter.dart';
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';

import 'package:soul_trip/features/experts/logic/expert_filter/expert_filter_state.dart';

class ExpertFilterCubit extends Cubit<ExpertFilterState> {
  List<ExpertModel> allExperts;
  ExpertFilterModel filter = ExpertFilterModel.empty();

  ExpertFilterCubit({required this.allExperts}) : super(ExpertFilterInitial());

  // Set Filter Values
  void setSessionType(String type) {
    filter = filter.copyWith(sessionType: type);
    emit(ExpertFilterUpdated(filter));
  }

  void setLocation(String loc) {
    filter = filter.copyWith(location: loc);
    emit(ExpertFilterUpdated(filter));
  }

  void setSpecialization(String spec) {
    filter = filter.copyWith(specialization: spec);
    emit(ExpertFilterUpdated(filter));
  }

  void setRating(double rating) {
    filter = filter.copyWith(minRating: rating);
    emit(ExpertFilterUpdated(filter));
  }

  void setPrice(double value) {
    filter = filter.copyWith(maxPrice: value);
    emit(ExpertFilterUpdated(filter));
  }

  void setAvailableDays(List<String> days) {
    filter = filter.copyWith(availabilityDays: days);
    emit(ExpertFilterUpdated(filter));
  }

  // Apply Filters
  List<ExpertModel> applyFilter() {
    List<ExpertModel> result = allExperts;

    if (filter.sessionType != null) {
      result = result.where((e) => e.sessionType == filter.sessionType).toList();
    }

    if (filter.location != null) {
      result = result.where((e) => e.location.contains(filter.location!)).toList();
    }

    if (filter.specialization != null) {
      result = result.where((e) => e.specialization == filter.specialization).toList();
    }

    if (filter.minRating != null) {
      result = result.where((e) => e.rating >= filter.minRating!).toList();
    }

    if (filter.maxPrice != null) {
      result = result.where((e) => e.price <= filter.maxPrice!).toList();
    }

    if (filter.availabilityDays != null) {
      result = result.where((e) {
        return e.availabilityDays
            .any((day) => filter.availabilityDays!.contains(day));
      }).toList();
    }

    emit(ExpertFilterApplied(result));

    return result;
  }

  void reset() {
    filter = ExpertFilterModel.empty();
    emit(ExpertFilterUpdated(filter));
  }
}

