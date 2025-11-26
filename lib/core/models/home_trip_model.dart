import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTripModel {
  final String id;
  final String title;
  final String location;
  final String? category;
  final String? image;
  final num off;
  final num price;
  final num rate;
  final DateTime? date;
  final bool isMostPopular;

  HomeTripModel({
    required this.id,
    required this.title,
    required this.location,
    this.category,
    this.image,
    required this.off,
    required this.price,
    required this.rate,
    this.date,
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
      price: (data['price'] ?? 0) as num,
      rate: (data['rate'] ?? 0) as num,
      date: (data['date'] is Timestamp)
          ? (data['date'] as Timestamp).toDate()
          : null,
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
      'price': price,
      'rate': rate,
      'date': date,
      'isMostPopular': isMostPopular,
    };
  }

  int? get daysFromToday {
    if (date == null) return null;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tripDay = DateTime(date!.year, date!.month, date!.day);

    return today.difference(tripDay).inDays;
  }
}
