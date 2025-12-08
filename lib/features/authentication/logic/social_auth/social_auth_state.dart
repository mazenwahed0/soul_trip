import 'package:equatable/equatable.dart';

abstract class SocialAuthState extends Equatable {
  const SocialAuthState();
  @override
  List<Object> get props => [];
}

class SocialAuthInitial extends SocialAuthState {}

class SocialAuthLoading extends SocialAuthState {}

class SocialAuthSuccess extends SocialAuthState {}

class SocialAuthFailure extends SocialAuthState {
  final String message;
  const SocialAuthFailure(this.message);
  @override
  List<Object> get props => [message];
}
