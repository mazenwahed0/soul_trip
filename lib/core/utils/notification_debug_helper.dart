import 'package:soul_trip/core/caching/hive/models/notification_hive_model.dart';
import 'package:soul_trip/core/caching/hive/notification_hive_helper.dart';

/// Debug helper to add test notifications
class NotificationDebugHelper {
  static Future<void> addTestNotifications() async {
    final helper = NotificationHiveHelper();

    // Clear existing notifications first (optional)
    // await helper.clearAll();

    final now = DateTime.now();

    // Today's notifications
    final notifications = [
      NotificationHiveModel(
        id: 'test_1',
        title: 'Sale On Our Yoga Retreat',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(hours: 2)),
        isRead: false,
        type: 'trip_promotion',
        tripId: 'trip_123',
      ),
      NotificationHiveModel(
        id: 'test_2',
        title: 'New Trips Available',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(hours: 5)),
        isRead: false,
        type: 'trip_promotion',
        tripId: 'trip_456',
      ),

      // Yesterday's notifications
      NotificationHiveModel(
        id: 'test_3',
        title: 'Add To Your Wishlist',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 3)),
        isRead: true,
        type: 'system',
      ),
      NotificationHiveModel(
        id: 'test_4',
        title: 'Share Your Trip Experience',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 10)),
        isRead: false,
        type: 'system',
      ),
      NotificationHiveModel(
        id: 'test_5',
        title: 'Your Purchase Was Successful',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 15)),
        isRead: true,
        type: 'purchase',
      ),

      // 12 December notifications
      NotificationHiveModel(
        id: 'test_6',
        title: 'New Offers Available',
        description:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: DateTime(2024, 12, 12, 14, 30),
        isRead: false,
        type: 'trip_promotion',
      ),
    ];

    await helper.saveNotifications(notifications);
    print('✅ Added ${notifications.length} test notifications!');
  }

  static Future<void> clearAllNotifications() async {
    final helper = NotificationHiveHelper();
    await helper.clearAll();
    print('🗑️ Cleared all notifications!');
  }
}
