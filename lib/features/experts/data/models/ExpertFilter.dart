class ExpertFilterModel {
  final String? sessionType;
  final String? location;
  final String? specialization;
  final double? minRating;
  final double? maxPrice;
  final List<String>? availabilityDays;

  ExpertFilterModel({
    this.sessionType,
    this.location,
    this.specialization,
    this.minRating,
    this.maxPrice,
    this.availabilityDays,
  });

  ExpertFilterModel copyWith({
    String? sessionType,
    String? location,
    String? specialization,
    double? minRating,
    double? maxPrice,
    List<String>? availabilityDays,
  }) {
    return ExpertFilterModel(
      sessionType: sessionType ?? this.sessionType,
      location: location ?? this.location,
      specialization: specialization ?? this.specialization,
      minRating: minRating ?? this.minRating,
      maxPrice: maxPrice ?? this.maxPrice,
      availabilityDays: availabilityDays ?? this.availabilityDays,
    );
  }

  static ExpertFilterModel empty() => ExpertFilterModel();
}

