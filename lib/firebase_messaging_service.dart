import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

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
      // Handle the received message
      print('Received data: ${message.data}');
    });

    // Configure how to handle notification taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened: ${message.notification?.title}');
      // Handle notification tap
    });
  }
}
