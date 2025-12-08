import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/experts/data/models/Expert_model.dart';

import 'package:soul_trip/features/experts/data/repo/experts_repository.dart';
import 'package:soul_trip/features/experts/logic/read_expert_data/expert_state.dart';

class ExpertCubit extends Cubit<ExpertState> {
  final ExpertsRepository repo;

  List<ExpertModel> allExperts = [];

  ExpertCubit({required this.repo}) : super(ExpertInitial());

  void listenToexpert() {
    emit(ExpertLoading());

    repo.getAllExperts().listen(
      (experts) {
        allExperts = experts;
        emit(ExpertLoaded(expert: experts));
      },
      onError: (err) {
        emit(ExpertError(err.toString()));
      },
    );
  }

  void getExpertById(String id) {
    emit(ExpertLoading());
    repo
        .getExpertById(id)
        .listen(
          (expert) {
            emit(ExpertLoaded(expert: [expert]));
          },
          onError: (err) {
            emit(ExpertError(err.toString()));
          },
        );
  }

  void searchExperts(String query) {
    if (query.isEmpty) {
      emit(ExpertLoaded(expert: allExperts));
      return;
    }
    final text = query.toLowerCase();
    final filtered = allExperts.where((expert) {
      final nameMatch = expert.name.toLowerCase().contains(text);
      final locationMatch = expert.location.toLowerCase().contains(text);
      final specializationMatch = expert.specialization.toLowerCase().contains(
        text,
      );

      return nameMatch || locationMatch || specializationMatch;
    }).toList();
    emit(ExpertLoaded(expert: filtered));
  }

}

