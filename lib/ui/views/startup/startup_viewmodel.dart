import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../firebase_messaging_service.dart';
import '../../../services/cognito_service.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class StartupViewModel extends BaseViewModel {
  var logger = Logger();
  final _navigationService = locator<NavigationService>();
  final _cognitoService = locator<CognitoService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    // init variables
    final LocalStorage appInitFlagsStorage = LocalStorage('app_init_flags');
    await appInitFlagsStorage.ready;

    // last opened date check
    final lastOpenedDate = appInitFlagsStorage.getItem('lastOpenedDate');
    if (lastOpenedDate == null) {
      appInitFlagsStorage.setItem(
          'lastOpenedDate', DateTime.now().toIso8601String());
      appInitFlagsStorage.setItem('isFirstTimeOfToday', true);
    } else {
      // check if last opened date is yesterday
      final now = DateTime.now();
      final DateTime lastOpenedDate =
          DateTime.parse(appInitFlagsStorage.getItem('lastOpenedDate'));
      if (lastOpenedDate.day != now.day) {
        appInitFlagsStorage.setItem('isFirstTimeOfToday', true);
      }
      appInitFlagsStorage.setItem(
          'lastOpenedDate', DateTime.now().toIso8601String());
    }


    // Firebase messaging init for notification
    try {
      await FirebaseMessagingService().initialize();
    } catch (e) {
      final errorMessage = 'FirebaseMessagingService initialize error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
    }


    // Amplify auth configuration
    try {
      await _cognitoService.configureAmplify();
    } catch (e) {
      final errorMessage = 'configureAmplify error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
    }

    // login check
    final isLoggedIn = await _cognitoService.isUserSignedIn();
    logger.i('isLoggedIn: $isLoggedIn');
    if (!isLoggedIn) {
      try {
        final username = dotenv.env['COGNITO_TESTING_USER_ID']!;
        final password = dotenv.env['COGNITO_TESTING_USER_PASSWORD']!;
        await _cognitoService.signInUser(username, password);
        final idToken = await _cognitoService.getIdToken();
        log('idToken: $idToken');
      } catch (e) {
        final errorMessage = 'signInUser error: $e';
        logger.e(errorMessage);
        setError(errorMessage);
      }
    }

    // device registration for notification
    // registration is done only once after app installation
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      log('Device token: $deviceToken');
      if (appInitFlagsStorage.getItem('isDeviceTokenRegistered') == null ||
          appInitFlagsStorage.getItem('isDeviceTokenRegistered') == false) {
        logger.i("Device token is not registered yet. Registering...");
        _dineSeaterApiService.registerDeviceToken(deviceToken!);
        appInitFlagsStorage.setItem('isDeviceTokenRegistered', true);
        logger.i("Device token is registered.");
      } else {
        logger.i("Device token is already registered.");
      }
    } catch (e) {
      final errorMessage = 'Device token registration error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
    }

    // WaitingStorageService init
    await _waitingStorageService.init();

    // get waiting list from remote
    try {
      if (appInitFlagsStorage.getItem('isFirstTimeOfToday') == null ||
          appInitFlagsStorage.getItem('isFirstTimeOfToday') == true) {
        logger.i("First time of today. Getting waiting list from remote...");
        final waitings = await _dineSeaterApiService.getWaitingList();
        await _waitingStorageService.resetWaitingsAs(waitings);
        appInitFlagsStorage.setItem('isFirstTimeOfToday', false);
        logger.i("Waiting list is updated from remote.");
      } else {
        logger.i(
            "Not first time of today. Getting waiting list from after API...");
        final waitings =
            await _dineSeaterApiService.getWaitingListAfter(DateTime.now());
        await _waitingStorageService.updateWaitings(waitings);
        logger.i("Waiting list is updated.");
      }
    } catch (e) {
      final errorMessage = 'getWaitingList error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
    }

    // Navigate to Home
    _navigationService.replaceWithHomeView();
  }
}
