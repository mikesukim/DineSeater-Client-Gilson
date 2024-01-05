import 'dart:convert';

import 'package:dineseater_client_gilson/services/waiting_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app/app.locator.dart';
import 'model/waiting_item.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _waiting_storage_service = locator<WaitingStorageService>();

  Future<void> initialize() async {
    // Request permission to receive notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else {
      print(
          'User declined or has not yet granted permission for notifications');
    }

    // Configure how to handle incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      print('Received data: ${message.data}');
      final waiting = json.decode(message.data['waiting']);
      final waitingItem = WaitingItem.fromJson(waiting);
      _waiting_storage_service.updateWaiting(waitingItem);
    });

    // Configure how to handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened: ${message.notification?.title}');
      // Handle notification tap
    });
  }
}
