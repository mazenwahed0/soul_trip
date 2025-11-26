import 'package:equatable/equatable.dart';

abstract class DataUploadState extends Equatable {
  const DataUploadState();
  @override
  List<Object> get props => [];
}

class DataUploadInitial extends DataUploadState {}

class DataUploadLoading extends DataUploadState {}

class DataUploadSuccess extends DataUploadState {
  final String message;
  const DataUploadSuccess(this.message);
  @override
  List<Object> get props => [message];
}

class DataUploadFailure extends DataUploadState {
  final String message;
  const DataUploadFailure(this.message);
  @override
  List<Object> get props => [message];
}
