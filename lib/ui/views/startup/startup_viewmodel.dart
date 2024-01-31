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


    final appInitFlagsStorageName = 'app_init_flags_${dotenv.env['STAGE']}';
    logger.i(appInitFlagsStorageName);
    final LocalStorage appInitFlagsStorage = LocalStorage(appInitFlagsStorageName);
    try {
      // init variables
      await appInitFlagsStorage.ready;
      // last opened date check
      final lastOpenedDate = await appInitFlagsStorage.getItem('lastOpenedDate');
      if (lastOpenedDate == null) {
        await appInitFlagsStorage.setItem(
            'lastOpenedDate', DateTime.now().toIso8601String());
        await appInitFlagsStorage.setItem('isFirstTimeOfToday', true);
      } else {
        // check if last opened date is yesterday
        final now = DateTime.now();
        final DateTime lastOpenedDate =
        DateTime.parse(await appInitFlagsStorage.getItem('lastOpenedDate'));
        if (lastOpenedDate.day != now.day) {
          await appInitFlagsStorage.setItem('isFirstTimeOfToday', true);
        }
        await appInitFlagsStorage.setItem(
            'lastOpenedDate', DateTime.now().toIso8601String());
      }
    } catch (e) {
      final errorMessage = 'runStartupLogic error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
      rethrow;
    }

    // Firebase messaging init for notification
    try {
      await FirebaseMessagingService().initialize();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      final errorMessage = 'FirebaseMessagingService initialize error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
      rethrow;
    }

    // Amplify auth configuration
    try {
      await _cognitoService.configureAmplify();
    } catch (e) {
      final errorMessage = 'configureAmplify error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
      rethrow;
    }

    // login check
    final isLoggedIn = await _cognitoService.isUserSignedIn();
    logger.i('isLoggedIn: $isLoggedIn');
    if (!isLoggedIn) {
      try {
        final username = dotenv.env['COGNITO_GILSON_USER_ID']!;
        final password = dotenv.env['COGNITO_GILSON_USER_PASSWORD']!;
        await _cognitoService.signInUser(username, password);
      } catch (e) {
        final errorMessage = 'signInUser error: $e';
        logger.e(errorMessage);
        setError(errorMessage);
        rethrow;
      }
    }
    final idToken = await _cognitoService.getIdToken();
    log('idToken: $idToken');

    // device registration for notification
    // registration is done only once after app installation
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      log('Device token: $deviceToken');
      if (await appInitFlagsStorage.getItem('isDeviceTokenRegistered') == null ||
          await appInitFlagsStorage.getItem('isDeviceTokenRegistered') == false) {
        logger.i("Device token is not registered yet. Registering...");
        _dineSeaterApiService.registerDeviceToken(deviceToken!);
        await appInitFlagsStorage.setItem('isDeviceTokenRegistered', true);
        logger.i("Device token is registered.");
      } else {
        logger.i("Device token is already registered.");
      }
    } catch (e) {
      final errorMessage = 'Device token registration error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
      rethrow;
    }

    // WaitingStorageService init
    await _waitingStorageService.init();

    // get waiting list from remote
    try {
      if (await appInitFlagsStorage.getItem('isFirstTimeOfToday') == null ||
          await appInitFlagsStorage.getItem('isFirstTimeOfToday') == true) {
        logger.i("First time of today. Getting waiting list from remote...");
        final waitings = await _dineSeaterApiService.getWaitingList();
        await _waitingStorageService.resetWaitingsAs(waitings);
        await appInitFlagsStorage.setItem('isFirstTimeOfToday', false);
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
      rethrow;
    }

    // Navigate to Home
    _navigationService.replaceWithHomeView();
  }
}
