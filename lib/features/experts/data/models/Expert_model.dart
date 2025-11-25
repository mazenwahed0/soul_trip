class ExpertModel {
  final String id;            
  final String name;
  final String specialization;
  final String location;
  final String image;
  final int experienceYears;
  final int fees;
  final int price;
  final double rating;
  final int reviewsCount;

  ExpertModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.image,
    required this.experienceYears,
    required this.fees,
    required this.price,
    required this.rating,
    required this.reviewsCount,
  });


  factory ExpertModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ExpertModel(
      id: documentId,
      name: data['name'] ?? '',
      specialization: data['specialization'] ?? '',
      location: data['location'] ?? '',
      image: data['image'] ?? '',
      experienceYears: data['experienceYears'] ?? 0,
      fees: data['fees'] ?? 0,
      price: data['price'] ?? 0,
      rating: (data['rating'] ?? 0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
    );
  }
}
