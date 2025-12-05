import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:soul_trip/core/caching/hive/models/notification_hive_model.dart';
import 'package:soul_trip/core/caching/hive/notification_hive_helper.dart';
import 'package:soul_trip/core/errors/failures.dart';
import 'package:soul_trip/core/models/notification_model.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationHiveHelper _hiveHelper;

  NotificationRepository(this._hiveHelper);

  /// Save notification from FCM to local storage
  Future<void> saveNotificationFromFCM(RemoteMessage message) async {
    try {
      final notification = NotificationHiveModel(
        id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: message.notification?.title ?? '',
        description: message.notification?.body ?? '',
        timestamp: DateTime.now(),
        isRead: false,
        tripId: message.data['tripId'] as String?,
        type: message.data['type'] as String? ?? 'trip_promotion',
        imageUrl: message.data['imageUrl'] as String?,
      );

      await _hiveHelper.saveNotification(notification);
      debugPrint('Notification saved from FCM: ${notification.id}');
    } catch (e) {
      debugPrint('Error saving notification from FCM: $e');
    }
  }

  /// Fetch notifications - Load from Hive first (instant), then optionally sync with Firestore
  Future<Either<Failure, List<NotificationModel>>> fetchNotifications(
    String userId, {
    bool syncWithFirestore = false,
  }) async {
    try {
      // Always load from Hive first for instant results
      final hiveNotifications = _hiveHelper.getAllNotifications();
      final notificationModels = hiveNotifications
          .map((hive) => _convertHiveToModel(hive))
          .toList();

      // Optionally sync with Firestore in background
      if (syncWithFirestore) {
        _syncWithFirestore(userId);
      }

      return Right(notificationModels);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Stream notifications from Hive (for real-time UI updates)
  Stream<Either<Failure, List<NotificationModel>>> streamNotifications(
    String userId,
  ) async* {
    try {
      // Initial load from Hive
      yield await fetchNotifications(userId);

      // Optionally: Stream from Firestore for cross-device sync
      // For now, we'll rely on FCM to update local storage
      yield* Stream.periodic(const Duration(seconds: 1), (_) {
        final hiveNotifications = _hiveHelper.getAllNotifications();
        final notificationModels = hiveNotifications
            .map((hive) => _convertHiveToModel(hive))
            .toList();
        return Right<Failure, List<NotificationModel>>(notificationModels);
      });
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }

  /// Background sync with Firestore (optional)
  Future<void> _syncWithFirestore(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final firestoreNotifications = snapshot.docs
            .map((doc) => NotificationHiveModel.fromNotificationModel({
                  'id': doc.id,
                  ...doc.data(),
                  'timestamp': (doc.data()['timestamp'] as Timestamp?)?.toDate(),
                }))
            .toList();

        await _hiveHelper.saveNotifications(firestoreNotifications);
        debugPrint('Synced ${firestoreNotifications.length} notifications from Firestore');
      }
    } catch (e) {
      debugPrint('Error syncing with Firestore: $e');
    }
  }

  /// Mark a notification as read
  Future<Either<Failure, void>> markAsRead(
    String userId,
    String notificationId,
  ) async {
    try {
      // Update local storage first
      await _hiveHelper.markAsRead(notificationId);

      // Optionally update Firestore in background
      _updateFirestoreInBackground(userId, notificationId, {'isRead': true});

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      // Update local storage first
      await _hiveHelper.markAllAsRead();

      // Optionally update Firestore in background
      _updateAllFirestoreInBackground(userId, {'isRead': true});

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
      // Delete from local storage first
      await _hiveHelper.deleteNotification(notificationId);

      // Optionally delete from Firestore in background
      _deleteFromFirestoreInBackground(userId, notificationId);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Get unread count
  int getUnreadCount() {
    return _hiveHelper.getUnreadCount();
  }

  /// Background Firestore update (non-blocking)
  void _updateFirestoreInBackground(
    String userId,
    String notificationId,
    Map<String, dynamic> updates,
  ) {
    _firestore
        .collection('notifications')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .update(updates)
        .catchError((e) {
      debugPrint('Error updating Firestore in background: $e');
    });
  }

  /// Background Firestore batch update (non-blocking)
  void _updateAllFirestoreInBackground(
    String userId,
    Map<String, dynamic> updates,
  ) {
    _firestore
        .collection('notifications')
        .doc(userId)
        .collection('notifications')
        .where('isRead', isEqualTo: false)
        .get()
        .then((snapshot) {
      final batch = _firestore.batch();
      for (var doc in snapshot.docs) {
        batch.update(doc.reference, updates);
      }
      return batch.commit();
    }).catchError((e) {
      debugPrint('Error updating all in Firestore: $e');
    });
  }

  /// Background Firestore delete (non-blocking)
  void _deleteFromFirestoreInBackground(
    String userId,
    String notificationId,
  ) {
    _firestore
        .collection('notifications')
        .doc(userId)
        .collection('notifications')
        .doc(notificationId)
        .delete()
        .catchError((e) {
      debugPrint('Error deleting from Firestore: $e');
    });
  }

  /// Helper: Convert Hive model to NotificationModel
  NotificationModel _convertHiveToModel(NotificationHiveModel hive) {
    return NotificationModel(
      id: hive.id,
      title: hive.title,
      description: hive.description,
      timestamp: hive.timestamp,
      isRead: hive.isRead,
      tripId: hive.tripId,
      type: hive.type,
      imageUrl: hive.imageUrl,
    );
  }
}

