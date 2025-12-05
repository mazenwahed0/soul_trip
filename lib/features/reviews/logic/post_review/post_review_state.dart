import 'package:equatable/equatable.dart';
import 'package:soul_trip/core/models/review_model.dart';

class ReviewState extends Equatable {
  final List<ReviewModel> reviews;
  final String? errorMessage;

  const ReviewState({this.reviews = const [], this.errorMessage});

  @override
  List<Object?> get props => [reviews, errorMessage];
}
