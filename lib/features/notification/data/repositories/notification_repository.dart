import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/notification_model.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch notifications for a user
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications(
    String userId,
  ) async {
    try {
      final snapshot = await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .get();

      final notifications = snapshot.docs
          .map((doc) => NotificationModel.fromFirestore(doc.data(), doc.id))
          .toList();

      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Stream notifications for a user
  Stream<Either<Failure, List<NotificationModel>>> streamNotifications(
    String userId,
  ) {
    return _firestore
        .collection('notifications')
        .doc(userId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          try {
            final notifications = snapshot.docs
                .map(
                  (doc) => NotificationModel.fromFirestore(doc.data(), doc.id),
                )
                .toList();
            return Right(notifications);
          } catch (e) {
            return Left(ServerFailure(e.toString()));
          }
        });
  }

  /// Mark a notification as read
  Future<Either<Failure, void>> markAsRead(
    String userId,
    String notificationId,
  ) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('notifications')
          .doc(notificationId)
          .update({'isRead': true});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      final batch = _firestore.batch();
      final snapshot = await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('notifications')
          .where('isRead', isEqualTo: false)
          .get();

      for (var doc in snapshot.docs) {
        batch.update(doc.reference, {'isRead': true});
      }

      await batch.commit();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Delete a notification
  Future<Either<Failure, void>> deleteNotification(
    String userId,
    String notificationId,
  ) async {
    try {
      await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('notifications')
          .doc(notificationId)
          .delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
