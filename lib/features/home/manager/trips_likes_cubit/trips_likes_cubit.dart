import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/home/data/repositories/trips_likes_repository.dart';
import 'trips_likes_state.dart';

class TripsLikesCubit extends Cubit<TripsLikesState> {
  final TripsLikesRepository _repository;
  final String _userId;
  Map<String, bool> _likedTrips = {};
  StreamSubscription? _likesSubscription;

  TripsLikesCubit(this._repository, this._userId) : super(TripsLikesInitial()) {
    _listenToLikesChanges();
  }

  /// Listen to real-time changes in likes from Firestore
  void _listenToLikesChanges() {
    if (_userId == 'anonymous') return;

    _likesSubscription = _repository
        .getLikesStream(_userId)
        .listen(
          (likes) {
            _likedTrips = likes;
            emit(TripsLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
          onError: (error) {
            emit(TripsLikesError('Failed to listen to likes: $error'));
          },
        );
  }

  /// Check if a specific trip is liked
  bool isTripLiked(String tripId) {
    return _likedTrips[tripId] ?? false;
  }

  /// Toggle like status for a trip
  Future<void> toggleLike(String tripId) async {
    final currentLikeStatus = _likedTrips[tripId] ?? false;

    // Optimistically update UI
    _likedTrips[tripId] = !currentLikeStatus;
    emit(TripsLikesLoaded(Map<String, bool>.from(_likedTrips)));

    try {
      if (currentLikeStatus) {
        // Unlike the trip
        final result = await _repository.unlikeTrip(_userId, tripId);
        result.fold(
          (failure) {
            // Revert on error
            _likedTrips[tripId] = currentLikeStatus;
            emit(TripsLikesError(failure.message));
          },
          (_) {
            // Success - Stream will update eventually, but we keep local state consistent
            _likedTrips[tripId] = false;
            emit(TripsLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
        );
      } else {
        // Like the trip
        final result = await _repository.likeTrip(_userId, tripId);
        result.fold(
          (failure) {
            // Revert on error
            _likedTrips[tripId] = currentLikeStatus;
            emit(TripsLikesError(failure.message));
          },
          (_) {
            // Success
            _likedTrips[tripId] = true;
            emit(TripsLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
        );
      }
    } catch (e) {
      // Revert on error
      _likedTrips[tripId] = currentLikeStatus;
      emit(TripsLikesError('Failed to toggle like'));
    }
  }

  /// Refresh likes for all trips
  Future<void> refreshLikes() async {
    // Stream handles refresh automatically
  }

  @override
  Future<void> close() {
    _likesSubscription?.cancel();
    return super.close();
  }
}
