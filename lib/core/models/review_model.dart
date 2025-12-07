import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String docId;
  final String userId;
  final String name;
  final DateTime time;
  final String caption;
  final String profileImage;
  final String? reviewImage;
  final int likes;
  final int comments;
  final int shares;
  final List<String> likedBy;
  final List<String> savedBy;

  const ReviewModel({
    this.docId = '',
    required this.userId,
    required this.name,
    required this.time,
    required this.caption,
    required this.profileImage,
    this.reviewImage,
    required this.likes,
    required this.comments,
    required this.shares,
    this.likedBy = const [],
    this.savedBy = const [],
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      docId: map['docId'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      time: (map['time'] as Timestamp?)?.toDate() ?? DateTime.now(),
      caption: map['caption'] ?? '',
      profileImage: map['profileImage'] ?? '',
      reviewImage: map['reviewImage'] ?? '',
      likes: (map['likes'] ?? 0).toInt(),
      comments: (map['comments'] ?? 0).toInt(),
      shares: (map['shares'] ?? 0).toInt(),
      likedBy: List<String>.from(map['likedBy'] ?? []),
      savedBy: List<String>.from(map['savedBy'] ?? []),
    );
  }

  // Add a copyWith method for easier updates
  ReviewModel copyWith({
    String? docId,
    String? userId,
    String? name,
    DateTime? time,
    String? caption,
    String? profileImage,
    String? reviewImage,
    int? likes,
    int? comments,
    int? shares,
    List<String>? likedBy,
    List<String>? savedBy,
  }) {
    return ReviewModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      time: time ?? this.time,
      caption: caption ?? this.caption,
      profileImage: profileImage ?? this.profileImage,
      reviewImage: reviewImage ?? this.reviewImage,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      likedBy: likedBy ?? this.likedBy,
      savedBy: savedBy ?? this.savedBy,
    );
  }
}
