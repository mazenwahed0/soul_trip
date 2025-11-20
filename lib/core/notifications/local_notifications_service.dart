// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

// class LocalNotificationService {
//   static final LocalNotificationService _instance =
//       LocalNotificationService._();
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   factory LocalNotificationService() => _instance;

//   LocalNotificationService._();

//   // Initialize notification service with proper timezone setup
//   Future<void> initialize() async {
//     try {
//       // Initialize timezone data
//       tz.initializeTimeZones();

//       const AndroidInitializationSettings androidSettings =
//           AndroidInitializationSettings('@mipmap/ic_launcher');
//       const DarwinInitializationSettings iosSettings =
//           DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );

//       const InitializationSettings initializationSettings =
//           InitializationSettings(
//         android: androidSettings,
//         iOS: iosSettings,
//       );

//       await _flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: (NotificationResponse response) {
//           if (response.payload != null) {
//             print('Notification tapped with payload: ${response.payload}');
//             // Handle navigation here
//           }
//         },
//       );

//       print('LocalNotificationService initialized successfully');
//     } catch (e) {
//       print('Error initializing LocalNotificationService: $e');
//     }
//   }

//   // Request Android 13+ notification permissions
//   Future<bool> requestAndroidPermissions() async {
//     if (Platform.isAndroid) {
//       try {
//         // Check current permission status
//         final status = await Permission.notification.status;

//         if (!status.isGranted) {
//           // Request permission
//           final result = await Permission.notification.request();
//           print('Android notification permission granted: ${result.isGranted}');
//           return result.isGranted;
//         } else {
//           print('Android notification permission already granted');
//           return true;
//         }
//       } catch (e) {
//         print('Error requesting Android permissions: $e');
//         return false;
//       }
//     }
//     return true;
//   }

//   // Request iOS notification permissions
//   Future<bool?> requestIOSPermissions() async {
//     if (Platform.isIOS) {
//       try {
//         final bool? granted = await _flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//                 IOSFlutterLocalNotificationsPlugin>()
//             ?.requestPermissions(
//               alert: true,
//               badge: true,
//               sound: true,
//             );
//         print('iOS notification permission granted: $granted');
//         return granted;
//       } catch (e) {
//         print('Error requesting iOS permissions: $e');
//         return false;
//       }
//     }
//     return true;
//   }

//   // Check if notifications are enabled
//   Future<bool> areNotificationsEnabled() async {
//     if (Platform.isAndroid) {
//       final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
//           _flutterLocalNotificationsPlugin
//               .resolvePlatformSpecificImplementation<
//                   AndroidFlutterLocalNotificationsPlugin>();
//       return await androidImplementation?.areNotificationsEnabled() ?? false;
//     }
//     return true; // iOS permissions are handled differently
//   }

//   // Show immediate notification
//   Future<void> showNotification({
//     required int id,
//     required String title,
//     required String body,
//     String? payload,
//     String channelId = 'weather_notification_channel',
//     String channelName = 'Weather Notifications',
//     String channelDescription = 'Daily weather-based plant care notifications',
//   }) async {
//     try {
//       print('Attempting to show notification: $title');

//       final AndroidNotificationDetails androidDetails =
//           AndroidNotificationDetails(
//         channelId,
//         channelName,
//         channelDescription: channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: true,
//         enableVibration: true,
//         playSound: true,
//       );

//       const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );

//       final NotificationDetails platformDetails =
//           NotificationDetails(android: androidDetails, iOS: iosDetails);

//       await _flutterLocalNotificationsPlugin
//           .show(id, title, body, platformDetails, payload: payload);

//       print('Notification shown successfully with ID: $id');
//     } catch (e) {
//       print('Error showing notification: $e');
//     }
//   }

//   // Schedule notification with timezone support
//   Future<void> scheduleNotification({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//     String? payload,
//     String channelId = 'weather_notification_channel',
//     String channelName = 'Weather Notifications',
//     String channelDescription = 'Daily weather-based plant care notifications',
//   }) async {
//     try {
//       print('Scheduling notification for: $scheduledTime');

//       final AndroidNotificationDetails androidDetails =
//           AndroidNotificationDetails(
//         channelId,
//         channelName,
//         channelDescription: channelDescription,
//         importance: Importance.max,
//         priority: Priority.high,
//         showWhen: true,
//         enableVibration: true,
//         playSound: true,
//       );

//       const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );

//       final NotificationDetails platformDetails =
//           NotificationDetails(android: androidDetails, iOS: iosDetails);

//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         tz.TZDateTime.from(scheduledTime, tz.local),
//         platformDetails,
//         payload: payload,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         matchDateTimeComponents: DateTimeComponents.time,
//         // شيل الـ line ده خالص
//         // uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       );

//       print('Notification scheduled successfully with ID: $id');
//     } catch (e) {
//       print('Error scheduling notification: $e');
//     }
//   }

//   // Cancel specific notification
//   Future<void> cancelNotification(int id) async {
//     try {
//       await _flutterLocalNotificationsPlugin.cancel(id);
//       print('Notification cancelled with ID: $id');
//     } catch (e) {
//       print('Error cancelling notification: $e');
//     }
//   }

//   // Cancel all notifications
//   Future<void> cancelAllNotifications() async {
//     try {
//       await _flutterLocalNotificationsPlugin.cancelAll();
//       print('All notifications cancelled');
//     } catch (e) {
//       print('Error cancelling all notifications: $e');
//     }
//   }

//   // Get pending notifications
//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     try {
//       return await _flutterLocalNotificationsPlugin
//           .pendingNotificationRequests();
//     } catch (e) {
//       print('Error getting pending notifications: $e');
//       return [];
//     }
//   }
// }
