import 'package:hive/hive.dart';

part 'notification_hive_model.g.dart';

@HiveType(typeId: 1)
class NotificationHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final bool isRead;

  @HiveField(5)
  final String? tripId;

  @HiveField(6)
  final String type;

  @HiveField(7)
  final String? imageUrl;

  NotificationHiveModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
    this.tripId,
    this.type = 'system',
    this.imageUrl,
  });

  /// Convert from NotificationModel to Hive model
  factory NotificationHiveModel.fromNotificationModel(
    Map<String, dynamic> data,
  ) {
    return NotificationHiveModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] is DateTime
          ? data['timestamp']
          : DateTime.now(),
      isRead: data['isRead'] ?? false,
      tripId: data['tripId'],
      type: data['type'] ?? 'system',
      imageUrl: data['imageUrl'],
    );
  }

  /// Convert to Map for repository use
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp,
      'isRead': isRead,
      'tripId': tripId,
      'type': type,
      'imageUrl': imageUrl,
    };
  }

  /// Create a copy with updated fields
  NotificationHiveModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    bool? isRead,
    String? tripId,
    String? type,
    String? imageUrl,
  }) {
    return NotificationHiveModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      tripId: tripId ?? this.tripId,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
