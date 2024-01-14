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

    // TODO : know how to receive notifications while app is not running at all.
    // if this implemented, then every post request when app is launch is not needed.

    // Configure how to handle incoming notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.title}');
      _updateSingleWaiting(message);
    });


    // Due to AWS SNS limitation when sending FCM Data message Type, receiving notification while app is not running is not possible.
    // thus, handling notification when app is not foreground is ignored, instead, when app state is resumed, it will fetch the waiting list from server.
    // https://firebase.google.com/docs/cloud-messaging/concept-options#notifications_and_data_messages

    // handling when user clicks the notification
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    //   print('Received message: ${message.notification?.title}');
    // });

    // handling background update
    // however backgound update should not be used for this app, due to apple's limitation that the priority of the notification only can be low.
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  void _updateSingleWaiting(RemoteMessage message) {
    print('Received data: ${message.data}');
    final waiting = json.decode(message.data['waiting']);
    final waitingItem = WaitingItem.fromJson(waiting);
    _waiting_storage_service.updatingWiatingFromNotification(waitingItem);
  }
}
