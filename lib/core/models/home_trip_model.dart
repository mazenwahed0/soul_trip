import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTripModel {
  final String id;
  final String title;
  final String location;
  final String? category;
  final String? image;
  final num off;
  final bool isMostPopular;

  HomeTripModel({
    required this.id,
    required this.title,
    required this.location,
    this.category,
    this.image,
    required this.off,
    required this.isMostPopular,
  });

  factory HomeTripModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return HomeTripModel(
      id: doc.id,
      title: data['title'] ?? '',
      location: data['location'] ?? '',
      category: data['category'] as String?,
      image: data['image'] as String?,
      off: (data['off'] ?? 0) is int
          ? data['off'] as int
          : (data['off'] as num?)?.toInt() ?? 0,
      isMostPopular: data['isMostPopular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'category': category,
      'image': image,
      'off': off,
      'isMostPopular': isMostPopular,
    };
  }
}
