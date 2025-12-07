
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';

abstract class ExpertState {
  const ExpertState();
}

class ExpertInitial extends ExpertState {
  const ExpertInitial();
}

class ExpertLoading extends ExpertState {
  const ExpertLoading();
}

class ExpertLoaded extends ExpertState {
  final List<ExpertModel> expert;

  const ExpertLoaded({required this.expert});
}

class ExpertError extends ExpertState {
  final String message;
  const ExpertError(this.message);
}
