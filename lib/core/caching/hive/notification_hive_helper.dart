import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soul_trip/core/caching/hive/models/notification_hive_model.dart';

class NotificationHiveHelper {
  // Singleton instance
  static final NotificationHiveHelper _instance =
      NotificationHiveHelper._internal();

  // Private constructor
  NotificationHiveHelper._internal();

  // Factory constructor to return the same instance
  factory NotificationHiveHelper() => _instance;

  static const String _boxName = 'notifications';

  /// Initialize Hive box for notifications
  static Future<void> init() async {
    try {
      // Register adapter if not already registered
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(NotificationHiveModelAdapter());
      }

      // Open the box
      if (!Hive.isBoxOpen(_boxName)) {
        await Hive.openBox<NotificationHiveModel>(_boxName);
      }

      debugPrint('NotificationHiveHelper initialized successfully');
    } catch (e) {
      debugPrint('Error initializing NotificationHiveHelper: $e');
    }
  }

  /// Get the notifications box
  Box<NotificationHiveModel> get _box {
    return Hive.box<NotificationHiveModel>(_boxName);
  }

  /// Save a single notification
  Future<void> saveNotification(NotificationHiveModel notification) async {
    try {
      await _box.put(notification.id, notification);
      debugPrint('Notification saved: ${notification.id}');
    } catch (e) {
      debugPrint('Error saving notification: $e');
    }
  }

  /// Save multiple notifications
  Future<void> saveNotifications(
    List<NotificationHiveModel> notifications,
  ) async {
    try {
      final Map<String, NotificationHiveModel> notificationMap = {
        for (var notification in notifications) notification.id: notification,
      };
      await _box.putAll(notificationMap);
      debugPrint('Saved ${notifications.length} notifications');
    } catch (e) {
      debugPrint('Error saving notifications: $e');
    }
  }

  /// Get all notifications sorted by timestamp (newest first)
  List<NotificationHiveModel> getAllNotifications() {
    try {
      final notifications = _box.values.toList();
      notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return notifications;
    } catch (e) {
      debugPrint('Error getting all notifications: $e');
      return [];
    }
  }

  /// Watch notifications for real-time updates
  Stream<List<NotificationHiveModel>> watchNotifications() {
    try {
      return _box.watch().map((_) {
        final notifications = _box.values.toList();
        notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return notifications;
      });
    } catch (e) {
      debugPrint('Error watching notifications: $e');
      return Stream.value([]);
    }
  }

  /// Get a single notification by ID
  NotificationHiveModel? getNotification(String id) {
    try {
      return _box.get(id);
    } catch (e) {
      debugPrint('Error getting notification: $e');
      return null;
    }
  }

  /// Get unread notifications count
  int getUnreadCount() {
    try {
      return _box.values.where((notification) => !notification.isRead).length;
    } catch (e) {
      debugPrint('Error getting unread count: $e');
      return 0;
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String id) async {
    try {
      final notification = _box.get(id);
      if (notification != null) {
        final updated = notification.copyWith(isRead: true);
        await _box.put(id, updated);
        debugPrint('Notification marked as read: $id');
      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      final notifications = _box.values.toList();
      final Map<String, NotificationHiveModel> updates = {};

      for (var notification in notifications) {
        if (!notification.isRead) {
          updates[notification.id] = notification.copyWith(isRead: true);
        }
      }

      if (updates.isNotEmpty) {
        await _box.putAll(updates);
        debugPrint('Marked ${updates.length} notifications as read');
      }
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(String id) async {
    try {
      await _box.delete(id);
      debugPrint('Notification deleted: $id');
    } catch (e) {
      debugPrint('Error deleting notification: $e');
    }
  }

  /// Clear all notifications
  Future<void> clearAll() async {
    try {
      await _box.clear();
      debugPrint('All notifications cleared');
    } catch (e) {
      debugPrint('Error clearing notifications: $e');
    }
  }

  /// Close the box (optional, called on app exit)
  Future<void> close() async {
    try {
      await _box.close();
      debugPrint('Notifications box closed');
    } catch (e) {
      debugPrint('Error closing notifications box: $e');
    }
  }
}
