import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_trip/features/notification/data/repositories/notification_repository.dart';

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  NotificationRepository? _notificationRepository;
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  /// Set notification repository after DI setup
  void setNotificationRepository(NotificationRepository repository) {
    _notificationRepository = repository;
  }

  /// Initialize FCM service
  Future<void> initialize() async {
    try {
      // Request permission
      await _requestPermission();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Get FCM token
      await _getFCMToken();

      // Setup message handlers
      _setupMessageHandlers();

      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      debugPrint('FCM Service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
    }
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Get FCM token
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $_fcmToken');

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('FCM Token refreshed: $newToken');
        // TODO: Update token in Firestore
      });
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Setup message handlers
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Background message tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageTap);

    // Check if app was opened from terminated state
    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessageTap(message);
      }
    });
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Foreground message received: ${message.messageId}');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');

    final notification = message.notification;
    if (notification != null) {
      await _showLocalNotification(
        title: notification.title ?? 'New Notification',
        body: notification.body ?? '',
        payload: message.data.toString(),
      );
    }

    // Save notification to local Hive storage via repository
    if (_notificationRepository != null) {
      await _notificationRepository!.saveNotificationFromFCM(message);
      debugPrint('Notification saved to Hive via repository');
    } else {
      debugPrint('Warning: NotificationRepository not set!');
    }
  }

  /// Handle message tap (background or terminated)
  void _handleMessageTap(RemoteMessage message) async {
    debugPrint('Message tapped: ${message.messageId}');

    // Save notification if not already saved
    if (_notificationRepository != null) {
      await _notificationRepository!.saveNotificationFromFCM(message);
    }

    // TODO: Navigate to trip details if tripId exists
    final tripId = message.data['tripId'];
    if (tripId != null) {
      debugPrint('Navigate to trip: $tripId');
      // Navigation will be handled in main.dart
    }
  }

  /// Handle local notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Local notification tapped: ${response.payload}');
    // TODO: Handle navigation based on payload
  }

  /// Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'trip_notifications',
      'Trip Notifications',
      channelDescription: 'Notifications about new trips and offers',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Save FCM token to Firestore for a user
  Future<void> saveFCMToken(String userId) async {
    if (_fcmToken == null) return;

    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'fcmToken': _fcmToken,
        'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
      });
      debugPrint('FCM token saved for user: $userId');
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  /// Remove FCM token from Firestore (on logout)
  Future<void> removeFCMToken(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'fcmToken': FieldValue.delete(),
      });
      debugPrint('FCM token removed for user: $userId');
    } catch (e) {
      debugPrint('Error removing FCM token: $e');
    }
  }
}
