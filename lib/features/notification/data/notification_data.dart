import 'package:soul_trip/core/models/notification_model.dart';

class NotificationData {
  static List<NotificationModel> getDummyNotifications() {
    final now = DateTime.now();

    return [
      // Today notifications
      NotificationModel(
        id: '1',
        title: 'Sale On Our Yoga Retreat',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(hours: 1)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: 'New Trips Available',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(hours: 1)),
        isRead: false,
      ),

      // Yesterday notifications
      NotificationModel(
        id: '3',
        title: 'Add To Your Wishlist',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        isRead: true,
      ),
      NotificationModel(
        id: '4',
        title: 'Share Your review',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        isRead: true,
      ),
      NotificationModel(
        id: '5',
        title: 'Your Purchase Was Successful',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: now.subtract(const Duration(days: 1, hours: 8)),
        isRead: true,
      ),

      // Older notification (12 October example)
      NotificationModel(
        id: '6',
        title: 'New Offers Available',
        description:
            'Lorem ipsum is simply dummy text of the printing and typesetting industry',
        timestamp: DateTime(now.year, 10, 12, 10, 30),
        isRead: true,
      ),
    ];
  }
}
