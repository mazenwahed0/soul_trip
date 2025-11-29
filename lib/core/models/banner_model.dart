import 'package:soul_trip/core/utils/images.dart';

class BannerModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String? image;
  final double rate;

  BannerModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    this.image,
    required this.rate,
  });

  factory BannerModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BannerModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      image: data['image'] ?? Images.banner1,
      rate: (data['rate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'image': image,
      'rate': rate,
    };
  }
}
