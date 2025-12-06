import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_trip/core/models/home_trip_model.dart' as core;

class HomeTripModel {
  final String id;
  final String title;
  final String location;
  final double price;
  final String image;
  final double rate;
  final int off;
  final bool isMostPopular;
  final String category;
  final DateTime date;

  HomeTripModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.image,
    required this.rate,
    required this.off,
    required this.isMostPopular,
    required this.category,
    required this.date,
  });

  // Convert to core model
  core.HomeTripModel toCoreModel() {
    return core.HomeTripModel(
      id: id,
      title: title,
      location: location,
      price: price,
      image: image,
      rate: rate,
      off: off,
      isMostPopular: isMostPopular,
      category: category,
      date: date,
    );
  }

  factory HomeTripModel.fromMap(Map<String, dynamic> map, String id) {
    return HomeTripModel(
      id: id,
      title: map['title'] ?? '',
      location: map['location'] ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : (map['price'] as double? ?? 0.0),
      image: map['image'] ?? '',
      rate: (map['rate'] is int)
          ? (map['rate'] as int).toDouble()
          : (map['rate'] as double? ?? 0.0),
      off: map['off'] ?? 0,
      isMostPopular: map['isMostPopular'] ?? false,
      category: map['category'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'price': price,
      'image': image,
      'rate': rate,
      'off': off,
      'isMostPopular': isMostPopular,
      'category': category,
      'date': date,
    };
  }
}
