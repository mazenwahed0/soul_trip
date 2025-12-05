import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/home/data/repositories/banner_likes_repository.dart';
import 'banner_likes_state.dart';

class BannerLikesCubit extends Cubit<BannerLikesState> {
  final BannerLikesRepository _repository;
  final String _userId;
  Map<String, bool> _likedBanners = {};
  StreamSubscription? _likesSubscription;

  BannerLikesCubit(this._repository, this._userId)
    : super(BannerLikesInitial()) {
    _listenToLikesChanges();
  }

  /// Listen to real-time changes in likes from Firestore
  void _listenToLikesChanges() {
    if (_userId == 'anonymous') return;

    _likesSubscription = _repository
        .getLikesStream(_userId)
        .listen(
          (likes) {
            _likedBanners = likes;
            emit(BannerLikesLoaded(Map<String, bool>.from(_likedBanners)));
          },
          onError: (error) {
            emit(BannerLikesError('Failed to listen to likes: $error'));
          },
        );
  }

  /// Initialize likes state for specific banners
  Future<void> initializeLikes(List<String> bannerIds) async {
    emit(BannerLikesLoading());

    try {
      final Map<String, bool> likes = {};

      for (final bannerId in bannerIds) {
        final result = await _repository.isBannerLiked(_userId, bannerId);
        result.fold(
          (failure) => null, // Handle error silently for now
          (isLiked) => likes[bannerId] = isLiked,
        );
      }

      _likedBanners = likes;
      emit(BannerLikesLoaded(likes));
    } catch (e) {
      emit(BannerLikesError('Failed to initialize likes'));
    }
  }

  /// Check if a specific banner is liked
  bool isBannerLiked(String bannerId) {
    return _likedBanners[bannerId] ?? false;
  }

  /// Toggle like status for a banner
  Future<void> toggleLike(String bannerId) async {
    print('BannerLikesCubit: Toggling like for banner $bannerId');

    final currentLikeStatus = _likedBanners[bannerId] ?? false;
    print('BannerLikesCubit: Current like status: $currentLikeStatus');

    // Optimistically update UI
    _likedBanners[bannerId] = !currentLikeStatus;
    emit(BannerLikesLoaded(Map<String, bool>.from(_likedBanners)));
    print('BannerLikesCubit: Optimistic update completed');

    try {
      if (currentLikeStatus) {
        // Unlike the banner
        print('BannerLikesCubit: Unliking banner...');
        final result = await _repository.unlikeBanner(_userId, bannerId);
        result.fold(
          (failure) {
            print('BannerLikesCubit: Unlike failed: ${failure.message}');
            // Revert on error
            _likedBanners[bannerId] = currentLikeStatus;
            emit(BannerLikesError(failure.message));
          },
          (_) {
            print('BannerLikesCubit: Unlike successful');
            // Ensure map reflects latest value, then emit loaded map
            _likedBanners[bannerId] = false;
            emit(BannerLikesLoaded(Map<String, bool>.from(_likedBanners)));
          },
        );
      } else {
        // Like the banner
        print('BannerLikesCubit: Liking banner...');
        final result = await _repository.likeBanner(_userId, bannerId);
        result.fold(
          (failure) {
            print('BannerLikesCubit: Like failed: ${failure.message}');
            // Revert on error
            _likedBanners[bannerId] = currentLikeStatus;
            emit(BannerLikesError(failure.message));
          },
          (_) {
            print('BannerLikesCubit: Like successful');
            // Ensure map reflects latest value, then emit loaded map
            _likedBanners[bannerId] = true;
            emit(BannerLikesLoaded(Map<String, bool>.from(_likedBanners)));
          },
        );
      }
    } catch (e) {
      print('BannerLikesCubit: Exception occurred: $e');
      // Revert on error
      _likedBanners[bannerId] = currentLikeStatus;
      emit(BannerLikesError('Failed to toggle like'));
    }
  }

  /// Refresh likes for all banners
  Future<void> refreshLikes() async {
    if (state is BannerLikesLoaded) {
      final bannerIds = _likedBanners.keys.toList();
      await initializeLikes(bannerIds);
    }
  }

  @override
  Future<void> close() {
    _likesSubscription?.cancel();
    return super.close();
  }
}
