import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginUpdateUI extends LoginState {
  // To force rebuilds when just toggling UI elements if needed,
  final int timestamp;
  LoginUpdateUI() : timestamp = DateTime.now().millisecondsSinceEpoch;
  @override
  List<Object> get props => [timestamp];
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  const LoginFailure(this.message);
  @override
  List<Object> get props => [message];
}
