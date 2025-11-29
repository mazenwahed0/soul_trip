import 'package:equatable/equatable.dart';

abstract class BannerLikesState extends Equatable {
  const BannerLikesState();

  @override
  List<Object> get props => [];
}

class BannerLikesInitial extends BannerLikesState {}

class BannerLikesLoading extends BannerLikesState {}

class BannerLikesLoaded extends BannerLikesState {
  final Map<String, bool> likedBanners;

  const BannerLikesLoaded(this.likedBanners);

  @override
  List<Object> get props => [likedBanners];
}

class BannerLikesError extends BannerLikesState {
  final String message;

  const BannerLikesError(this.message);

  @override
  List<Object> get props => [message];
}

class BannerLikeToggled extends BannerLikesState {
  final String bannerId;
  final bool isLiked;

  const BannerLikeToggled(this.bannerId, this.isLiked);

  @override
  List<Object> get props => [bannerId, isLiked];
}
