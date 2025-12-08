import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/home/data/repositories/banner_repository.dart';
import 'package:soul_trip/features/home/manager/banner_cubit/banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepository _repository;
  StreamSubscription? _bannerSubscription;

  BannerCubit(this._repository) : super(const BannerInitial());

  /// Fetch banners from Firebase
  Future<void> fetchBanners() async {
    emit(const BannerLoading());

    final result = await _repository.fetchBanners();

    // Stop if the user left the screen
    if (isClosed) return;

    result.fold(
      (failure) => emit(BannerError(failure.message)),
      (banners) => emit(BannerLoaded(banners)),
    );
  }

  /// Listen to banner updates
  void streamBanners() {
    emit(const BannerLoading());

    _bannerSubscription?.cancel();
    _bannerSubscription = _repository.streamBanners().listen(
      (either) {
        either.fold(
          (failure) => emit(BannerError(failure.message)),
          (banners) => emit(BannerLoaded(banners)),
        );
      },
      onError: (error) {
        emit(BannerError('Stream error: $error'));
      },
    );
  }

  @override
  Future<void> close() {
    _bannerSubscription?.cancel();
    return super.close();
  }
}
