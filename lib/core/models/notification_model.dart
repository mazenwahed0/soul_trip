import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? timeAgo;
  final bool isRead;
  final String? tripId;
  final String type; // 'trip_promotion', 'system', etc.
  final String? imageUrl;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.timeAgo,
    this.isRead = false,
    this.tripId,
    this.type = 'system',
    this.imageUrl,
  });

  factory NotificationModel.fromFirestore(
    Map<String, dynamic> data,
    String id,
  ) {
    return NotificationModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      timeAgo: data['timeAgo'],
      isRead: data['isRead'] ?? false,
      tripId: data['tripId'],
      type: data['type'] ?? 'system',
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
      'timeAgo': timeAgo,
      'isRead': isRead,
      'tripId': tripId,
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    String? timeAgo,
    bool? isRead,
    String? tripId,
    String? type,
    String? imageUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      timeAgo: timeAgo ?? this.timeAgo,
      isRead: isRead ?? this.isRead,
      tripId: tripId ?? this.tripId,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
