import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_upload/data_upload_repository.dart';
import 'data_upload_state.dart';

class DataUploadCubit extends Cubit<DataUploadState> {
  final DataUploadRepository _repository;

  DataUploadCubit(this._repository) : super(DataUploadInitial());

  Future<void> uploadOnboardingData() async {
    emit(DataUploadLoading());
    final result = await _repository.uploadOnboardingData();
    result.fold(
      (failure) => emit(DataUploadFailure(failure.message)),
      (success) => emit(DataUploadSuccess(success)),
    );
  }
}
