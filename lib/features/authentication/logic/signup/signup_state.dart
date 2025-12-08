import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();
  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupUpdateUI extends SignupState {
  final int t = DateTime.now().millisecondsSinceEpoch;
  @override
  List<Object> get props => [t];
}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailure extends SignupState {
  final String message;
  const SignupFailure(this.message);
  @override
  List<Object> get props => [message];
}
