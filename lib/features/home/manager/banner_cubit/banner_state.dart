import 'package:equatable/equatable.dart';
import 'package:soul_trip/core/models/banner_model.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {
  const BannerInitial();
}

class BannerLoading extends BannerState {
  const BannerLoading();
}

class BannerLoaded extends BannerState {
  final List<BannerModel> banners;

  const BannerLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class BannerError extends BannerState {
  final String message;

  const BannerError(this.message);

  @override
  List<Object?> get props => [message];
}
