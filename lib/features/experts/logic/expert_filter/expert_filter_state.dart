import 'package:soul_trip/features/experts/data/models/expert_filter_model.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';

abstract class ExpertFilterState {}

class ExpertFilterInitial extends ExpertFilterState {}

class ExpertFilterUpdated extends ExpertFilterState {
  final ExpertFilterModel filter;
  ExpertFilterUpdated(this.filter);
}

class ExpertFilterApplied extends ExpertFilterState {
  final List<ExpertModel> filteredExperts;
  ExpertFilterApplied(this.filteredExperts);
}
