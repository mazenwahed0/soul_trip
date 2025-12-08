import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/search/data/repositories/search_likes_repository.dart';
import 'search_likes_state.dart';

class SearchLikesCubit extends Cubit<SearchLikesState> {
  final SearchLikesRepository _repository;
  final String _userId;
  Map<String, bool> _likedTrips = {};
  StreamSubscription? _likesSubscription;

  SearchLikesCubit(this._repository, this._userId)
    : super(SearchLikesInitial()) {
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
            emit(SearchLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
          onError: (error) {
            emit(SearchLikesError('Failed to listen to likes: $error'));
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
    emit(SearchLikesLoaded(Map<String, bool>.from(_likedTrips)));

    try {
      if (currentLikeStatus) {
        // Unlike the trip
        final result = await _repository.unlikeTrip(_userId, tripId);
        result.fold(
          (failure) {
            // Revert on error
            _likedTrips[tripId] = currentLikeStatus;
            emit(SearchLikesError(failure.message));
          },
          (_) {
            // Success - Stream will update eventually, but we keep local state consistent
            _likedTrips[tripId] = false;
            emit(SearchLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
        );
      } else {
        // Like the trip
        final result = await _repository.likeTrip(_userId, tripId);
        result.fold(
          (failure) {
            // Revert on error
            _likedTrips[tripId] = currentLikeStatus;
            emit(SearchLikesError(failure.message));
          },
          (_) {
            // Success
            _likedTrips[tripId] = true;
            emit(SearchLikesLoaded(Map<String, bool>.from(_likedTrips)));
          },
        );
      }
    } catch (e) {
      // Revert on error
      _likedTrips[tripId] = currentLikeStatus;
      emit(SearchLikesError('Failed to toggle like'));
    }
  }

  @override
  Future<void> close() {
    _likesSubscription?.cancel();
    return super.close();
  }
}
