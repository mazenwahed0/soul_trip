import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final String message;
  const UserSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class UserFailure extends UserState {
  final String message;
  const UserFailure(this.message);
  @override
  List<Object?> get props => [message];
}
