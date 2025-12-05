import 'package:equatable/equatable.dart';

abstract class SearchLikesState extends Equatable {
  const SearchLikesState();

  @override
  List<Object> get props => [];
}

class SearchLikesInitial extends SearchLikesState {}

class SearchLikesLoading extends SearchLikesState {}

class SearchLikesLoaded extends SearchLikesState {
  final Map<String, bool> likedTrips;

  const SearchLikesLoaded(this.likedTrips);

  @override
  List<Object> get props => [likedTrips];
}

class SearchLikesError extends SearchLikesState {
  final String message;

  const SearchLikesError(this.message);

  @override
  List<Object> get props => [message];
}
